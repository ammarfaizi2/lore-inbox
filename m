Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUKTLf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUKTLf4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 06:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbUKTLf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 06:35:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36620 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261685AbUKTLfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 06:35:48 -0500
Date: Sat, 20 Nov 2004 12:35:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch] 2.6.10-rc2-mm2: OSS ac97_codec.h: #include pci.h
Message-ID: <20041120113545.GC2754@stusta.de>
References: <20041118021538.5764d58c.akpm@osdl.org> <20041118124220.GB2268@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118124220.GB2268@holomorphy.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 04:42:20AM -0800, William Lee Irwin III wrote:
> On Thu, Nov 18, 2004 at 02:15:38AM -0800, Andrew Morton wrote:
> > +oss-ac97-quirk-facility.patch
> >  Add and use device quirk lists in this OSS driver
> 
> That patch may not actually be responsible for the warning. It's
> trivially resolved regardless.
> 
> This patch adds a forward declaration of struct pci_dev to repair the
> following warning:
> 
> In file included from sound/oss/emu10k1/hwaccess.h:38,
>                  from sound/oss/emu10k1/cardmi.c:36:
> include/linux/ac97_codec.h:337: warning: `struct pci_dev' declared inside parameter list
> include/linux/ac97_codec.h:337: warning: its scope is only this definition or declaration, which is probably not what you want
> 
> Index: mm2-2.6.10-rc2/include/linux/ac97_codec.h
> ===================================================================
> --- mm2-2.6.10-rc2.orig/include/linux/ac97_codec.h	2004-11-18 02:56:31.000000000 -0800
> +++ mm2-2.6.10-rc2/include/linux/ac97_codec.h	2004-11-18 03:53:05.308878784 -0800
> @@ -334,6 +334,7 @@
>  	int type;               /* quirk type above */
>  };
>  
> +struct pci_dev;
>  extern int ac97_tune_hardware(struct pci_dev *pdev, struct ac97_quirk *quirk, int override);
>  
>  #endif /* _AC97_CODEC_H_ */


Wouldn't it be better to simply #include pci.h?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/include/linux/ac97_codec.h.old	2004-11-20 12:11:31.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/include/linux/ac97_codec.h	2004-11-20 12:12:26.000000000 +0100
@@ -3,6 +3,7 @@
 
 #include <linux/types.h>
 #include <linux/soundcard.h>
+#include <linux/pci.h>
 
 /* AC97 1.0 */
 #define  AC97_RESET               0x0000      //


