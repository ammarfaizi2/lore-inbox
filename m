Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSFUMzb>; Fri, 21 Jun 2002 08:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316588AbSFUMza>; Fri, 21 Jun 2002 08:55:30 -0400
Received: from static62-99-146-174.adsl.inode.at ([62.99.146.174]:15520 "EHLO
	silo.pitzeier.priv.at") by vger.kernel.org with ESMTP
	id <S316580AbSFUMz3>; Fri, 21 Jun 2002 08:55:29 -0400
From: "Oliver Pitzeier" <oliver@linux-kernel.at>
To: <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.24 on alpha; fls redefined!? HELP NEEDED
Date: Fri, 21 Jun 2002 14:55:21 +0200
Organization: Linux Kernel Austria
Message-ID: <000601c21922$ea0c43d0$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <000501c21921$2ead26f0$010b10ac@sbp.uptime.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Pitzeier wrote:
> Where comes this from and _why_???
> 
> /usr/src/linux-2.5.24/include/asm/bitops.h:471:1: warning: 
> "fls" redefined
> ^^^^^^^^^^^^^^^^^^^^^^^^

OK. Found it... Here...
    467 /*
    468  * fls: find last bit set.
    469  */
    470
    471 #define fls(x) generic_fls(x)

I took it out. I guess it's not needed anymore because of this:

    318 /*
    319  * fls: find last bit set.
    320  */
    321 #if defined(__alpha_cix__) && defined(__alpha_fix__)
    322 static inline int fls(int word)
    323 {
    324         long result;
    325         __asm__("ctlz %1,%0" : "=r"(result) : "r"(word &
0xffffffff));
    326         return 64 - result;
    327 }
    328 #else
    329 #define fls     generic_fls
    330 #endif

Right? :o)

Greetz,
  Oliver


