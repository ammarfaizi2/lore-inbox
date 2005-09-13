Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVIMRMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVIMRMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbVIMRMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:12:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56044 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964905AbVIMRMW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:12:22 -0400
Date: Tue, 13 Sep 2005 18:12:15 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sripathi Kodi <sripathik@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, patrics@interia.pl,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
Message-ID: <20050913171215.GS25261@ZenIV.linux.org.uk>
References: <4325BEF3.2070901@in.ibm.com> <20050912134954.7bbd15b2.akpm@osdl.org> <4326CFE2.6000908@in.ibm.com> <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org> <20050913165102.GR25261@ZenIV.linux.org.uk> <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 10:01:58AM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 13 Sep 2005, Al Viro wrote:
> > 
> > What we need is to decide what kind of access control do we really want on
> > /proc/<pid>/task.  That's it.
> 
> I don't think any controls at all. The real control should then be on the
> /proc/<pid>/task/<tid> access, which should be the same as the /proc/<pid>
> controls (except for thread <tid> rather than thread <pid>, of course)

Well...  If exposing the list of tasks in a group is OK, we can just leave
->permission NULL for that sucker.  If it's not (and arguably it can be
sensitive information), we have a bigger problem - right now chroot boundary
is the only control we have there; normally anyone can ls /proc/<whatever>/task
and see other threads.
