Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285669AbRLYR5A>; Tue, 25 Dec 2001 12:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285671AbRLYR4u>; Tue, 25 Dec 2001 12:56:50 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:59296 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S285669AbRLYR4i>;
	Tue, 25 Dec 2001 12:56:38 -0500
Date: Tue, 25 Dec 2001 12:56:37 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Jason Thomas <jason@topic.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] link errors with internal calls to devexit functions
Message-ID: <20011225125637.A21718@havoc.gtf.org>
In-Reply-To: <20011222025725.GA629@topic.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011222025725.GA629@topic.com.au>; from jason@topic.com.au on Sat, Dec 22, 2001 at 01:57:25PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2001 at 01:57:25PM +1100, Jason Thomas wrote:
> please CC me I'm not on the list.
> 
> This patch against 2.4.17 fixes internal calls to devexit functions (which
> is bypasses the devexit_p wrapper) in drivers/media/video/bttv-driver.c and
> drivers/usb/usb-uhci.c, they are the only two I found.
> 
> diff -ur linux-2.4.17.orig/drivers/media/video/bttv-driver.c linux-2.4.17/drivers/media/video/bttv-driver.c
> --- linux-2.4.17.orig/drivers/media/video/bttv-driver.c Sat Dec 22 13:39:39 2001
> +++ linux-2.4.17/drivers/media/video/bttv-driver.c      Sat Dec 22 13:46:02 2001
> @@ -2992,7 +2992,9 @@
>         pci_set_drvdata(dev,btv);
>  
>         if(init_bt848(btv) < 0) {
> +#if defined(MODULE) || defined(CONFIG_HOTPLUG)
>                 bttv_remove(dev);
> +#endif

These changes are incorrect... if a remove function is called during the
init phase it should never have been marked __devexit in the first
place.

	Jeff


