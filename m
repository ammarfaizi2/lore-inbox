Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbTBXROA>; Mon, 24 Feb 2003 12:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTBXRN7>; Mon, 24 Feb 2003 12:13:59 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:56277 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S267281AbTBXRN6>; Mon, 24 Feb 2003 12:13:58 -0500
Message-ID: <6181774.1046107122935.JavaMail.nobody@web54.us.oracle.com>
Date: Mon, 24 Feb 2003 09:18:42 -0800 (PST)
From: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
To: linux-kernel@vger.kernel.org
Subject: more on the Latitude C640 and IrDA...
Cc: irda-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dang. I found out that the chip (SMC LPC47N252) works in both SIR and
 FIR mode with the RedHat 8.0 2.4.18-24.8.0 kernel, while it refuses to work
 in both 2.4.21-pre4 and 2.5 (up to .62 at least).

What I try to do:

 modprobe irda
 modprobe ircomm
 modprobe smc-ircc
 irattach irda0 -s 1

Reason why it doesn't work ? Well - SIR: no idea. The most I've been able
 to squeeze is a line from irdadump every 10 seconds (instead of a line every
 second or less in "normal" behavior). FIR: smc-ircc says chip reports irq 0.

Relevant IrDA .config stuff, from my 2.4.21-pre4:

[asuardi@incident linux]$ egrep 'IRDA|SIR|FIR' .config
CONFIG_IRDA=m
# CONFIG_IRDA_ULTRA is not set
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m
# CONFIG_USB_IRDA is not set
# CONFIG_NSC_FIR is not set
# CONFIG_WINBOND_FIR is not set
# CONFIG_TOSHIBA_FIR is not set
CONFIG_SMC_IRCC_FIR=m
# CONFIG_ALI_FIR is not set
# CONFIG_VLSI_FIR is not set

This same .config worked fine for the SMC chip on my older Latitude
 (though the chip model was different).


Will keep digging... but in case anyone has tips, please let me know :)

--alessandro
