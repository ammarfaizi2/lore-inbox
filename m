Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313529AbSDHIps>; Mon, 8 Apr 2002 04:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313588AbSDHIps>; Mon, 8 Apr 2002 04:45:48 -0400
Received: from office.mandrakesoft.com ([195.68.114.34]:58097 "HELO
	vador.mandrakesoft.com") by vger.kernel.org with SMTP
	id <S313529AbSDHIpr>; Mon, 8 Apr 2002 04:45:47 -0400
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bttv compile failure in 2.5.8-pre2
In-Reply-To: <200204062356.g36Nujh03555@vindaloo.ras.ucalgary.ca>
	<slrnaavu74.t38.kraxel@bytesex.org>
X-URL: <http://www.linux-mandrake.com/
Organization: MandrakeSoft
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Date: Mon, 08 Apr 2002 10:49:48 +0200
Message-ID: <m2elhqy3pv.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2
 (i386-mandrake-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Gerd Knorr <kraxel@bytesex.org> writes:

> The same is true for nearly all other v4l drivers.  Dave picked up
> my videodev patch from the list and feeded it to Linus, but all the
> related driver fixes are not in the kernel yet ...
>
> 2.4.7 patches are at http://bytesex.org/patches/2.5/
> I'll rediff against -pre2 and resend stuff next days ...

bttv-0.8.x also needs this fix since pointers to __devexit functions
should be marked __devexit_p so that newer binutils don't cry about
references to discarded symbols :


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=BTTV.diff
Content-Description: in core kernel bttv build fix

--- drivers/media/video/bttv-driver.c.orig	Thu Apr  4 02:12:59 2002
+++ drivers/media/video/bttv-driver.c	Fri Apr  5 06:12:53 2002
@@ -3394,7 +3394,7 @@
         name:     "bttv",
         id_table: bttv_pci_tbl,
         probe:    bttv_probe,
-        remove:   bttv_remove,
+        remove:   __devexit_p(bttv_remove),
 };
 
 static int bttv_init_module(void)

--=-=-=


-- 
Still untested beyond 'it compiles' (davej)

--=-=-=--

