Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVB1PGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVB1PGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 10:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVB1PGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 10:06:39 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:42383 "EHLO harmonie.imag.fr")
	by vger.kernel.org with ESMTP id S261632AbVB1PGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 10:06:32 -0500
Message-ID: <1109603174.42233366e4fed@webmail.imag.fr>
Date: Mon, 28 Feb 2005 16:06:14 +0100
From: colbuse@ensisun.imag.fr
To: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 193.49.124.107
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (harmonie.imag.fr [147.171.130.40]); Mon, 28 Feb 2005 16:06:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-MailScanner-From: emmanuel.colbus@ensisun.imag.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>> - for(npar = 0 ; npar < NPAR ; npar++)
>> + for(npar = NPAR - 1; npar >= 0; npar--)
>> par[npar] = 0;

>if you really want to clean this up.. 

Well, actually, I was not myself entirely convinced about it... This is the
reason for I wrote "please _don't_ apply this, but tell me what you think about
it.".

>why not use memset() instead ?

Because I simply didn't thought to it :-) .

Hey, that makes fully sense! So far I know, memset() is quicker than 
(or as quick as) a loop, and it remains fully readable (in my opinion :).

Well, such a patch would be : 

--- drivers/char/vt.c   2004-12-24 22:35:25.000000000 +0100
+++ drivers/char/vt2.c  2005-02-28 15:55:11.782717810 +0100
@@ -1655,8 +1655,8 @@
                        vc_state = ESnormal;
                return;
        case ESsquare:
-               for(npar = 0 ; npar < NPAR ; npar++)
-                       par[npar] = 0;
+               /* Setting par[]'s elems at 0.  */
+               memset(par, 0, NPAR*sizeof(unsigned int));
                npar = 0;
                vc_state = ESgetpars;
                if (c == '[') { /* Function key */


Thank you for the suggestion.
What do you think of this one?

(Please note that I'm not trying to get a patch for it _by force_ into the
kernel. If it's a bad idea, let's let thing like they currently are, 
the current loop just works.)

cu

--
Emmanuel Colbus
Club GNU/Linux
ENSIMAG - Departement telecoms

-------------------------------------------------
envoyé via Webmail/IMAG !

