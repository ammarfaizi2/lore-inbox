Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265901AbUAHSc5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265908AbUAHSc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:32:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28630 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265901AbUAHSbk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:31:40 -0500
Date: Thu, 8 Jan 2004 18:31:35 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ian Kent <raven@themaw.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jim Carter <jimc@math.ucla.edu>,
       "Ogden, Aaron A." <aogden@unocal.com>, thockin@sun.com,
       autofs mailing list <autofs@linux.kernel.org>,
       Mike Waychison <Michael.Waychison@sun.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Message-ID: <20040108183135.GE30321@parcelfarce.linux.theplanet.co.uk>
References: <3FFC96FE.9050002@zytor.com> <Pine.LNX.4.44.0401082050210.354-100000@donald.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401082050210.354-100000@donald.themaw.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 08:52:31PM +0800, Ian Kent wrote:
> On Wed, 7 Jan 2004, H. Peter Anvin wrote:
> 
> >
> > These are the mount traps Al Viro has been architecting.
> >
> 
> Please tell me about these.
> 
> I have`nt seen any discussion on the implementation.
> 
> Just a few sentences ....

Special vfsmount mounted somewhere; has no superblock associated with it;
attempt to step on it triggers event; normal result of that event is to
get a normal mount on top of it, at which point usual chaining logics
will make sure that we don't see the trap until it's uncovered by removal
of covering filesystem.  Trap (and everything mounted on it, etc.) can
be removed by normal lazy umount.

Basically, it's a single-point analog of autofs done entirely in VFS.
The job of automounter is to maintain the traps and react to events.

And yes, I should've done that months ago.  Waaaaay too long backlog -
bdev work, dev_t stuff, netdev, yadda, yadda.
