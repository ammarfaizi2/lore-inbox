Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262049AbREXOb5>; Thu, 24 May 2001 10:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbREXObr>; Thu, 24 May 2001 10:31:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27155 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262040AbREXObk>; Thu, 24 May 2001 10:31:40 -0400
Subject: Re: [PATCH] sd.c - null ptr fixes for 2.4.4
To: praveens@stanford.edu (Praveen Srinivasan)
Date: Thu, 24 May 2001 15:28:31 +0100 (BST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, linux-scsi@vger.kernel.org
In-Reply-To: <200105240736.f4O7aK404397@smtp1.Stanford.EDU> from "Praveen Srinivasan" at May 24, 2001 12:37:30 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152w6K-000530-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch fixes a couple of errors in the scsi driver code (sd.c).
> 
> --- ../linux/./drivers/scsi/sd.c	Sat Feb  3 11:45:55 2001
> +++ ./drivers/scsi/sd.c	Mon May  7 22:09:58 2001
> @@ -734,8 +734,15 @@
>  	 */
>  
>  	SRpnt = scsi_allocate_request(rscsi_disks[i].device);
> +	if(SRpnt == NULL) {
> +	  return i;
> +	}
>  
>  	buffer = (unsigned char *) scsi_malloc(512);
> +       
> +	if(buffer == NULL) {
> +	  return i;

You need to return the request surely 

> 

