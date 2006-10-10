Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932760AbWJJLTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbWJJLTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 07:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932979AbWJJLTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 07:19:13 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:40436 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932760AbWJJLTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 07:19:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=KfAANSBIDZzdFviEHMC3nxlEomucJ/xuexo476zm5L9+kUMZxhDJGUGkNYjCXpo0eRIIqVz4SBWti681hxg39sK/GiZYUG0ryzme6ldfZ9SYOEMjnIJvEiANFBnmOI4PRDTOS+KZZMcFy3lIvHJTl0nJxPkP8RjTBC9yccR61r8=
Message-ID: <452B81A2.6060905@gmail.com>
Date: Tue, 10 Oct 2006 15:18:58 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Amit Choudhary <amit2030@gmail.com>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, stable@kernel.org
Subject: Re: [stable] [PATCH 2.6.19-rc1] drivers/media/dvb/bt8xx/dvb-bt8xx.c:
 check kmalloc() return value.
References: <20061008231034.e50118df.amit2030@gmail.com> <452A09A1.8040808@gmail.com> <20061010080110.GA20169@kroah.com>
In-Reply-To: <20061010080110.GA20169@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------030207040505050309010604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030207040505050309010604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Mon, Oct 09, 2006 at 12:34:41PM +0400, Manu Abraham wrote:
>> Amit Choudhary wrote:
>>> Description: Check the return value of kmalloc() in function frontend_init(), in file drivers/media/dvb/bt8xx/dvb-bt8xx.c.
>>>
>>> Signed-off-by: Amit Choudhary <amit2030@gmail.com>
>>>
>>> diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
>>> index fb6c4cc..14e69a7 100644
>>> --- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
>>> +++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
>>> @@ -665,6 +665,10 @@ static void frontend_init(struct dvb_bt8
>>>  	case BTTV_BOARD_TWINHAN_DST:
>>>  		/*	DST is not a frontend driver !!!		*/
>>>  		state = (struct dst_state *) kmalloc(sizeof (struct dst_state), GFP_KERNEL);
>>> +		if (!state) {
>>> +			printk("dvb_bt8xx: No memory\n");
>>> +			break;
>>> +		}
>>>  		/*	Setup the Card					*/
>>>  		state->config = &dst_config;
>>>  		state->i2c = card->i2c_adapter;
>>> -
>>
>> Signed-off-by: Manu Abraham <manu@linuxtv.org>
> 
> Care to send the full patch in a format that we can apply it to the
> -stable tree?
> 


 dvb-bt8xx.c |    4 ++++
 1 files changed, 4 insertions(+)


Thanks,

Manu

--------------030207040505050309010604
Content-Type: text/x-patch;
 name="dvb_check_mem_allocation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dvb_check_mem_allocation.patch"

diff -Naurp linux-2.6.18.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.c linux-2.6.18/drivers/media/dvb/bt8xx/dvb-bt8xx.c
--- linux-2.6.18.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2006-09-20 07:42:06.000000000 +0400
+++ linux-2.6.18/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2006-10-10 15:02:28.000000000 +0400
@@ -666,6 +666,10 @@ static void frontend_init(struct dvb_bt8
 	case BTTV_BOARD_TWINHAN_DST:
 		/*	DST is not a frontend driver !!!		*/
 		state = (struct dst_state *) kmalloc(sizeof (struct dst_state), GFP_KERNEL);
+		if (!state) {
+			printk("%s: Out of Memory !\n", __func__);
+			break;
+		}
 		/*	Setup the Card					*/
 		state->config = &dst_config;
 		state->i2c = card->i2c_adapter;

--------------030207040505050309010604--
