Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbSKJOHK>; Sun, 10 Nov 2002 09:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264890AbSKJOHK>; Sun, 10 Nov 2002 09:07:10 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:25248 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264886AbSKJOHJ>; Sun, 10 Nov 2002 09:07:09 -0500
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0211101124070.20578-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0211101124070.20578-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Nov 2002 14:38:00 +0000
Message-Id: <1036939080.1005.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-10 at 10:27, Geert Uytterhoeven wrote:
ut soft reset.
>   */
> -int esp_reset(Scsi_Cmnd *SCptr, unsigned int how)
> +int esp_reset(Scsi_Cmnd *SCptr)
>  {
>  	struct NCR_ESP *esp = (struct NCR_ESP *) SCptr->host->hostdata;
>  
>  	(void) esp_do_resetbus(esp, esp->eregs);
> -	return SCSI_RESET_PENDING;
> +	wait_event(esp->reset_queue, (esp->resetting_bus == 0));
> +
> +	return SUCCESS;
>  }

Reset is called with the lock held surely. How can the wait_event be
right ? 

