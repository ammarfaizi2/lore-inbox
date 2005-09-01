Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbVIAUAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbVIAUAY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbVIAUAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:00:23 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:23944 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1030341AbVIAUAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:00:21 -0400
Message-ID: <43175DAD.3020404@gmail.com>
Date: Thu, 01 Sep 2005 21:59:41 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: dwalker@mvista.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] Unhandled error condition in aic79xx
References: <1125603501.4867.21.camel@dhcp153.mvista.com>
In-Reply-To: <1125603501.4867.21.camel@dhcp153.mvista.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker napsal(a):

>This patch should handle the case when scsi_add_host() fails.
>
>Signed-Off-By: Daniel Walker <dwalker@mvista.com>
>
>Index: linux-2.6.13/drivers/scsi/aic7xxx/aic79xx_osm.c
>===================================================================
>--- linux-2.6.13.orig/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-08-28 23:41:01.000000000 +0000
>+++ linux-2.6.13/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-08-31 18:49:09.000000000 +0000
>@@ -1989,6 +1989,7 @@ ahd_linux_register_host(struct ahd_softc
> 	char	*new_name;
> 	u_long	s;
> 	u_long	target;
>+	int error = 0;
> 
> 	template->name = ahd->description;
> 	host = scsi_host_alloc(template, sizeof(struct ahd_softc *));
>@@ -2065,7 +2066,11 @@ ahd_linux_register_host(struct ahd_softc
> 	ahd_unlock(ahd, &s);
> 
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
>  
>
Maybe this could go away.

>-	scsi_add_host(host, &ahd->dev_softc->dev); /* XXX handle failure */
>+	error = scsi_add_host(host, &ahd->dev_softc->dev); 
>+	if (error) {
>+		scsi_host_put(host);
>+		return(error);
>  
>
no ( ) around return value, please

>+	}
> 	scsi_scan_host(host);
> #endif
> 	return (0);
>  
>
regards,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

