Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVCGInN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVCGInN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVCGInN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:43:13 -0500
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:63365 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261708AbVCGImW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:42:22 -0500
From: Borislav Petkov <petkov@uni-muenster.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-mm1
Date: Mon, 7 Mar 2005 09:41:59 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050304033215.1ffa8fec.akpm@osdl.org>
In-Reply-To: <20050304033215.1ffa8fec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503070941.59365.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 March 2005 12:32, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11
>-mm1/
>
<snip>

Hi,

the ymfpci sound driver wouldn't compile without gameport support selected 
since the sound card has a gameport on it:

Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>

--- sound/pci/ymfpci/ymfpci.c.orig 2005-03-07 09:07:10.000000000 +0100
+++ sound/pci/ymfpci/ymfpci.c 2005-03-07 09:08:02.000000000 +0100
@@ -332,7 +332,9 @@ static int __devinit snd_card_ymfpci_pro
   }
  }
 
+#ifdef SUPPORT_JOYSTICK
  snd_ymfpci_create_gameport(chip, dev, legacy_ctrl, legacy_ctrl2);
+#endif /* SUPPORT_JOYSTICK */
 
  if ((err = snd_card_register(card)) < 0) {
   snd_card_free(card);
