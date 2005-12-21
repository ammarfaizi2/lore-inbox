Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVLUVlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVLUVlm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbVLUVlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:41:42 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:58791 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751131AbVLUVll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:41:41 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6.15-rc5-mm3] Remove duplicated PCI id
Date: Thu, 22 Dec 2005 08:41:11 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <ssijq1pm97c49f1l9qn9j2qsd6572fhc8e@4ax.com>
References: <s5hmziuzdde.wl%tiwai@suse.de>
In-Reply-To: <s5hmziuzdde.wl%tiwai@suse.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2005 16:19:41 +0100, Takashi Iwai <tiwai@suse.de> wrote:

>The patch removes the duplicated PCI ID entry in pci_ids.h.
>
>Signed-off-by: Takashi Iwai <tiwai@suse.de>
>
>---
> pci_ids.h |    2 --
> 1 files changed, 2 deletions(-)
>
>--- linux-2.6.15-rc5/include/linux/pci_ids.h	2005-12-21 15:58:57.000000000 +0100
>+++ linux-2.6.15-rc5/include/linux/pci_ids.h	2005-12-21 15:59:13.000000000 +0100
>@@ -502,8 +502,6 @@
> #define PCI_DEVICE_ID_AMD_CS5536_UOC    0x2097
> #define PCI_DEVICE_ID_AMD_CS5536_IDE    0x209A
> 
>-#define PCI_DEVICE_ID_AMD_CS5536_IDE	0x209A
>-
> #define PCI_VENDOR_ID_TRIDENT		0x1023
> #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
> #define PCI_DEVICE_ID_TRIDENT_4DWAVE_NX	0x2001

I just unpacked fresh 2.67.15-rc5, -rc5-mm3 and -rc6, only -rc5-mm3 seems 
to have duplicated ID entries, for which a patch was sent on 
http://lkml.org/lkml/2005/11/23/528 against linux-2.6.15-rc2-mm1 
and that patch still applies to rc5-mm3 with a one line offset.

Current pci_ids.h status:

grant@sempro:~/linux$ do-device-id linux-2.6.15-rc5
find pci_ids defined
find symbols in source tree
find source defined symbols files
summary, line counts:
  1796 symbols-pci_ids.h-define
     0 symbols-pci_ids.h-dups
  2193 symbols-pci_ids.h-new
  2193 symbols-pci_ids.h-orig
  1932 symbols-source-all
   433 symbols-source-define
   104 symbols-source-define-files
  1214 symbols-source-files-include-pci.h
    29 symbols-source-files-include-pci_ids.h
grant@sempro:~/linux$ do-device-id linux-2.6.15-rc6
find pci_ids defined
find symbols in source tree
find source defined symbols files
summary, line counts:
  1797 symbols-pci_ids.h-define
     0 symbols-pci_ids.h-dups
  2194 symbols-pci_ids.h-new
  2194 symbols-pci_ids.h-orig
  1933 symbols-source-all
   433 symbols-source-define
   104 symbols-source-define-files
  1214 symbols-source-files-include-pci.h
    29 symbols-source-files-include-pci_ids.h
grant@sempro:~/linux$ do-device-id linux-2.6.15-rc5-mm3/
find pci_ids defined
find symbols in source tree
find source defined symbols files
summary, line counts:
   1812 symbols-pci_ids.h-define
      2 symbols-pci_ids.h-dups
   2217 symbols-pci_ids.h-new
   2217 symbols-pci_ids.h-orig
   2106 symbols-source-all
   2092 symbols-source-define
    112 symbols-source-define-files
   1253 symbols-source-files-include-pci.h
     37 symbols-source-files-include-pci_ids.h
grant@sempro:~/linux$ cat symbols-pci_ids.h-dups
PCI_DEVICE_ID_AMD_CS5536_IDE
PCI_DEVICE_ID_NS_CS5535_IDE

Grant.
