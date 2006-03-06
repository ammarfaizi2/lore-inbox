Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752296AbWCFIx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbWCFIx3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752297AbWCFIx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:53:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42213 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752260AbWCFIx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:53:28 -0500
Date: Mon, 6 Mar 2006 03:53:17 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: tiwai@suse.de
Subject: emu10k1_synth use after free
Message-ID: <20060306085317.GA19831@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, tiwai@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thou shalt not dereference freed memory.

Coverity bug #958

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/sound/pci/emu10k1/emu10k1_synth.c~	2006-03-06 03:51:26.000000000 -0500
+++ linux-2.6/sound/pci/emu10k1/emu10k1_synth.c	2006-03-06 03:51:36.000000000 -0500
@@ -62,7 +62,6 @@ static int snd_emu10k1_synth_new_device(
 
 	if (snd_emux_register(emu, dev->card, arg->index, "Emu10k1") < 0) {
 		snd_emux_free(emu);
-		emu->hw = NULL;
 		return -ENOMEM;
 	}
 

-- 
http://www.codemonkey.org.uk
