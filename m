Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161179AbWKUVT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161179AbWKUVT0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161363AbWKUVT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:19:26 -0500
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:173 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S1161179AbWKUVTX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:19:23 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] CISS: require same SCSI module support
Date: Tue, 21 Nov 2006 15:19:21 -0600
Message-ID: <E717642AF17E744CA95C070CA815AE55D8DDA3@cceexc23.americas.cpqcorp.net>
In-Reply-To: <20061121110610.d72e3976.randy.dunlap@oracle.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] CISS: require same SCSI module support
Thread-Index: AccNoBqvdVHlocFpTwS5/3MEqZUnIwAEn6+g
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>,
       "scsi" <linux-scsi@vger.kernel.org>
Cc: "ISS StorageDev" <iss_storagedev@hp.com>, "akpm" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Nov 2006 21:19:22.0091 (UTC) FILETIME=[B685CBB0:01C70DB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Randy Dunlap [mailto:randy.dunlap@oracle.com] 
> Sent: Tuesday, November 21, 2006 1:06 PM
> To: scsi
> Cc: Miller, Mike (OS Dev); ISS StorageDev; akpm
> Subject: [PATCH] CISS: require same SCSI module support
> 
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Building CCISS SCSI tape support in-kernel when SCSI=m causes 
> build errors, so require SCSI support to be =y or same as 
> CCISS SCSI tape support.
> 
> drivers/built-in.o: In function `cciss_remove_one':
> cciss.c:(.text+0x79d4c): undefined reference to `scsi_remove_host'
> cciss.c:(.text+0x79d55): undefined reference to `scsi_host_put'
> drivers/built-in.o: In function `cciss_update_non_disk_devices':
> cciss.c:(.text+0x7bb54): undefined reference to `scsi_device_type'
> cciss.c:(.text+0x7bcc8): undefined reference to `scsi_device_type'
> cciss.c:(.text+0x7be81): undefined reference to `scsi_device_type'
> cciss.c:(.text+0x7bf81): undefined reference to `scsi_device_type'
> drivers/built-in.o: In function `cciss_proc_write':
> cciss.c:(.text+0x7c175): undefined reference to `scsi_host_alloc'
> cciss.c:(.text+0x7c1ed): undefined reference to `scsi_add_host'
> cciss.c:(.text+0x7c1f9): undefined reference to `scsi_scan_host'
> cciss.c:(.text+0x7c206): undefined reference to `scsi_host_put'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Acked-by: Mike Miller <mike.miller@hp.com>

> ---
>  drivers/block/Kconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-2619-rc6g3.orig/drivers/block/Kconfig
> +++ linux-2619-rc6g3/drivers/block/Kconfig
> @@ -168,7 +168,8 @@ config BLK_CPQ_CISS_DA
>  
>  config CISS_SCSI_TAPE
>  	bool "SCSI tape drive support for Smart Array 5xxx"
> -	depends on BLK_CPQ_CISS_DA && SCSI && PROC_FS
> +	depends on BLK_CPQ_CISS_DA && PROC_FS
> +	depends on SCSI=y || SCSI=BLK_CPQ_CISS_DA
>  	help
>  	  When enabled (Y), this option allows SCSI tape drives 
> and SCSI medium
>  	  changers (tape robots) to be accessed via a Compaq 5xxx array 
> 
> 
> ---
> 
