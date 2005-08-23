Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbVHWUhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVHWUhL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVHWUhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:37:11 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:27003 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932385AbVHWUhJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:37:09 -0400
Date: Tue, 23 Aug 2005 22:38:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: manomugdha biswas <manomugdhab@yahoo.co.in>
Cc: bunnans@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: kernel module seg fault
Message-ID: <20050823203815.GA17575@mars.ravnborg.org>
References: <006e01c5a7dd$c8395a20$2f08a8c0@varuna> <20050823163421.66485.qmail@web8503.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050823163421.66485.qmail@web8503.mail.in.yahoo.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You do hide a lot of info.
Without the Makefile we cannot see if you compile this in a decent way.
We cannot see the implmentation of EnterFunction() etc.

A quick grep in the kernel tree revealed very few users
of DECLARE_WIATQUEUE_HEAD, and interruptible_sllep_on_timeout() are
deprecated.
So maybe bringing the driver up to modern state would help.

PS. Ever read CodingStyle?

	Sam

On Tue, Aug 23, 2005 at 05:34:21PM +0100, manomugdha biswas wrote:
> Hi,
> This is the code where i am getting this problem. 
> 
> static byte4
> VNICClientStart(unsigned long arg)
> {
>   VNICClientCfgCreateInfo_t  clientConfig;
>   struct socket        *sock      = NULL;
>   ubyte4               status     = 0;
>   ubyte4               retryCnt   =
> VNIC_CLIENT_MAX_CONN_RETRY_CNT;
>   ubyte4               ret        = 0;
>   byte4                len        = 0;
>   struct net_device    *dev       = NULL;
>   VNICConnMap_t        *connMap    = NULL;
>   byte4                error      = 0;
>   VNICHdrForm_t      vnicHdr;
>   VNICVirtMirrIfaceAndServIPList_t  *ifaceIPNode =
> NULL;
>                                                       
>                          
>   DECLARE_WAIT_QUEUE_HEAD(wq);
>   init_waitqueue_head(&wq);
>                                                       
>                          
>   EnterFunction("VNICClientStart");
> 
> 
>    memset(&vnicHdr, 0, sizeof(vnicHdr));
>   while (retryCnt) {
>         --retryCnt;
>                                                       
>                        
>    if (!retryCnt) {
>      return VNIC_CLIENT_SERVER_RESPONSE_TIMEOUT;
>    }
>                                                       
>                          
>    /* wait for small */
>    interruptible_sleep_on_timeout(&wq, 2);
>   } /* end while (retryCnt)*/
> 
>   LeaveFunction("VNICClientStart");
>   return VNIC_CLIENT_SERVER_SUCCESS; /* for success */
> } /* end VNICClientStart() */
> 
> I commneted out all the other functionalities of this
> function to make it simple but still it is getting
> kernel panic.
>    
> This function gets called when i invoke ioctl() from
> my user application and gets kernel panic.
> 
> Regards,
> Manomugdha
> 
> 
> 
> --- bunnans@yahoo.com wrote:
> 
> > Hi Biswas,
> > 
> > You need to post the complete kernel dump message
> > and body of your
> > source code.
> > 
> > -Bunnan
> >  
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org] On
> > Behalf Of manomugdha
> > biswas
> > Sent: Tuesday, August 23, 2005 3:13 PM
> > To: linux-kernel@vger.kernel.org
> > Subject: kernel module seg fault
> > 
> > Hi,
> > I have written a kernel module and I can load
> > (insmod)
> > it without any error. But when i run my module it
> > gets
> > seg fault at interruptible_sleep_on_timeout();
> > 
> > I have used this function in the following way:
> > 
> > DECLARE_WAIT_QUEUE_HEAD(wq);
> > init_waitqueue_head(&wq);
> > interruptible_sleep_on_timeout(&wq, 2);
> > 
> > I am using redhat version 9.0 and kernel version
> > 2.4.20-8.
> > Could you please give some light on this issue?
> > 
> > Manomugdha Biswas
> > 
> > 
> > 	
> > 
> > 	
> > 		
> > ____________________________________________________
> > Send a rakhi to your brother, buy gifts and win
> > attractive prizes. Log
> > on to http://in.promos.yahoo.com/rakhi/index.html
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel"
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> Manomugdha Biswas
> 
> 
> 	
> 
> 	
> 		
> ____________________________________________________
> Send a rakhi to your brother, buy gifts and win attractive prizes. Log on to http://in.promos.yahoo.com/rakhi/index.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
