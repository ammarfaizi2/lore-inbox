Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTEPV4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 17:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTEPV4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 17:56:14 -0400
Received: from imap.gmx.net ([213.165.65.60]:65337 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261670AbTEPV4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 17:56:11 -0400
Message-ID: <3EC56173.1000306@gmx.net>
Date: Sat, 17 May 2003 00:08:51 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: Andrew Morton <akpm@digeo.com>, rmk@arm.linux.org.uk,
       LKML <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: Re: 2.5.69-mm6: pccard oops while booting
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>	 <20030514191735.6fe0998c.akpm@digeo.com>	 <1052998601.726.1.camel@teapot.felipe-alfaro.com>	 <20030515130019.B30619@flint.arm.linux.org.uk>	 <1053004615.586.2.camel@teapot.felipe-alfaro.com>	 <20030515144439.A31491@flint.arm.linux.org.uk>	 <1053037915.569.2.camel@teapot.felipe-alfaro.com>	 <20030515160015.5dfea63f.akpm@digeo.com>	 <1053090184.653.0.camel@teapot.felipe-alfaro.com>	 <1053110098.648.1.camel@teapot.felipe-alfaro.com>	 <20030516132908.62e54266.akpm@digeo.com> <1053121346.569.1.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1053121346.569.1.camel@teapot.felipe-alfaro.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> On Fri, 2003-05-16 at 22:29, Andrew Morton wrote:
> 
>>Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>>
>>>Unable to handle kernel paging request at virtual address 50464d59
>>
>>hm, that address is "YMFP".   Please try generating the oops
>>again with the below patch applied:
>>
>> ./sound/pci/ymfpci/ymfpci.c      |    8 ++++----
>> ./sound/pci/ymfpci/ymfpci_main.c |   22 +++++++++++-----------
>> 2 files changed, 15 insertions(+), 15 deletions(-)
>>
>>diff -puN ./sound/pci/ymfpci/ymfpci_main.c~a ./sound/pci/ymfpci/ymfpci_main.c
>>--- 25/./sound/pci/ymfpci/ymfpci_main.c~a	2003-05-16 13:26:26.000000000 -0700
>>+++ 25-akpm/./sound/pci/ymfpci/ymfpci_main.c	2003-05-16 13:27:27.000000000 -0700
>>@@ -1093,7 +1093,7 @@ int __devinit snd_ymfpci_pcm(ymfpci_t *c
>> 
>> 	if (rpcm)
>> 		*rpcm = NULL;
>>-	if ((err = snd_pcm_new(chip->card, "YMFPCI", device, 32, 1, &pcm)) < 0)
>>+	if ((err = snd_pcm_new(chip->card, "1YMFPCI", device, 32, 1, &pcm)) < 0)
>> 		return err;
>> 	pcm->private_data = chip;
>> 	pcm->private_free = snd_ymfpci_pcm_free;
>>@@ -1103,7 +1103,7 @@ int __devinit snd_ymfpci_pcm(ymfpci_t *c
>> 
>> 	/* global setup */
>> 	pcm->info_flags = 0;
>>-	strcpy(pcm->name, "YMFPCI");
>>+	strcpy(pcm->name, "2YMFPCI");
>> 	chip->pcm = pcm;
>> 
>> 	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
>>@@ -1138,7 +1138,7 @@ int __devinit snd_ymfpci_pcm2(ymfpci_t *
>> 
>> 	if (rpcm)
>> 		*rpcm = NULL;
>>-	if ((err = snd_pcm_new(chip->card, "YMFPCI - AC'97", device, 0, 1, &pcm)) < 0)
>>+	if ((err = snd_pcm_new(chip->card, "3YMFPCI - AC'97", device, 0, 1, &pcm)) < 0)
>> 		return err;
>> 	pcm->private_data = chip;
>> 	pcm->private_free = snd_ymfpci_pcm2_free;
>>@@ -1147,7 +1147,7 @@ int __devinit snd_ymfpci_pcm2(ymfpci_t *
>> 
>> 	/* global setup */
>> 	pcm->info_flags = 0;
>>-	strcpy(pcm->name, "YMFPCI - AC'97");
>>+	strcpy(pcm->name, "4YMFPCI - AC'97");
>> 	chip->pcm2 = pcm;
>> 
>> 	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
>>@@ -1182,7 +1182,7 @@ int __devinit snd_ymfpci_pcm_spdif(ymfpc
>> 
>> 	if (rpcm)
>> 		*rpcm = NULL;
>>-	if ((err = snd_pcm_new(chip->card, "YMFPCI - IEC958", device, 1, 0, &pcm)) < 0)
>>+	if ((err = snd_pcm_new(chip->card, "5YMFPCI - IEC958", device, 1, 0, &pcm)) < 0)
>> 		return err;
>> 	pcm->private_data = chip;
>> 	pcm->private_free = snd_ymfpci_pcm_spdif_free;
>>@@ -1191,7 +1191,7 @@ int __devinit snd_ymfpci_pcm_spdif(ymfpc
>> 
>> 	/* global setup */
>> 	pcm->info_flags = 0;
>>-	strcpy(pcm->name, "YMFPCI - IEC958");
>>+	strcpy(pcm->name, "6YMFPCI - IEC958");
>> 	chip->pcm_spdif = pcm;
>> 
>> 	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
>>@@ -1226,7 +1226,7 @@ int __devinit snd_ymfpci_pcm_4ch(ymfpci_
>> 
>> 	if (rpcm)
>> 		*rpcm = NULL;
>>-	if ((err = snd_pcm_new(chip->card, "YMFPCI - Rear", device, 1, 0, &pcm)) < 0)
>>+	if ((err = snd_pcm_new(chip->card, "7YMFPCI - Rear", device, 1, 0, &pcm)) < 0)
>> 		return err;
>> 	pcm->private_data = chip;
>> 	pcm->private_free = snd_ymfpci_pcm_4ch_free;
>>@@ -1235,7 +1235,7 @@ int __devinit snd_ymfpci_pcm_4ch(ymfpci_
>> 
>> 	/* global setup */
>> 	pcm->info_flags = 0;
>>-	strcpy(pcm->name, "YMFPCI - Rear PCM");
>>+	strcpy(pcm->name, "8YMFPCI - Rear PCM");
>> 	chip->pcm_4ch = pcm;
>> 
>> 	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
>>@@ -1831,7 +1831,7 @@ static void snd_ymfpci_proc_read(snd_inf
>> {
>> 	// ymfpci_t *chip = snd_magic_cast(ymfpci_t, private_data, return);
>> 	
>>-	snd_iprintf(buffer, "YMFPCI\n\n");
>>+	snd_iprintf(buffer, "9YMFPCI\n\n");
>> }
>> 
>> static int __devinit snd_ymfpci_proc_init(snd_card_t * card, ymfpci_t *chip)
>>@@ -2226,12 +2226,12 @@ int __devinit snd_ymfpci_create(snd_card
>> 	chip->reg_area_virt = (unsigned long)ioremap_nocache(chip->reg_area_phys, 0x8000);
>> 	pci_set_master(pci);
>> 
>>-	if ((chip->res_reg_area = request_mem_region(chip->reg_area_phys, 0x8000, "YMFPCI")) == NULL) {
>>+	if ((chip->res_reg_area = request_mem_region(chip->reg_area_phys, 0x8000, "AYMFPCI")) == NULL) {
>> 		snd_ymfpci_free(chip);
>> 		snd_printk("unable to grab memory region 0x%lx-0x%lx\n", chip->reg_area_phys, chip->reg_area_phys + 0x8000 - 1);
>> 		return -EBUSY;
>> 	}
>>-	if (request_irq(pci->irq, snd_ymfpci_interrupt, SA_INTERRUPT|SA_SHIRQ, "YMFPCI", (void *) chip)) {
>>+	if (request_irq(pci->irq, snd_ymfpci_interrupt, SA_INTERRUPT|SA_SHIRQ, "BYMFPCI", (void *) chip)) {
>> 		snd_ymfpci_free(chip);
>> 		snd_printk("unable to grab IRQ %d\n", pci->irq);
>> 		return -EBUSY;
>>diff -puN ./sound/pci/ymfpci/ymfpci.c~a ./sound/pci/ymfpci/ymfpci.c
>>--- 25/./sound/pci/ymfpci/ymfpci.c~a	2003-05-16 13:26:26.000000000 -0700
>>+++ 25-akpm/./sound/pci/ymfpci/ymfpci.c	2003-05-16 13:27:49.000000000 -0700
>>@@ -122,7 +122,7 @@ static int __devinit snd_card_ymfpci_pro
>> 			fm_port[dev] = addr;
>> 		}
>> 		if (fm_port[dev] >= 0 &&
>>-		    (chip->fm_res = request_region(fm_port[dev], 4, "YMFPCI OPL3")) != NULL) {
>>+		    (chip->fm_res = request_region(fm_port[dev], 4, "CYMFPCI OPL3")) != NULL) {
>> 			legacy_ctrl |= YMFPCI_LEGACY_FMEN;
>> 			pci_write_config_word(pci, PCIR_DSXG_FMBASE, fm_port[dev]);
>> 		}
>>@@ -133,7 +133,7 @@ static int __devinit snd_card_ymfpci_pro
>> 			mpu_port[dev] = addr;
>> 		}
>> 		if (mpu_port[dev] >= 0 &&
>>-		    (chip->mpu_res = request_region(mpu_port[dev], 2, "YMFPCI MPU401")) != NULL) {
>>+		    (chip->mpu_res = request_region(mpu_port[dev], 2, "DYMFPCI MPU401")) != NULL) {
>> 			legacy_ctrl |= YMFPCI_LEGACY_MEN;
>> 			pci_write_config_word(pci, PCIR_DSXG_MPU401BASE, mpu_port[dev]);
>> 		}
>>@@ -146,7 +146,7 @@ static int __devinit snd_card_ymfpci_pro
>> 		default: fm_port[dev] = -1; break;
>> 		}
>> 		if (fm_port[dev] > 0 &&
>>-		    (chip->fm_res = request_region(fm_port[dev], 4, "YMFPCI OPL3")) != NULL) {
>>+		    (chip->fm_res = request_region(fm_port[dev], 4, "EYMFPCI OPL3")) != NULL) {
>> 			legacy_ctrl |= YMFPCI_LEGACY_FMEN;
>> 		} else {
>> 			legacy_ctrl2 &= ~YMFPCI_LEGACY2_FMIO;
>>@@ -160,7 +160,7 @@ static int __devinit snd_card_ymfpci_pro
>> 		default: mpu_port[dev] = -1; break;
>> 		}
>> 		if (mpu_port[dev] > 0 &&
>>-		    (chip->mpu_res = request_region(mpu_port[dev], 2, "YMFPCI MPU401")) != NULL) {
>>+		    (chip->mpu_res = request_region(mpu_port[dev], 2, "FYMFPCI MPU401")) != NULL) {
>> 			legacy_ctrl |= YMFPCI_LEGACY_MEN;
>> 		} else {
>> 			legacy_ctrl2 &= ~YMFPCI_LEGACY2_MPUIO;
>>
> 
> 
> I've applied the patch above to a pristine 2.5.69-mm6. Curiously, if I
> build snd-ymfpci as a module, I can't reproduce the oops anymore.
> However, if I build snd-ymfpci into the kernel, I can *still* reproduce
> the oops.
> 
> Attached is the dmesg of a 2.5.69-mm6 plus the above patch with ymfpci
> integrated into the kernel.
> 
> Thanks!
> 
> Unable to handle kernel paging request at virtual address 25007367

Unfortunately, now the address is gs\0%
This does not help that much. Could you please backout above patch, hand
edit it so that each YMFPCI -> 1YMFPCI, YMFPCI -> 2YMFPCI etc. change
looks instead like
YMFPCI -> 1MFPCI, YMFPCI -> 2MFPCI so that the string length and the
first 3 bytes of the address stay constant and apply it again? That may
give us better results.

Thanks,
Carl-Daniel
-- 
http://www.hailfinger.org/

