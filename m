Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbUEFGrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUEFGrk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 02:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUEFGq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 02:46:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48586 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261791AbUEFGqR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 02:46:17 -0400
Date: Thu, 6 May 2004 07:46:17 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Tim Hockin <thockin@hockin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lazy-umount cwd and ..
Message-ID: <20040506064617.GQ17014@parcelfarce.linux.theplanet.co.uk>
References: <20040506044433.GA13933@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506044433.GA13933@hockin.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 09:44:33PM -0700, Tim Hockin wrote:
> I notice that a process that is in a dir which gets lazy-unmounted
> suddenly sees it's current dir change and its '..' dir points back to
> itself.
> 
> I'm not sure it's a huge deal, but we have a half-patch floating around
> that changes the behavior such that the unmounted mnt->mnt_parent is
> retained and unreferenced when the mnt is finally released.  This seems to
> make any process which is in the unmounted mount not see anything
> different, but does not let any new processes into the mount.
> 
> Minor, but friendly.
> 
> Should I bother to polish this patch off and send it, or is it just not
> something we want to care about?

No.  This is simply wrong - one of the situations when you want lazy-umount
is getting a stuck filesystem (e.g. NFS mounted hard) and wanting to get
it out of the way, so that stuff it's mounted on could be unmounted clean.

So we definitely don't want to keep anything pinned down.
