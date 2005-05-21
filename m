Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVEUNRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVEUNRj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 09:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVEUNRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 09:17:38 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:49226 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261279AbVEUNRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 09:17:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=d47qB6dHsgsC/NvHEv7Sd6qBBNpBIYuxAAsV151jDS4rysZULL11DPePiTP12NNo1HzRvlEPQZsifP+7KaKnxIorsvw1jsg6sE5P5fEw45HItbJ9A8g5cfR60uKewEydFqEvMNSFJlQRgod+fCPp4KkyCK79eJXkXi7xjtF7kl4=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Pete Clements <clem@clem.clem-digital.net>
Subject: Re: 2.6.12-rc4-git5 fails compile -- aic7xxx_osm.c
Date: Sat, 21 May 2005 17:21:28 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200505211224.j4LCOrk5000537@clem.clem-digital.net>
In-Reply-To: <200505211224.j4LCOrk5000537@clem.clem-digital.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505211721.28395.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 May 2005 16:24, Pete Clements wrote:

>   CC      drivers/scsi/aic7xxx/aic7xxx_osm.o
> drivers/scsi/aic7xxx/aic7xxx_osm.c: In function `ahc_linux_slave_alloc':
> drivers/scsi/aic7xxx/aic7xxx_osm.c:663: parse error before `struct'
> drivers/scsi/aic7xxx/aic7xxx_osm.c:667: `sc' undeclared (first use in this function)

Just sent this to James Bottomley.

--- linux-20050521140543-000/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-05-21 14:11:06.000000000 +0400
+++ linux-20050521140543-001/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-05-21 16:49:32.000000000 +0400
@@ -659,8 +659,10 @@ ahc_linux_slave_alloc(struct scsi_device
 	ahc_lock(ahc, &flags);
 	targ = ahc->platform_data->targets[target_offset];
 	if (targ == NULL) {
+		struct seeprom_config *sc;
+
 		targ = ahc_linux_alloc_target(ahc, starget->channel, starget->id);
-		struct seeprom_config *sc = ahc->seep_config;
+		sc = ahc->seep_config;
 		if (targ == NULL)
 			goto out;
 
