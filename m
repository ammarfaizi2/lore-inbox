Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVBITsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVBITsQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 14:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVBITsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 14:48:16 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:25013 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261888AbVBITrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 14:47:45 -0500
Date: Wed, 9 Feb 2005 19:46:29 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Chris Wright <chrisw@osdl.org>
cc: "Mark F. Haigh" <Mark.Haigh@SpirentCom.COM>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/fork.c: VM accounting bugfix (2.6.11-rc3-bk5)
In-Reply-To: <20050209112846.A24171@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.61.0502091932500.7544@goblin.wat.veritas.com>
References: <420988C1.5030408@spirentcom.com> 
    <20050208230447.V24171@build.pdx.osdl.net> 
    <Pine.LNX.4.61.0502091223310.5842@goblin.wat.veritas.com> 
    <20050209112846.A24171@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005, Chris Wright wrote:

> * Hugh Dickins (hugh@veritas.com) wrote:
> > dup_mmap's charge starts out at 0 and gets added to each time around
> > the loop through vmas; if security_vm_enough_memory fails at any point
> > in that loop, we need to vm_unacct_memory the charge already accumulated.
> 
> If that's the requirement, then it's broken as is, because there is
> nothing accumulating.  len is re-determined each pass, and charge is
> reset each pass.

You're right, it's me who's wrong, sorry.  I was remembering how it
was before 2.6.7, when Oleg pointed out that it was doubly unaccounting
(and it's probably me who was guilty of that double unaccounting too).

> But I think that it's ok, as we only care about the
> last pass.  If dup_mmap() fails part way through, the cleanup path should
> call unaccount for the (potentially) accounted by not fully setup vma then
> call exit_mmap() and clear all the vmas that got accounted for already.

Yes, that was Oleg's point when he fixed it.

> Either way, Mark's patch is not needed, and I don't think anything needs
> patching in this area.  Hugh, do you agree?

Yes I agree - thanks for clearing that up, Chris.

Hugh
