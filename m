Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314675AbSEYPdZ>; Sat, 25 May 2002 11:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314686AbSEYPdY>; Sat, 25 May 2002 11:33:24 -0400
Received: from smtp08.wxs.nl ([195.121.6.40]:5354 "EHLO smtp08.wxs.nl")
	by vger.kernel.org with ESMTP id <S314675AbSEYPdY>;
	Sat, 25 May 2002 11:33:24 -0400
Message-ID: <3CEFAB05.62937A75@wxs.nl>
Date: Sat, 25 May 2002 17:17:25 +0200
From: Gert Vervoort <Gert.Vervoort@wxs.nl>
Organization: Planet Internet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 ide-scsi compile fix
In-Reply-To: <3CEF8815.C7C13D39@wxs.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- ide-scsi.c.1        Sat May 25 14:21:28 2002
> +++ ide-scsi.c  Sat May 25 14:21:37 2002
> @@ -804,7 +804,7 @@
>  };
> 
> 
> -static int __init idescsi_init(void)
> +int __init idescsi_init(void)
>  {
>         int ret;
>         ret = ata_driver_module(&idescsi_driver);

This does not boot, as idescsi_init seems is also called by the scsi subsystem.
The following patch actually boots on my system:

--- ide.c.1     Sat May 25 16:22:54 2002
+++ ide.c       Sat May 25 16:23:22 2002
@@ -3444,9 +3444,7 @@
        idefloppy_init();
 #endif
 #ifdef CONFIG_BLK_DEV_IDESCSI
-# ifdef CONFIG_SCSI
-       idescsi_init();
-# else
+# ifndef CONFIG_SCSI
    #error ATA SCSI emulation selected but no SCSI-subsystem in kernel
 # endif
 #endif
