Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVIMV5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVIMV5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVIMV5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:57:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:10944 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932493AbVIMV5K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:57:10 -0400
Date: Tue, 13 Sep 2005 22:57:04 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Sripathi Kodi <sripathik@in.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, patrics@interia.pl,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
Message-ID: <20050913215704.GV25261@ZenIV.linux.org.uk>
References: <4325BEF3.2070901@in.ibm.com> <20050912134954.7bbd15b2.akpm@osdl.org> <4326CFE2.6000908@in.ibm.com> <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org> <20050913165102.GR25261@ZenIV.linux.org.uk> <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org> <20050913171215.GS25261@ZenIV.linux.org.uk> <43274503.7090303@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43274503.7090303@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 04:30:43PM -0500, Sripathi Kodi wrote:
> Al Viro wrote:
> >
> >Well...  If exposing the list of tasks in a group is OK, we can just leave
> >->permission NULL for that sucker.  If it's not (and arguably it can be
> >sensitive information), we have a bigger problem - right now chroot 
> >boundary
> >is the only control we have there; normally anyone can ls 
> >/proc/<whatever>/task
> >and see other threads.
> >
> 
> Al, I understand that we can't set ->permission to NULL as it removes the 
> chroot boundary check. If I understood you correctly, we need to put 
> additional checks in proc_permission to ensure anyone doing ls 
> /proc/<pid>/task won't be able to see other threads.

Wrong.  We need a separate function, _not_ modifying proc_permssion().
If we need ->permission() at all, that is - note that anyone can do
ls /proc/<pid>/task on other users' process.
