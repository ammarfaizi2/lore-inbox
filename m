Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVB1OID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVB1OID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVB1OGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:06:47 -0500
Received: from imag.imag.fr ([129.88.30.1]:40658 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261596AbVB1OB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:01:27 -0500
Message-ID: <1109599275.4223242b6b560@webmail.imag.fr>
Date: Mon, 28 Feb 2005 15:01:15 +0100
From: colbuse@ensisun.imag.fr
To: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
References: <1109596437.422319158044b@webmail.imag.fr> <20050228132849.B16460@flint.arm.linux.org.uk>
In-Reply-To: <20050228132849.B16460@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 193.49.124.107
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Mon, 28 Feb 2005 15:01:15 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Surlignage Russell King <rmk+lkml@arm.linux.org.uk>:

> On Mon, Feb 28, 2005 at 02:13:57PM +0100, colbuse@ensisun.imag.fr wrote:
> > NPAR times :-). As I stated, npar is unsigned.
> 
> I think that's disgusting then - it isn't obvious what's going on, which
> leads to mistakes.
> 
> For the sake of a micro-optimisation such as this, it's far more important
> that the code be readable and easily understandable.
> 
> Others may disagree.
> 

I agree :) . But, if we look to the code, we can notice that there is actually
no reason for npar to be unsigned. What do you think of this version?


--- old/drivers/char/vt.c       2004-12-24 22:35:25.000000000 +0100
+++ new/drivers/char/vt.c       2005-02-28 12:53:57.933256631 +0100
@@ -1655,9 +1655,9 @@
                        vc_state = ESnormal;
                return;
        case ESsquare:
-               for(npar = 0 ; npar < NPAR ; npar++)
+               for(npar = NPAR - 1; npar >= 0; npar--)
                        par[npar] = 0;
+               npar++;
-               npar = 0;
                vc_state = ESgetpars;
                if (c == '[') { /* Function key */
                        vc_state=ESfunckey;


--- old/include/linux/console_struct.h  2004-12-24 22:33:48.000000000 +0100
+++ old/include/linux/console_struct.h  2005-02-28 14:49:53.653616335 +0100
@@ -44,7 +44,8 @@
        unsigned short  vc_video_erase_char;    /* Background erase character */
        /* VT terminal data */
        unsigned int    vc_state;               /* Escape sequence parser state */
-       unsigned int    vc_npar,vc_par[NPAR];   /* Parameters of current escape
sequence */
+       unsigned int    vc_par[NPAR];           /* Parameters of current escape
sequence */
+       int             vc_npar;                /* Current position in vc_par */
        struct tty_struct *vc_tty;              /* TTY we are attached to */
        /* mode flags */
        unsigned int    vc_charset      : 1;    /* Character set G0 / G1 */


--
Emmanuel Colbus
Club GNU/Linux
ENSIMAG - Departement telecoms


-------------------------------------------------
envoyé via Webmail/IMAG !

