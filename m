Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315853AbSENQih>; Tue, 14 May 2002 12:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315865AbSENQig>; Tue, 14 May 2002 12:38:36 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:40965 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315853AbSENQif>;
	Tue, 14 May 2002 12:38:35 -0400
Date: Tue, 14 May 2002 08:37:35 -0700
From: Greg KH <greg@kroah.com>
To: Christer Nilsson <christer.nilsson@kretskompaniet.se>, lepied@xfree86.org
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.19-pre8  Fix for Intuos tablet in wacom.c
Message-ID: <20020514153735.GB18532@kroah.com>
In-Reply-To: <IBEJLIFNGHPKEKCKODPDEECADPAA.christer.nilsson@kretskompaniet.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 16 Apr 2002 14:31:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 10:31:45AM +0200, Christer Nilsson wrote:
> 
> The changes between 2.4.19-pre7 and 2.4.18-pre8 broke the Intuos part in
> wacom.c
> This will fix it.
> 
> --- linux/drivers/usb/wacom.c.org	Tue May 14 00:40:12 2002
> +++ linux/drivers/usb/wacom.c	Tue May 14 00:41:31 2002
> @@ -288,8 +288,8 @@
>  	x = ((__u32)data[2] << 8) | data[3];
>  	y = ((__u32)data[4] << 8) | data[5];
> 
> -	input_report_abs(dev, ABS_X, wacom->x);
> -	input_report_abs(dev, ABS_Y, wacom->y);
> +	input_report_abs(dev, ABS_X, wacom->x = x);
> +	input_report_abs(dev, ABS_Y, wacom->y = y);
>  	input_report_abs(dev, ABS_DISTANCE, data[9] >> 4);
> 
>  	if ((data[1] & 0xb8) == 0xa0) {						/* general pen packet */
> 

Can you ask lepied@xfree86.org if this will break anything else, as that
change was in his patch that is found at:
	http://people.mandrakesoft.com/~flepied/projects/wacom/

thanks,

greg k-h
