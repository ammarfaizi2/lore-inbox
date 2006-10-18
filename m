Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWJREQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWJREQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 00:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWJREQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 00:16:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:10936 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751198AbWJREQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 00:16:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gv/WSjwWt2O7nnv8701xei3wmB7zC5y075Qbv4pdtdDx2flwZ0hNi8zlaWt/hWpDWBkLJ+JBE8VsomnVL4RG6LjYAw5nHck55FHWydTsUBmePzJHqW1f6bmEPjQuhiuy7wiVqPf0WW46OwHLVB+tRKTcCLm+F1HgrbuIze6RSew=
Message-ID: <5aa69f860610172116j5c7da60fm589ed81deee6dba@mail.gmail.com>
Date: Wed, 18 Oct 2006 07:16:45 +0300
From: "Fatih Asici" <asici.f@gmail.com>
Reply-To: fatih.asici@gmail.com
To: "Linux List" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC: 2.6.19 patch] snd-hda-intel: default MSI to off
In-Reply-To: <20061017211301.GE3502@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610050938.10997.prakash@punnoor.de>
	 <5aa69f860610051030l7323ec2el545873570052f077@mail.gmail.com>
	 <200610052309.01155.prakash@punnoor.de>
	 <20061017211301.GE3502@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Thu, Oct 05, 2006 at 11:08:57PM +0200, Prakash Punnoor wrote:
> > Am Donnerstag 05 Oktober 2006 19:30 schrieb Fatih A????c??:
> > > 2006/10/5, Prakash Punnoor <prakash@punnoor.de>:
> > > > Hi,
> > > >
> > > > subjects say it all. Without irqpoll my nic doesn't work anymore. I added
> > > > Ingo
> > > > to cc, as my IRQs look different, so it may be a prob of APIC routing or
> > > > the
> > > > like.
> >
> > > > Can you try booting with pci=nomsi ? I have a similar problem with my
> >
> > I used snd-hda-intel.disable_msi=1 and this actually helped! Now the nforce
> > nic works w/o problems. So it was the audio driver causing havoc on the nic.
> >...
>
> Unless someone finds and fixes what causes such problems, I'd therefore
> suggest the patch below to let MSI support to be turned off by default.
>

What about putting MCP51 to the msi quirk list?


diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 23b599d..75311df 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1716,6 +1716,7 @@ static void __devinit quirk_disable_msi(
       }
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_disable_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA,
PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_BRIDGE, quirk_disable_msi);

 /* Go through the list of Hypertransport capabilities and
 * return 1 if a HT MSI capability is found and enabled */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f069df2..03cb469 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1146,6 +1146,7 @@ #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP5
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE  0x0265
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA 0x0266
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2        0x0267
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_BRIDGE       0x026F
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SMBUS        0x0368
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE  0x036E
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA 0x037E
