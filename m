Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbVCJUWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbVCJUWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbVCJUWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:22:11 -0500
Received: from imag.imag.fr ([129.88.30.1]:3311 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S263000AbVCJUUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 15:20:02 -0500
Date: Thu, 10 Mar 2005 21:19:24 +0100 (MET)
From: "emmanuel.colbus@ensimag.imag.fr" <colbuse@ensisun.imag.fr>
X-X-Sender: colbuse@ensisun
To: linux-kernel@vger.kernel.org
Subject: [RFC][SPARC64][kernel 2.4] __show_regs() calls to printk()
Message-ID: <Pine.GSO.4.40.0503102050160.27735-100000@ensisun>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Thu, 10 Mar 2005 21:19:58 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

in the file arch/sparc64/kernel/process.c, the function __show_regs()
prints the content of the registers four by four, but every register's
content needs 16 caracters to be printed; the name of the register needs 4
caracters; and one caracter is needed to separate this value from the next
register's name.

Therefore, it uses 84 caracters per line, but the VT100 has only 80, so we
are using two lines instead of only one, shortening the content of the
(eventual) Oops one could sent.

I think we could perform better, by suppressing the space between the name
of the register and it's value. By this way, instead of writing :

g4: fffff80000000000 g5: 0000000000000004 g6: fffff80001348000 g7: 000000000000
0000

we would have :

g4:fffff80000000000 g5:0000000000000004 g6:fffff80001348000 g7:0000000000000000

It remains fully understandable, I think. Alternately, we could print only
3 registers per line, but since the registers are grouped 8 by 8,
it would be less logical.

This would also have a sense for Sparc32 computers, and, in the same file,
for the functions show_stackframe and show_regwindow.

Any comments? Should I make a patch?


--
Emmanuel Colbus
Club GNU/Linux
ENSIMAG - Departement Telecoms



