Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSLTKgi>; Fri, 20 Dec 2002 05:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSLTKgi>; Fri, 20 Dec 2002 05:36:38 -0500
Received: from chambertin.convergence.de ([212.84.236.2]:8965 "EHLO
	chambertin.convergence.de") by vger.kernel.org with ESMTP
	id <S261660AbSLTKgh>; Fri, 20 Dec 2002 05:36:37 -0500
Message-ID: <3E02F36E.3010508@convergence.de>
Date: Fri, 20 Dec 2002 11:39:42 +0100
From: Holger Waechtler <holger@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Gregoire Favre <greg@ulima.unil.ch>
CC: linux-dvb@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb] How to compil dvb CVS with 2.5.52?
References: <20021219222730.GA3324@ulima.unil.ch>
In-Reply-To: <20021219222730.GA3324@ulima.unil.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregoire,

Gregoire Favre wrote:
> 
> It then don't compil and i have to patch with the patch sent to this
> list the Wed, 11 Dec 2002 10:53:43 +1100 from Rusty Russell:
> 
> --- drivers/media/dvb/dvb-core/dvb_i2c.c	2002-12-19 23:21:07.000000000 +0100
> +++ drivers/media/dvb/dvb-core/dvb_i2c.c~	2002-11-28 19:57:09.000000000 +0100
> @@ -64,8 +64,10 @@
>  void try_attach_device (struct dvb_i2c_bus *i2c, struct dvb_i2c_device *dev)
>  {
>  	if (dev->owner) {
> -		if (!try_inc_mod_count(dev->owner))
> +		if (!MOD_CAN_QUERY(dev->owner))
>  			return;
> +
> +		__MOD_INC_USE_COUNT(dev->owner);
>  	}
>  
>  	if (dev->attach (i2c) == 0) {
> 

are you sure? MOD_CAN_QUERY() and __MOD_INC_USE_COUNT() are 2.4 macros, 
they are deprecated now. The compatibility fake is implemented in 
compat.h. Could you please check this again and tell me what exactly the 
problem is?

Holger

