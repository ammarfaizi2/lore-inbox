Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbTKSH3I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 02:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTKSH3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 02:29:08 -0500
Received: from [203.88.135.194] ([203.88.135.194]:38855 "EHLO elitecore.com")
	by vger.kernel.org with ESMTP id S263879AbTKSH26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 02:28:58 -0500
Message-ID: <00b001c3ae6e$c5e80a60$3901a8c0@elite.co.in>
From: "Sumit Pandya" <sumit@elitecore.com>
To: <linux-kernel@vger.kernel.org>
Cc: <joern@wh.fh-wedel.de>
Subject: Infinite do_IRQ
Date: Wed, 19 Nov 2003 12:58:48 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
    I'm running 2.4.22 kernel on Pentium-III processor with following few
patches
    1. ebtables-brnf-3_vs_2.4.22.diff
    2. routes-2.4.22-9.diff (Julean's DGD)
    3. nfnetlink-ctnetlink-0.12-2.patch
    4. htb_3.12_3.13.diff

    After running it for few time suddenly it hangs and I get continuous
"do_IRQ: stack overflow:" messages on my serial console. I'm using ttywatch
for reading console output on other Linux System.

    Following is a snapshot of those messages

do_IRQ: stack overflow: -940
c024caa8 fffffc54 00000018 00000003 c7e551fa c7e551f7 c02c6270 c024a588
       00000003 c7e551f7 00000009 c7e551fa c7e551f7 c02c6270 c7e55200
c0110018
       c7e50018 ffffff00 c8867db0 00000010 00000286 c8867a2a c7e551fa
c7e551fd
Call Trace:    [<c0110018>] [<c8867db0>] [<c8867a2a>] [<c011a9e0>]
[<c886a4ef>]
  [<c8867b72>] [<c011a9e0>] [<c886a4ef>] [<c8867bd7>] [<c886a4ef>]
[<c8867ba5>]
  [<c886a4ee>] [<c8867bd7>] [<c886a4ee>] [<c8867b72>] [<c011a9e0>]
[<c886a4ee>]
  [<c8867bd7>] [<c011a9e0>] [<c886a4ee>] [<c8867ba5>] [<c886a4ed>]
[<c8867bd7>]
  [<c886a4ed>] [<c8867b72>] [<c886a4ed>] [<c8867bd7>] [<c011b170>]
[<c886a4ed>]
  [<c8867ba5>] [<c886a4ec>] [<c8867bd7>] [<c886a4ec>] [<c8867b72>]
[<c886a4ec>]
  [<c8867bd7>] [<c886a4ec>] [<c8867ba5>] [<c886a4eb>] [<c8867bd7>]
[<c886a4eb>]
  [<c8867b72>] [<c886a4eb>] [<c8867bd7>] [<c886a4eb>] [<c8867ba5>]
[<c886a4ea>]
  [<c8867bd7>] [<c886a4ea>] [<c8867b72>] [<c023a160>] [<c886a4ea>]
[<c8867bd7>]
  [<c023b280>] [<c023b540>] [<c023ba30>] [<c023bd80>] [<c023be10>]
[<c886a4ea>]
  [<c8867ba5>] [<c023c8f0>] [<c01f9760>] [<c01f9770>] [<c886a4e9>]
[<c8867bd7>]
  [<c023b860>] [<c023bd80>] [<c01f9640>] [<c023bef0>] [<c01fc590>]
[<c886a4e9>]
  [<c8867b72>] [<c01f9760>] [<c01f9770>] [<c023b200>] [<c886a4e9>]
[<c8867bd7>]
  [<c886a4e9>] [<c8867ba5>] [<c886a4e8>] [<c8867bd7>] [<c886a4e8>]
[<c8867b72>]
  [<c886a4e8>] [<c8867bd7>] [<c886a4e8>] [<c8867ba5>] [<c023df70>]
[<c023e220>]
  [<c886a4e7>] [<c8867bd7>] [<c01f96a0>] [<c01f96b0>] [<c023d870>]
[<c023e4d0>]
  [<c01f9760>] [<c886a4e7>] [<c8867b72>] [<c023df70>] [<c023e2b0>]
[<c01f9620>]
  [<c01f9630>] [<c886a4e7>] [<c8867bd7>] [<c023ebd0>] [<c023dd10>]
[<c023e4d0>]
  [<c01f9760>] [<c01f9770>] [<c886a4e7>] [<c8867ba5>] [<c886a4e6>]
[<c8867bd7>]
  [<c886a4e6>] [<c8867b72>] [<c886a4e6>] [<c8867bd7>] [<c886a4e6>]
[<c8867ba5>]
  [<c886a4e5>] [<c8867bd7>] [<c886a4e5>] [<c8867b72>] [<c886a4e5>]
[<c8867bd7>]
  [<c886a4e5>] [<c8867ba5>] [<c886a4e4>] [<c8867bd7>] [<c886a4e4>]
[<c8867b72>]
  [<c886a4e4>] [<c8867bd7>] [<c886a4e4>] [<c8867ba5>] [<c886a4e3>]
[<c8867bd7>]
  [<c886a4e3>] [<c8867b72>] [<c886a4e3>] [<c8867bd7>] [<c886a4e3>]
[<c8867ba5>]
  [<c886a4e2>] [<c8867bd7>] [<c886a4e2>] [<c8867b72>] [<c886a4e2>]
[<c8867bd7>]
  [<c886a4e2>] [<c8867ba5>] [<c886a4e1>] [<c8867bd7>] [<c886a4e1>]
[<c8867b72>]
  [<c886a4e1>] [<c8867bd7>] [<c886a4e1>] [<c8867ba5>] [<c886a4e0>]
[<c8867bd7>]
  [<c886a4e0>] [<c8867b72>] [<c886a4e0>] [<c8867bd7>] [<c886a4e0>]
[<c8867ba5>]
  [<c886a4df>] [<c8867bd7>] [<c886a4df>] [<c8867b72>] [<c886a4df>]
[<c8867bd7>]
  [<c886a4df>] [<c8867ba5>] [<c886a4de>] [<c8867bd7>] [<c886a4de>]
[<c8867b72>]
  [<c886a4de>] [<c8867bd7>] [<c886a4de>] [<c8867ba5>] [<c886a4dd>]
[<c8867bd7>]
  [<c886a4dd>] [<c8867b72>] [<c886a4dd>] [<c8867bd7>] [<c886a4dd>]
[<c8867ba5>]
  [<c886a4dc>] [<c8867bd7>] [<c886a4dc>] [<c8867b72>] [<c886a4dc>]
[<c8867bd7>]
  [<c886a4dc>] [<c8867ba5>] [<c886a4db>] [<c8867bd7>] [<c886a4db>]
[<c8867b72>]
  [<c886a4db>] [<c8867bd7>] [<c886a4db>] [<c8867ba5>] [<c886a4da>]
[<c8867bd7>]
  [<c886a4da>] [<c8867b72>] [<c886a4da>] [<c8867bd7>] [<c886a4da>]
[<c8867ba5>]
  [<c886a4d9>] [<c8867bd7>] [<c886a4d9>] [<c8867b72>] [<c886a4d9>]
[<c8867bd7>]
  [<c886a4d9>] [<c8867ba5>] [<c886a4d8>] [<c8867bd7>] [<c886a4d8>]
[<c8867b72>]
  [<c886a4d8>] [<c8867bd7>] [<c886a4d8>] [<c8867ba5>] [<c886a4d7>]
[<c8867bd7>]
  [<c886a4d7>] [<c8867b72>] [<c886a4d7>] [<c8867bd7>] [<c886a4d7>]
[<c8867ba5>]
  [<c886a4d6>] [<c8867bd7>] [<c886a4d6>] [<c8867b72>] [<c886a4d6>]
[<c8867bd7>]
  [<c886a4d6>] [<c8867ba5>] [<c886a4d5>] [<c8867bd7>] [<c886a4d5>]
[<c8867b72>]
  [<c886a4d5>] [<c8867bd7>] [<c886a4d5>] [<c8867ba5>] [<c886a4d4>]
[<c8867bd7>]
  [<c886a4d4>] [<c8867b72>] [<c886a4d4>] [<c8867bd7>] [<c886a4d4>]
[<c8867ba5>]
  [<c886a4d3>] [<c8867bd7>] [<c886a4d3>] [<c8867b72>] [<c886a4d3>]
[<c8867bd7>]
  [<c886a4d3>] [<c8867ba5>] [<c886a4d2>] [<c8867bd7>] [<c886a4d2>]
[<c8867b72>]
  [<c886a4d2>] [<c8867bd7>] [<c886a4d2>] [<c8867ba5>] [<c886a4d1>]
[<c8867bd7>]
  [<c886a4d1>] [<c8867b72>] [<c886a4d1>] [<c8867bd7>] [<c886a4d1>]
[<c8867ba5>]
  [<c886a4d0>] [<c8867bd7>] [<c886a4d0>] [<c8867b72>] [<c886a4d0>]
[<c8867bd7>]
  [<c886a4d0>] [<c8867ba5>] [<c886a4cf>] [<c8867bd7>] [<c886a4cf>]
[<c8867b72>]
  [<c886a4cf>] [<c8867bd7>] [<c886a4cf>] [<c8867ba5>] [<c886a4ce>]
[<c8867bd7>]
  [<c886a4ce>] [<c8867b72>] [<c886a4ce>] [<c8867bd7>] [<c886a4ce>]
[<c8867ba5>]
  [<c886a4cd>] [<c8867bd7>] [<c886a4cd>] [<c8867b72>] [<c886a4cd>]
[<c8867bd7>]
  [<c886a4cd>] [<c8867ba5>] [<c886a4cc>] [<c8867bd7>] [<c886a4cc>]
[<c8867b72>]
  [<c886a4cc>] [<c8867bd7>] [<c886a4cc>] [<c8867ba5>] [<c886a4cb>]
[<c8867bd7>]
  [<c886a4cb>] [<c8867b72>] [<c886a4cb>] [<c8867bd7>]
do_IRQ: stack overflow: -940
...    ...    ...
After some time this limit changes
do_IRQ: stack overflow: -1048
some stack frames
do_IRQ: stack overflow: -1156
some stack frames

    I've build this Kernel with gcc-2.96-98 on Red Hat Linux release 7.2.
    In above dump, what surprises me is when I googled for do_IRQ I got few
postings on mailing list but none of the posting was for -Ve value of "esp -
sizeof(struct task_struct)".

    Also I'd like some opinion about the patch posted on
http://www.ussg.iu.edu/hypermail/linux/kernel/0301.2/0232.html
    Here, why "struct task_struct" is replaced with "struct thread_info"? Is
that only for 2.5.X/2.6.X series only?

    I'd also like to draw your attention on one more patch by Joern Engel
(He is in CC list)
http://wh.fh-wedel.de/~joern/software/kernel/je/24/.patches/stack_overflow.p
atch
    Are these patches safe to apply? What could be pros and cons if these
patches are applied into 2.4.22 kernel.

    Thanks for all your replies.
-- Sumit

