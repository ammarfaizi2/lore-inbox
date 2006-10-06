Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWJFTnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWJFTnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWJFTnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:43:11 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:11429 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S932463AbWJFTnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:43:09 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Really good idea to allow mmap(0, FIXED)?
Date: Fri, 6 Oct 2006 19:43:00 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <eg6bk4$7r1$1@taverner.cs.berkeley.edu>
References: <200610052059.11714.mb@bu3sch.de> <eg4624$be$1@taverner.cs.berkeley.edu> <1160119515.3000.89.camel@laptopd505.fenrus.org>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1160163780 8033 128.32.168.222 (6 Oct 2006 19:43:00 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Fri, 6 Oct 2006 19:43:00 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven  wrote:
>> Let me see if I understand.  If the kernel does this somewhere:
>> 
>>     struct s *foo;
>>     foo->x->y = 0;
>> 
>> and if there is some way that userland code can cause this to be
>> executed with 'foo' set to a NULL pointer, then user-land code can
>> do this:
>> 
>>     mmap(0, 4096, PROT_READ|PROT_EXEC|PROT_WRITE,
>>         MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
>>     struct s *bar = 0;
>
>the question isn't if it's a good idea to allow mmap(0) but to allow
>mmap PROT_WRITE | PROT_EXEC !

Oops.  Please ignore the PROT_EXEC.  That is completely irrelevant.
I'm sorry I included it; the inclusion of PROT_EXEC was a mistake.
Delete PROT_EXEC, then re-read my email -- everything else in there is
still valid.

The security exploit I explained didn't involve executing anything
from the mmap'ed page; the kernel reads an address from this page,
and then dereferences it.  Even without PROT_EXEC, it sounds like a
user-triggerable NULL pointer dereference in the kernel can create a
local root exploit (at least in some cases).
