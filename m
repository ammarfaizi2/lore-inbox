Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130198AbQLNOmA>; Thu, 14 Dec 2000 09:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130454AbQLNOlt>; Thu, 14 Dec 2000 09:41:49 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:20742 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S130198AbQLNOl3>; Thu, 14 Dec 2000 09:41:29 -0500
Date: Thu, 14 Dec 2000 14:10:57 +0000 (GMT)
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: x86 cpu_data
Message-ID: <Pine.LNX.4.21.0012141409280.22487-100000@mrworry.compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, I need to check for *only* Intel P6 processors, so no Classic Pentium,
and no Pentium 4. setup.c is a bit obscure; is this check correct :

if (current_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
	current_cpu_data.x86 != 6)
	return NOT_P6;
if (current_cpu_data.x86_model > 5)
	return PENTIUM_III;
if (current_cpu_data.x86_model > 2)
	return PENTIUM_II;
return PENTIUM_PRO;

??

(I need this check as I make use of the P6 performance counters).

Also, I found a weird bit of code in setup.c (2.4.0test12) :

1567   case 4:
1568       if ( c->x86 > 6 && dl ) {
1569            /* P4 family */
1570            if ( dl ) {
1571                    /* L3 cache */
1572                    cs = 128 << (dl-1);
1573                    l3 += cs;
1574                    break;
1575            }
1576       }
1577       /* else same as 8 - fall through */
1578   case 8:
1579       if ( dl ) {

in particular, the check on line 1570 seems redundant, or a typo.

thanks
john

-- 
"Kaa's Law: In any sufficiently large group of people most are idiots."
"Adams' Corollary: "sufficiently large" is around 1."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
