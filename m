Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292965AbSCIVmf>; Sat, 9 Mar 2002 16:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292956AbSCIVmZ>; Sat, 9 Mar 2002 16:42:25 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:9998 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S292954AbSCIVmO>;
	Sat, 9 Mar 2002 16:42:14 -0500
Date: Sat, 9 Mar 2002 22:23:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Hank Yang <hanky@promise.com.tw>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        Crimson Hung <crimsonh@promise.com.tw>,
        Jenny Liang <jennyl@promise.com.tw>,
        Linus Chen <linusc@promise.com.tw>
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
Message-ID: <20020309212316.GA747@elf.ucw.cz>
In-Reply-To: <00f201c1c5a3$d27a8330$59cca8c0@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f201c1c5a3$d27a8330$59cca8c0@hank>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


>     We make some changes for support our product. The ATA-100/133
> Controllers.
> Hope you can reference following describe and patch code. If there has
> anything
> wrong, please feel free to tell us. Thank you.

Seems like mailer damaged it badly... Or you have very poor indenting
style ;-).
								Pavel

> @@ -371,10 +376,22 @@
>    OUT_BYTE(drive->ctl,IDE_CONTROL_REG);
>   OUT_BYTE(0x00, IDE_FEATURE_REG);
>   OUT_BYTE(rq->nr_sectors,IDE_NSECTOR_REG);
> + if ((drive->id->command_set_2 & 0x0400) &&
> HWIF(drive)->pci_devid.vid==PCI_VENDOR_ID_PROMISE) {
> +  /* 48 bits data previous */
> +  OUT_BYTE(rq->nr_sectors>>8, IDE_NSECTOR_REG);
> +  OUT_BYTE(block>>24, IDE_SECTOR_REG);
> +  OUT_BYTE(0x00, IDE_LCYL_REG); //block only 32 bits
> +  OUT_BYTE(0x00, IDE_HCYL_REG);
> +  /* 48 bits data current */
> +  OUT_BYTE(rq->nr_sectors, IDE_NSECTOR_REG);
> +  OUT_BYTE(block, IDE_SECTOR_REG);
> +  OUT_BYTE(block>>8, IDE_LCYL_REG);
> +  OUT_BYTE(block>>16, IDE_HCYL_REG);
> +  OUT_BYTE(drive->select.all,IDE_SELECT_REG);
>  #ifdef CONFIG_BLK_DEV_PDC4030
> - if (drive->select.b.lba || IS_PDC4030_DRIVE) {
> -#else /* !CONFIG_BLK_DEV_PDC4030 */
> - if (drive->select.b.lba) {
> + } else if (drive->select.b.lba || IS_PDC4030_DRIVE) {
> +#else /* !CONFIG_BLK_DEV_PDC4030 */
> + } else if (drive->select.b.lba) {
>  #endif /* CONFIG_BLK_DEV_PDC4030 */
>  #ifdef DEBUG
>    printk("%s: %sing: LBAsect=%ld, sectors=%ld, buffer=0x%08lx\n",
> @@ -413,7 +430,10 @@

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
