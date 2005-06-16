Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVFPHK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVFPHK2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 03:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVFPHK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 03:10:28 -0400
Received: from aun.it.uu.se ([130.238.12.36]:57761 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261765AbVFPHKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 03:10:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17073.9681.911274.644554@alkaid.it.uu.se>
Date: Thu, 16 Jun 2005 09:10:09 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Bodo Eggert <7eggert@gmx.de>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
       "Richard B. Johnson" <linux-os@analogic.com>,
       Gene Heskett <gene.heskett@verizon.net>, cutaway@bellsouth.net,
       linux-kernel@vger.kernel.org
Subject: Re: .../asm-i386/bitops.h  performance improvements
In-Reply-To: <Pine.LNX.4.58.0506152053010.3184@be1.lrz>
References: <4fB8l-73q-9@gated-at.bofh.it>
	<4fF2j-1Lo-19@gated-at.bofh.it>
	<E1DiZKe-0000em-58@be1.7eggert.dyndns.org>
	<Pine.LNX.4.61L.0506151629270.13835@blysk.ds.pg.gda.pl>
	<Pine.LNX.4.61.0506151200490.24211@chaos.analogic.com>
	<Pine.LNX.4.61L.0506151723460.13835@blysk.ds.pg.gda.pl>
	<Pine.LNX.4.58.0506152053010.3184@be1.lrz>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert writes:
 > My documentation says:
 > 
 > lea reg16, mem
 > Available on 8086, 80186, 80286, 80386, 80486
 > 32-bit-extension available
 > Opcode: 8D mod reg r/m
 > 
 > reg will be the target register (AX .. DI), and mod and r/m will select
 > something like a direct address, a register or a combination like 
 > BP+DI+ofs (I won't copy the table). A multiplier is not mentioned there.

You're looking at the wrong parts of the documentation. The 16-bit
mode ModR/M doesn't have SIB, but the 32-bit mode does. The SIB includes
the scaled index. All IA32 processors have it. The only LEA-related
quirk is that its ModR/M must not describe a non-memory operand.
