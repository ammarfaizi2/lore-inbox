Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbSKKWs5>; Mon, 11 Nov 2002 17:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261565AbSKKWs4>; Mon, 11 Nov 2002 17:48:56 -0500
Received: from elin.scali.no ([62.70.89.10]:37391 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S261559AbSKKWsz>;
	Mon, 11 Nov 2002 17:48:55 -0500
Date: Mon, 11 Nov 2002 23:56:32 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Fixup pci_alloc_consistent with 64bit DMA masks on i386
Message-ID: <Pine.LNX.4.44.0211112348570.1118-200000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463794943-629297067-1037055392=:1118"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463794943-629297067-1037055392=:1118
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Marcello,

I posted this small one-liner to Alan Cox (and to the lkml) in August but 
it doesn't seem to have gotten into the mainline yet (I think it is in -ac).

The issue is that PCI drivers which uses 64bit DMA masks (in order to do 
DAC) is making unnecessary use of the DMA zone memory (the <16Meg region 
on i386) when doing pci_alloc_consitent().

Hope this gets into the next -rc or .21-pre

Regards,
-- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY


---1463794943-629297067-1037055392=:1118
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pci-dma.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0211112356320.1118@sp-laptop.isdn.scali.no>
Content-Description: 
Content-Disposition: attachment; filename="pci-dma.patch"

LS0tIGxpbnV4LTIuNC4xOS1vbGQvYXJjaC9pMzg2L2tlcm5lbC9wY2ktZG1h
LmMufjF+CVdlZCBBdWcgMTQgMTU6MDY6NDkgMjAwMg0KKysrIGxpbnV4LTIu
NC4xOS9hcmNoL2kzODYva2VybmVsL3BjaS1kbWEuYwlXZWQgQXVnIDE0IDE1
OjA4OjI5IDIwMDINCkBAIC0xOSw3ICsxOSw3IEBADQogCXZvaWQgKnJldDsN
CiAJaW50IGdmcCA9IEdGUF9BVE9NSUM7DQogDQotCWlmIChod2RldiA9PSBO
VUxMIHx8IGh3ZGV2LT5kbWFfbWFzayAhPSAweGZmZmZmZmZmKQ0KKwlpZiAo
aHdkZXYgPT0gTlVMTCB8fCBod2Rldi0+ZG1hX21hc2sgPCAweGZmZmZmZmZm
KQ0KIAkJZ2ZwIHw9IEdGUF9ETUE7DQogCXJldCA9ICh2b2lkICopX19nZXRf
ZnJlZV9wYWdlcyhnZnAsIGdldF9vcmRlcihzaXplKSk7DQogDQo=
---1463794943-629297067-1037055392=:1118--
