Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263395AbRFASbP>; Fri, 1 Jun 2001 14:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263660AbRFASbF>; Fri, 1 Jun 2001 14:31:05 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:9221 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S263395AbRFASaw>;
	Fri, 1 Jun 2001 14:30:52 -0400
Message-ID: <20010601190203.A4723@bug.ucw.cz>
Date: Fri, 1 Jun 2001 19:02:03 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove unnecessary zero initializations from aironet4500_proc.c (245ac1)
In-Reply-To: <20010528223103.J846@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010528223103.J846@jaquet.dk>; from Rasmus Andersen on Mon, May 28, 2001 at 10:31:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi.
> 
> The following patch removes two superfluous initializations
> from aironet4500_proc.c, making the .o ~12K smaller in
> size. It applies against 245ac1 and was discovered by Adam
> Ritcher some time ago.
>  
> --- linux-245-ac1-clean/drivers/net/aironet4500_proc.c	Sat May 19 20:58:24 2001
> +++ linux-245-ac1/drivers/net/aironet4500_proc.c	Mon May 28 22:13:26 2001
> @@ -59,7 +59,7 @@
>  	char 				proc_name[10];
>  };	        
>  static char awc_drive_info[AWC_STR_SIZE]="Zcom \n\0";
						    ~~
When you are at cleaning, kill that ugly \0, too.
	
> -static char awc_proc_buff[AWC_STR_SIZE]="\0";
> +static char awc_proc_buff[AWC_STR_SIZE];



>  static int  awc_int_buff;
>  static struct awc_proc_private awc_proc_priv[MAX_AWCS]; 
>  
> @@ -403,7 +403,7 @@
>          {0}
>  };
>  
> -struct ctl_table_header * awc_driver_sysctl_header = NULL;
> +struct ctl_table_header * awc_driver_sysctl_header;
>  
>  const char awc_procname[]= "awc5";
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
