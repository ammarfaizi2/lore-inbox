Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129727AbRCLTWD>; Mon, 12 Mar 2001 14:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129694AbRCLTVx>; Mon, 12 Mar 2001 14:21:53 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38660 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129618AbRCLTVh>; Mon, 12 Mar 2001 14:21:37 -0500
Subject: Re: [patch]  Does this correct  a bug in ibmcam.c?
To: leejr@linuxsoftwareconsultants.com (Lee Brown)
Date: Mon, 12 Mar 2001 19:24:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01031203541300.02643@darkstar> from "Lee Brown" at Mar 12, 2001 03:52:02 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14cXvi-0002Sv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +			int chan;
>  
> -			if (copy_from_user(&v, arg, sizeof(v)))
> -				return -EFAULT;
> -			if ((v < 0) || (v >= 3)) /* 3 grades of lighting conditions */
> -				return -EINVAL;
> -			if (v != ibmcam->vchan.channel) {
> -				ibmcam->vchan.channel = v;
> +			chan = (int)arg;
> +		
> +			if ((chan < 0) || (chan >= 3)) /* 3 grades of lighting conditions */ 
> +			 	return -EINVAL;			
> +	
> +			if (chan != ibmcam->vchan.channel) { 	
> +				ibmcam->vchan.channel = chan; 			
>  				usb_ibmcam_change_lighting_conditions(ibmcam);
> -			}
> + 			}
>  			return 0;
>  		}

This change is wrong. I think you are calling the ioctl wrongly

