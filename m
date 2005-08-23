Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVHWQe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVHWQe0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 12:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVHWQe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 12:34:26 -0400
Received: from web8503.mail.in.yahoo.com ([202.43.219.165]:16772 "HELO
	web8503.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S932221AbVHWQeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 12:34:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=g59aCSsl2PxGaC4LrDXfjZ4EwNMQqQWxR/a5lWlUY+xoGGKkiGoI5yQJqcYBKKpvnSkZ1yBG5+tmNKLi1U9JEC05OZbo1TrJEWyXxJdTMDYOicg/UjpNnLc/wlHRHelojJ+wgVw9Ft1fpOTCoaRetN0lJxv+fA8kVjgSwiH7w6Y=  ;
Message-ID: <20050823163421.66485.qmail@web8503.mail.in.yahoo.com>
Date: Tue, 23 Aug 2005 17:34:21 +0100 (BST)
From: manomugdha biswas <manomugdhab@yahoo.co.in>
Subject: RE: kernel module seg fault
To: bunnans@yahoo.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <006e01c5a7dd$c8395a20$2f08a8c0@varuna>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This is the code where i am getting this problem. 

static byte4
VNICClientStart(unsigned long arg)
{
  VNICClientCfgCreateInfo_t  clientConfig;
  struct socket        *sock      = NULL;
  ubyte4               status     = 0;
  ubyte4               retryCnt   =
VNIC_CLIENT_MAX_CONN_RETRY_CNT;
  ubyte4               ret        = 0;
  byte4                len        = 0;
  struct net_device    *dev       = NULL;
  VNICConnMap_t        *connMap    = NULL;
  byte4                error      = 0;
  VNICHdrForm_t      vnicHdr;
  VNICVirtMirrIfaceAndServIPList_t  *ifaceIPNode =
NULL;
                                                      
                         
  DECLARE_WAIT_QUEUE_HEAD(wq);
  init_waitqueue_head(&wq);
                                                      
                         
  EnterFunction("VNICClientStart");


   memset(&vnicHdr, 0, sizeof(vnicHdr));
  while (retryCnt) {
        --retryCnt;
                                                      
                       
   if (!retryCnt) {
     return VNIC_CLIENT_SERVER_RESPONSE_TIMEOUT;
   }
                                                      
                         
   /* wait for small */
   interruptible_sleep_on_timeout(&wq, 2);
  } /* end while (retryCnt)*/

  LeaveFunction("VNICClientStart");
  return VNIC_CLIENT_SERVER_SUCCESS; /* for success */
} /* end VNICClientStart() */

I commneted out all the other functionalities of this
function to make it simple but still it is getting
kernel panic.
   
This function gets called when i invoke ioctl() from
my user application and gets kernel panic.

Regards,
Manomugdha



--- bunnans@yahoo.com wrote:

> Hi Biswas,
> 
> You need to post the complete kernel dump message
> and body of your
> source code.
> 
> -Bunnan
>  
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On
> Behalf Of manomugdha
> biswas
> Sent: Tuesday, August 23, 2005 3:13 PM
> To: linux-kernel@vger.kernel.org
> Subject: kernel module seg fault
> 
> Hi,
> I have written a kernel module and I can load
> (insmod)
> it without any error. But when i run my module it
> gets
> seg fault at interruptible_sleep_on_timeout();
> 
> I have used this function in the following way:
> 
> DECLARE_WAIT_QUEUE_HEAD(wq);
> init_waitqueue_head(&wq);
> interruptible_sleep_on_timeout(&wq, 2);
> 
> I am using redhat version 9.0 and kernel version
> 2.4.20-8.
> Could you please give some light on this issue?
> 
> Manomugdha Biswas
> 
> 
> 	
> 
> 	
> 		
> ____________________________________________________
> Send a rakhi to your brother, buy gifts and win
> attractive prizes. Log
> on to http://in.promos.yahoo.com/rakhi/index.html
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Manomugdha Biswas


	

	
		
____________________________________________________
Send a rakhi to your brother, buy gifts and win attractive prizes. Log on to http://in.promos.yahoo.com/rakhi/index.html
