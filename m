Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbUBTOn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 09:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbUBTOn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 09:43:26 -0500
Received: from hoemail2.lucent.com ([192.11.226.163]:14802 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S261240AbUBTOnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 09:43:24 -0500
Message-ID: <40361D06.5050703@lucent.com>
Date: Fri, 20 Feb 2004 08:43:18 -0600
From: Arthur Crosby Smith <arthursmith@lucent.com>
Organization: Lucent Technologies
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0 (CK-LucentTPES)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Lost Master control on MSI 645?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found that I lost the Master control on my mixer (alsamixer) with 2.6.3. I see
that an ac97_quirk (linux/sound/pci/intel8x0.c) had been added for an "MSI P4 ATX
645 Ultra" motherboard. I have an MSI 645E Max-U (MS-6547) (v2.1) Motherboard and
it seems to trigger this. The quirk tries to move the headphone output control to
the master control. Unfortunately, my motherboard doesn't have a headphone control
so this just removes my Master control. This patch checks to see if the headphone
control exists before removing the master control. With this patch, my Master
control shows up again...
  Art


--- orig/sound/pci/ac97/ac97_codec.c    2004-02-19 13:32:28.000000000 -0600
+++ linux/sound/pci/ac97/ac97_codec.c   2004-02-19 13:19:25.000000000 -0600
@@ -2112,6 +2112,7 @@ static int swap_headphone(ac97_t *ac97,
 {
        /* FIXME: error checks.. */
        if (remove_master) {
+               if (ctl_find(ac97,"Headphone Playback Switch") == NULL) return 0;
                snd_ac97_remove_ctl(ac97, "Master Playback Switch");
                snd_ac97_remove_ctl(ac97, "Master Playback Volume");
        } else {

