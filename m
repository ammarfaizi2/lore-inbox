Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWETAJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWETAJI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 20:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWETAJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 20:09:08 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:42949 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1751442AbWETAJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 20:09:07 -0400
Date: Sat, 20 May 2006 01:08:58 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: dummy@vaio.testbed.de
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: SCSI ABORT with 2.6.17-rc4-mm1
In-Reply-To: <20060519141032.23de6eee.akpm@osdl.org>
Message-ID: <Pine.NEB.4.64.0605200058040.4276@vaio.testbed.de>
References: <62331.192.18.1.5.1148071784.squirrel@housecafe.dyndns.org>
 <20060519141032.23de6eee.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1704218617-1148083738=:4276"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1704218617-1148083738=:4276
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi there,

On Fri, 19 May 2006, Andrew Morton wrote:
> DMI 2.2 present.
> +ACPI: Unable to map RSDT header
> +node 0 zone Normal missaligned start pfn, enable UNALIGNED_ZONE_BOUNDRIES
> +node 0 zone HighMem missaligned start pfn, enable UNALIGNED_ZONE_BOUNDRIES

gah, diff(1) is actually not new to me, but I forgot to use it :(
Thanks for spotting this!

> Or, if you're super-keen,
> http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 is my current rollup
> (against 2.6.17-rc4).  It was compilable this morning, but I've since
> merged stuff ;) It would be interesting to know if that has fixed the bug.

I tried to be "super-keen" and applied x.bz2 to pristine 2.6.17-rc4, but 
the scsi error persists (logs, .config coming in a few minutes.)

Furthermore, I had to do 2 more things to get rc4-mm* compiling:

1) apply the attached patch, as the compile breaks with:

      CC      drivers/pci/msi-apic.o
In file included from include/asm/msi.h:11,
                  from drivers/pci/msi.h:71,
                  from drivers/pci/msi-apic.c:8:
include/asm/smp.h:103: error: syntax error before '->' token
make[2]: *** [drivers/pci/msi-apic.o] Error 1
make[1]: *** [drivers/pci] Error 2
make: *** [drivers] Error 2

(this has been reported with 2.6.17-rc3-mm1, but was not fixed?)

2) disable CONFIG_ROOT_NFS=y, as the compile breaks with:

   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
fs/built-in.o: In function `nfs_root_setup':nfsroot.c:(.init.text+0x1809): 
undefined reference to `root_nfs_parse_addr'
:nfsroot.c:(.init.text+0x1810): undefined reference to `root_server_addr'
fs/built-in.o: In function `nfs_root_data': undefined reference to 
`root_server_path'
fs/built-in.o: In function `nfs_root_data': undefined reference to 
`root_server_addr'

As said before, .config and dmesg for rc4-mm2 in a moment, netconsole is 
not working...hm.

Thank you!
Christian.
-- 
"No one talks peace unless he's ready to back it up with war."
"He talks of peace if it is the only way to live."
 		-- Colonel Green and Surak of Vulcan, "The Savage Curtain",
 		   stardate 5906.5.
--0-1704218617-1148083738=:4276
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=msi-apic.c_2.6.17-rc4-mm1.diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.NEB.4.64.0605200108580.4276@vaio.testbed.de>
Content-Description: 
Content-Disposition: attachment; filename=msi-apic.c_2.6.17-rc4-mm1.diff

LS0tIGxpbnV4LTIuNi1tbS9kcml2ZXJzL3BjaS9tc2ktYXBpYy5jLm9yaWcJ
MjAwNi0wNS0xOCAwNDowNzoyMy4xMTMxNjQzNTIgKzAyMDANCisrKyBsaW51
eC0yLjYtbW0vZHJpdmVycy9wY2kvbXNpLWFwaWMuYwkyMDA2LTA1LTE4IDA0
OjA3OjM4LjM1OTg0NjUwNCArMDIwMA0KQEAgLTQsNiArNCw3IEBADQogDQog
I2luY2x1ZGUgPGxpbnV4L3BjaS5oPg0KICNpbmNsdWRlIDxsaW51eC9pcnEu
aD4NCisjaW5jbHVkZSA8YXNtL3NtcC5oPg0KIA0KICNpbmNsdWRlICJtc2ku
aCINCiANCg==

--0-1704218617-1148083738=:4276--
