Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWJHCDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWJHCDW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 22:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWJHCDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 22:03:22 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:45515 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1750740AbWJHCDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 22:03:21 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Really good idea to allow mmap(0, FIXED)?
Date: Sun, 8 Oct 2006 02:03:07 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <eg9m8r$8lf$1@taverner.cs.berkeley.edu>
References: <200610052059.11714.mb@bu3sch.de> <1160119515.3000.89.camel@laptopd505.fenrus.org> <eg6bk4$7r1$1@taverner.cs.berkeley.edu> <452844AB.2050406@goop.org>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1160272987 8879 128.32.168.222 (8 Oct 2006 02:03:07 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Sun, 8 Oct 2006 02:03:07 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge  wrote:
>David Wagner wrote:
>> Oops.  Please ignore the PROT_EXEC.  That is completely irrelevant.
>
>Though (*something_ops->thingy)() becomes a lot more interesting if 
>something_ops or ->thingy is NULL...

If something_ops is NULL, catastrophic consequences ensue either way.
It's just as bad even if address 0 isn't mmap'ed with PROT_EXEC.  For
example, suppose that .thingy is at offset 0x14 (say) and something_ops
is NULL.  Then (*something_ops->thingy)() reads 4 bytes from address
0x14, treats what the 4 bytes read as an address, and transfers control
to that address.  (On a 32-bit x86.)  Since the latter address is under
the attacker's control, this means that the kernel has just transferred
control to an address of the attacker's choosing -- not good.

As you say, if something_ops->thingy is NULL, then mmap'ing address 0
with PROT_EXEC allows evil consequences.
