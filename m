Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423875AbWKIPRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423875AbWKIPRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423986AbWKIPRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:17:03 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:17308 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423875AbWKIPRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:17:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iCz2riE60PPa7ZKamlT7K5t+i29p/OGzx1xNEokknnNem7jFN3+AI7hHZ8+VRAfJ1qiZQ45cnSVF4EqImRLoRpogJJokUg/Hhrt6+9iMQFK2r0NNYm+TqjnORLSDb3fXkzwEOBCdLUnMRuPXxc8PfO66gkG+Mij0zWU1HGmeYMc=
Message-ID: <5a4c581d0611090717y7d1fdf98t2f1a84b7c5e4d6f2@mail.gmail.com>
Date: Thu, 9 Nov 2006 15:17:00 +0000
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: Stephen.Clark@seclark.us
Subject: Re: Abysmal PATA IDE performance
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "=?ISO-8859-1?Q?\"\\\"J.A.\\\"_Magall=F3n\"?=" <jamagallon@ono.com>,
       "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
       "Mark Lord" <lkml@rtr.ca>, linux-kernel <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <45533DB9.4000405@seclark.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <455206E7.2050104@seclark.us> <45526D50.5020105@rtr.ca>
	 <455277E1.3040803@seclark.us> <20061109020758.GA21537@atjola.homenet>
	 <4552A638.4010207@seclark.us> <20061109094014.1c8b6bed@werewolf-wl>
	 <1163062700.3138.467.camel@laptopd505.fenrus.org>
	 <45533DB9.4000405@seclark.us>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/06, Stephen Clark <Stephen.Clark@seclark.us> wrote:
> Arjan van de Ven wrote:
>
> >>Probably your drives are renamed.
> >>Before you had (wild guess, look at your boot log messages):
> >>- ata bus -> hdc,hdd
> >>- sata -> sda (if you really have any sata bus...)
> >>
> >>Now all hdX become sdX, and PATA is detected _before_ SATA, so you names
> >>probaly became:
> >>- ata via libata -> sda (HD), sr0 (CDROM)
> >>- sata -> sdb.
> >>
> >>
> >
> >on fedora this doesn't matter (due to mount-by-label)
> >
> >the bigger problem I suspect is that the sata modules aren't part of the
> >initrd!
> >
> >you can force the issue by adding
> >
> >alias scsi_hostadapter1 ata_piix
> >
> >to the /etc/modprobe.conf file, and then recreating the initrd
> >(see the mkinitrd tool, or just install the kernel rpm)
> >
> >
> >
> >
> >
> >
> Thanks all.
>
> Arjan, using combined_mode=libata and making a new ramdisk increased my
> xfer rate from 1.xx mb/sec to 28.xx mb/sec.
>
> I am curious as to why my friends dell inspiron 8200 with a 1.8ghz p4
> and the same drive using the same drive with FC6 and the standard ide
> module gets 44 to 45 mb/sec.

The figures are so similar to the problem I recently posted that you
 might want to give a shot at unloading ehci_hcd module, then try
 again getting performance numbers from the IDE disk. In my case
 unloading ehci_hcd boosts IDE performance from 20 to 40MB/s
 (but of course kills USB2 disk performance).

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
