Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265110AbUELPet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbUELPet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 11:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbUELPer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 11:34:47 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:26069 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S265110AbUELPej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 11:34:39 -0400
Message-ID: <40A24458.533E637D@nospam.org>
Date: Wed, 12 May 2004 17:35:52 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Who owns those locks ? (3)
Content-Type: multipart/mixed;
 boundary="------------E711D0845B24809FA39FCEF3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E711D0845B24809FA39FCEF3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Don't know why I thought that the assembly code of the spin
lock would be in a single file :-)

Zoltán
--------------E711D0845B24809FA39FCEF3
Content-Type: text/plain; charset=us-ascii;
 name="n475"
Content-Disposition: inline;
 filename="n475"
Content-Transfer-Encoding: 7bit

--- 2.6.5.ref/arch/ia64/kernel/head.S	Wed Apr 21 16:18:26 2004
+++ 2.6.5.new/arch/ia64/kernel/head.S	Wed May 12 16:31:33 2004
@@ -917,7 +917,8 @@
 	ld4 r30=[r31]		// don't use ld4.bias; if it's contended, we won't write the word
 	;;
 	cmp4.ne p14,p0=r30,r0
-	mov r30 = 1
+//	mov r30 = 1
+	shr.u r30 = r13, 12	// Current task pointer
 (p14)	br.cond.sptk.few .wait
 	;;
 	cmpxchg4.acq r30=[r31], r30, ar.ccv


--------------E711D0845B24809FA39FCEF3--

