Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbTD0U7o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 16:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTD0U7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 16:59:44 -0400
Received: from siaag2ae.compuserve.com ([149.174.40.135]:57333 "EHLO
	siaag2ae.compuserve.com") by vger.kernel.org with ESMTP
	id S261767AbTD0U7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 16:59:43 -0400
Date: Sun, 27 Apr 2003 17:09:04 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: desc v0.61 found a 2.5 kernel bug
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304271711_MC3-1-3647-1A8A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



desc v0.61 running on Linux 2.5.68-rel:

 GDT at c0306300, 32 entries:

GDT# 12: base:00000000 limit:ffffffff  flags:c09b <P:1 DPL:0 32-bit Code>
GDT# 13: base:00000000 limit:ffffffff  flags:c093 <P:1 DPL:0 RW Data>
GDT# 14: base:00000000 limit:ffffffff  flags:c0fb <P:1 DPL:3 32-bit Code>
GDT# 15: base:00000000 limit:ffffffff  flags:c0f3 <P:1 DPL:3 RW Data>
GDT# 16: base:c0353800 limit:000eb     flags:008b <P:1 DPL:0 Busy TSS>

    TSS at c0353800, 236 bytes:

   CS:0000 <GDT#00,RPL0>   EIP:00000000   eflags:00000000
  SS0:0068 <GDT#13,RPL0>  ESP0:c2806000
   SS:0000 <GDT#00,RPL0>   ESP:00000000
   DS:0000 <GDT#00,RPL0>  ES:0000 <GDT#00,RPL0>
   FS:0000 <GDT#00,RPL0>  GS:0000 <GDT#00,RPL0>
  LDT:0011 <GDT#02,RPL1>   CR3:00000000
      ^^^^                     ^^^^^^^^


 The LDT in the kernel's TSS is wrong -- it's shifted right by three

bits and should be 0088 <GDT entry #17, RPL 0>

 And shouldn't CR3 be intitialized in case anyone actually wants to
switch back to the kernel TSS?


------
 Chuck
