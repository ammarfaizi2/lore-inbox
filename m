Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVBBAM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVBBAM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 19:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVBBAM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 19:12:28 -0500
Received: from gprs214-253.eurotel.cz ([160.218.214.253]:15235 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262189AbVBBAMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 19:12:20 -0500
Date: Wed, 2 Feb 2005 01:10:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Daniel Drake <dsd@gentoo.org>
Cc: kernel-janitors@osdl.org, kernel list <linux-kernel@vger.kernel.org>,
       linux-pm@osdl.org, benh@kernel.crashing.org
Subject: Re: driver model u32 -> pm_message_t conversion: help needed
Message-ID: <20050202001017.GB31368@elf.ucw.cz>
References: <20050125194710.GA1711@elf.ucw.cz> <42001A47.40409@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42001A47.40409@gentoo.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Now, if you want to help, just convert some drivers... To quickly
> >break compilation in case of bad types, following patch can be used
> >(against 2.6.11-rc2-mm1), it actually switches pm_message_t to
> >typedef.
> >
> >I'm looking forward to the patches, (please help),
> 
> I just had a look at converting some but then found some identical patches 
> written by you elsewhere. Are there any remaining conversions to be done? 
> Perhaps you could post some grep output from your local tree if there are?

Lot of conversions were done, but it still looks like there's a lot to
do:

pavel@amd:/usr/src/linux/drivers$ grep _suspend.*u32 */*.c
base/sys.c:int sysdev_suspend(u32 state)
char/s3c2410-rtc.c:static int s3c2410_rtc_suspend(struct device *dev, u32 state, u32 level)
char/sonypi.c:static int sonypi_suspend(struct device *dev, u32 state, u32 level)
macintosh/macio_asic.c:static int macio_device_suspend(struct device *dev, u32 state)
macintosh/mediabay.c:static int __pmac media_bay_suspend(struct macio_dev *mdev, u32 state)
mmc/mmc.c:int mmc_suspend_host(struct mmc_host *host, u32 state)
mmc/mmci.c:static int mmci_suspend(struct amba_device *dev, u32 state)
mmc/pxamci.c:static int pxamci_suspend(struct device *dev, u32 state, u32 level)
mmc/wbsd.c:static int wbsd_suspend(struct device *dev, u32 state, u32 level)
net/8139cp.c:static int cp_suspend (struct pci_dev *pdev, u32 state)
net/bmac.c:static int bmac_suspend(struct macio_dev *mdev, u32 state)
net/pci-skeleton.c:static int netdrv_suspend (struct pci_dev *pdev, u32 state)
net/r8169.c:static int rtl8169_suspend(struct pci_dev *pdev, u32 state)
net/smc91x.c:static int smc_drv_suspend(struct device *dev, u32 state, u32 level)
pcmcia/au1000_generic.c:static int au1000_pcmcia_suspend(u32 sock);
pcmcia/hd64465_ss.c:static int hd64465_suspend(struct device *dev, u32 state, u32 level)
pcmcia/i82365.c:static int i82365_suspend(struct device *dev, pm_message_t state, u32 level)
pcmcia/m32r_cfc.c:static int m32r_pcc_suspend(struct device *dev, u32 state, u32 level)
pcmcia/m32r_pcc.c:static int m32r_pcc_suspend(struct device *dev, u32 state, u32 level)
pcmcia/pxa2xx_base.c:static int pxa2xx_drv_pcmcia_suspend(struct device *dev, u32 state, u32 level)
pcmcia/sa1100_generic.c:static int sa11x0_drv_pcmcia_suspend(struct device *dev, u32 state, u32 level)
pcmcia/sa1111_generic.c:static int pcmcia_suspend(struct sa1111_dev *dev, u32 state)
pcmcia/tcic.c:static int tcic_drv_suspend(struct device *dev, pm_message_t state, u32 level)
scsi/mesh.c:static int mesh_suspend(struct macio_dev *mdev, u32 state)
scsi/nsp32.c:static int nsp32_suspend(struct pci_dev *pdev, u32 state)
serial/8250.c:static int serial8250_suspend(struct device *dev, pm_message_t state, u32 level)
serial/amba-pl010.c:static int pl010_suspend(struct amba_device *dev, u32 state)
serial/imx.c:static int serial_imx_suspend(struct device *_dev, u32 state, u32 level)
serial/mpc52xx_uart.c:mpc52xx_uart_suspend(struct ocp_device *ocp, u32 state)
serial/pmac_zilog.c:static int pmz_suspend(struct macio_dev *mdev, u32 pm_state)
serial/pxa.c:static int serial_pxa_suspend(struct device *_dev, u32 state, u32 level)
serial/s3c2410.c:int s3c24xx_serial_suspend(struct device *dev, u32 state, u32 level)
serial/sa1100.c:static int sa1100_serial_suspend(struct device *_dev, u32 state, u32 level)
video/pxafb.c:static int pxafb_suspend(struct device *dev, u32 state, u32 level)
video/sa1100fb.c:static int sa1100fb_suspend(struct device *dev, u32 state, u32 level)
video/w100fb.c:static void w100_suspend(u32 mode);
video/w100fb.c:static int w100fb_suspend(struct device *dev, u32 state, u32 level)
video/w100fb.c:static void w100_suspend(u32 mode)

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
