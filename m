Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031409AbWKUUdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031409AbWKUUdb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031411AbWKUUdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:33:31 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:43496 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1031409AbWKUUda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:33:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=U4Sb4pL7Lk724gB/QiWCfztKG5RWgyNLLSnKmFmb5m1DK0jc9JLdPJx81QShes9XMIEihAWgiNCLkD+kBxv/ZpuWnprIvobq8GyC4xk976ozcODGk4Drdm3sOouLhB/GHTAwQig3hsV+aCS2Z7b4YD54l68yX5vGSQr+yD+IEYA=
Message-ID: <a769871e0611211233n20eb9d74j661cd73e9315fade@mail.gmail.com>
Date: Tue, 21 Nov 2006 21:33:29 +0100
From: wbrana@gmail.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] snd-hda-intel: fix insufficient memory
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Module allocates insufficient memory for multichannel and high quality
audio (96 kHz, 24 bit)
Patch for 2.6.19-* changes default/maximal size from 64/128 to 256/4096 kB.

--- sound/pci/hda/hda_intel.c.orig      2006-09-29 13:40:36.000000000 +0200
+++ sound/pci/hda/hda_intel.c   2006-11-05 16:45:13.000000000 +0100
@@ -1270,5 +1270,5 @@
        snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
                                              snd_dma_pci_data(chip->pci),
-                                             1024 * 64, 1024 * 128);
+                                             1024 * 256, 1024 * 4096);
        chip->pcm[pcm_dev] = pcm;
        if (chip->pcm_devs < pcm_dev + 1)
