Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVADUr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVADUr6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVADUox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:44:53 -0500
Received: from imag.imag.fr ([129.88.30.1]:23994 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S262135AbVADUb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:31:58 -0500
Date: Tue, 4 Jan 2005 21:31:44 +0100 (MET)
From: "emmanuel.colbus@ensimag.imag.fr" <colbuse@ensisun.imag.fr>
X-X-Sender: colbuse@ensisun
To: linux-kernel@vger.kernel.org
cc: jakub@redhat.com, <roots@ensilinx1.imag.fr>
Subject: [BUG]Deadlock in get_irqlock() due to Bottom halves on Sparc64 SMP,
 kernel 2.4.27
Message-ID: <Pine.GSO.4.40.0501042036480.20746-100000@ensisun>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Tue, 04 Jan 2005 21:31:45 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We are currently experiencing a kind of freeze on a 4-processor
UltraSparc computer (a sun Enterprise 4000).
The VT100 screen shows only occurences of the following message :

get_irqlock, CPU1:
irq:  0 [ 0 0 0 0 ]
bh:   1 [ 1 0 0 0 ]

Having checked to the sources, we found that this message shows that CPU0
has currently one Bottom-half, and keeps it, but we have no idea why it
has freezed in this situation.

To tell the truth, this is not a complete freeze, since the kernel
continues to answer to "ping", and nmap shows normal output, but we had
never been able to contact any of the theoretically running services. It
seems us as no user-space program get access to a processor.

This is the content of the /proc/cpuinfo file :

cpu             : TI UltraSparc I   (SpitFire)
fpu             : UltraSparc I integrated FPU
promlib         : Version 3 Revision 2
prom            : 3.2.4
type            : sun4u
ncpus probed    : 4
ncpus active    : 4
Cpu0Bogo        : 333.41
Cpu0ClkTck      : 0000000009f437c0
Cpu1Bogo        : 333.41
Cpu1ClkTck      : 0000000009f437c0
Cpu4Bogo        : 333.41
Cpu4ClkTck      : 0000000009f437c0
Cpu5Bogo        : 333.41
Cpu5ClkTck      : 0000000009f437c0
MMU Type        : Spitfire
State:
CPU0:           online
CPU1:           online
CPU4:           online
CPU5:           online

And this is the result of a uname -a :

Linux ensilinx6 2.4.27 #2 SMP dim nov 14 18:58:56 CET 2004 sparc64
GNU/Linux


Note :
Nmapping the computer has the side-effect of fulling the VT100 screen with
the message :
"eth0: Happy Meal out of receive descriptors, packet dropped".
After that, and after some time, the original "get_irqlock" messages
came again.

The sources are telling that it means that the computer is overloaded and
receives packets too quickly (from drivers/net/sunhme.c, line 1832).

Any ideas?

-- 
Alban Crequy - Emmanuel Colbus
Club Gnu/Linux
ENSIMAG - Departement Telecommunications

