Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754754AbWKITDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbWKITDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754751AbWKITDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:03:16 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:64644 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1754708AbWKITDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:03:15 -0500
Message-ID: <45537B67.6050804@gmail.com>
Date: Thu, 09 Nov 2006 20:03:03 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jano <jasieczek@gmail.com>
CC: Jiri Slaby <jirislaby@gmail.com>, Phillip Susi <psusi@cfl.rr.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>	 <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>	 <45534B31.50008@cfl.rr.com> <45534D2C.6080509@gmail.com> <d9a083460611090855w3b3a9eb6w347a24b1e704ca61@mail.gmail.com>
In-Reply-To: <d9a083460611090855w3b3a9eb6w347a24b1e704ca61@mail.gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jano wrote:
[...]
> @@ -607,7 +611,7 @@
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_IDE_SATA is not set
> -# CONFIG_BLK_DEV_HD_IDE is not set
> +CONFIG_BLK_DEV_HD_IDE=y

This was not definitely a good choice. Disable it.

  │ Symbol: BLK_DEV_HD_IDE [=n]                                             │
  │ Prompt: Use old disk-only driver on primary interface                   │
  │   Defined at drivers/ide/Kconfig:118                                    │
  │   Depends on: IDE && BLK_DEV_IDE && (X86 || SH_MPC1211)                 │
  │   Location:                                                             │
  │     -> Device Drivers                                                   │
  │       -> ATA/ATAPI/MFM/RLL support                                      │
  │         -> ATA/ATAPI/MFM/RLL support (IDE [=y])                         │
  │           -> Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support (BLK_D │

> CONFIG_BLK_DEV_IDEDISK=y
> # CONFIG_IDEDISK_MULTI_MODE is not set
> CONFIG_BLK_DEV_IDECD=m
> @@ -618,7 +622,7 @@
> #
> # IDE chipset support/bugfixes
> #
> -CONFIG_IDE_GENERIC=y
> +CONFIG_IDE_GENERIC=m
> # CONFIG_BLK_DEV_CMD640 is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> @@ -658,7 +662,7 @@
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=y
> -# CONFIG_BLK_DEV_HD is not set
> +CONFIG_BLK_DEV_HD=y

And try to turn "VIA82CXXX chipset support" to <*>, i.e. built-in (somebody
holds regions of ide0 and ide1, let's try via driver to probe first).

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
