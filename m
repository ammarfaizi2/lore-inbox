Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbUBXE7D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 23:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbUBXE7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 23:59:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:64177 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262164AbUBXE65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 23:58:57 -0500
Date: Mon, 23 Feb 2004 20:55:22 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Coywolf Qi Hunt <coywolf@greatcn.org>
Cc: phil.el@wanadoo.fr, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: Does Flushing the Queue after PG REALLY a Necessity?
Message-Id: <20040223205522.66d7fb4f.rddunlap@osdl.org>
In-Reply-To: <403AB897.8070002@greatcn.org>
References: <c16rdh$gtk$1@terminus.zytor.com>
	<4039D599.7060001@greatcn.org>
	<20040223151815.GA403@zaniah>
	<403AB897.8070002@greatcn.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004 10:36:07 +0800 Coywolf Qi Hunt <coywolf@greatcn.org> wrote:

| Philippe Elie wrote:
| 
| > On Mon, 23 Feb 2004 at 18:27 +0000, Coywolf Qi Hunt wrote:
| > 
| > 
| >>H. Peter Anvin wrote:
| >>
| >>
| >>>Anyone happen to know of any legitimate reason not to reload %cs in
| >>>head.S?  I think the following would be a lot cleaner, as well as a
| >>>lot safer (the jump and indirect branch aren't guaranteed to have the
| >>>proper effects, although technically neither should be required due to
| >>>the %cr0 write):
| > 
| > 
| > jump is sufficent when setting PG and required with cpu where cr0 write
| > does not serialize.
| 
| The problem is there's two jumps in the kernel. Intel's manual only asks 
| for "Execute a near JMP instruction".
| 
| > 
| > 
| >>Anyone happen to know of any legitimate reason to flush the prefetch
| >>queue after enabling paging?
| >>
| >>I've read the intel manual volume 3 thoroughly. It only says that after
| >>entering protected mode, flushing is required, but never says
| >>specifically about whether to do flushing after enabling paging.
| >>
| >>Furthermore the intel example code enables protected mode and paging at
| >>the same time. So does FreeBSD. There's really no more references to check.
| >>
| >> From the cpu's internal view, flushing for PE is to flush the prefetch
| >>queue as well as re-load the %cs, since the protected mode is just about
| >>to begin. But no reason to flushing for PG, since linux maps the
| >>addresses *identically*.
| >>
| >>If no any reason, please remove the after paging flushing queue code,
| >>two near jump.
| > 
| > 
| > See IA32 vol 3  7.4 and 18.27.3
| > 
| > Anyway this code is known to work on dozen of intel/non intel processor,
| > how can you know if changing this code will not break an obscure clone ?
| 
| Right, I also think removing the flush code is risky. Thanks very much, 
| chapter 18 is what i was looking for. I recalled in an old intel 
| booklet, named like something 386 system guide, says JMP after PG as 
| well as PE. But I didn't have that book at hand and didn't find any e-doc.

I guess that's the 80386 System Software Writer's Guide.
Ch. 6: Initialization.
Yes, it does JMP after setting PE and after enabling PG.
Any JMP.

| However, in 18.27.3, "The sequence bounded by the MOV and JMP 
| instructions should be identity" implies no JMP is also viable 
| practically. But we needn't to be that pedantic.
| 
| If no any reason for the two jumps, the code should be fixed to remains 
| only ONE near jump.


--
~Randy
