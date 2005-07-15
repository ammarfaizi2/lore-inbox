Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262770AbVGOOsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbVGOOsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 10:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbVGOOsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 10:48:50 -0400
Received: from smarthost4.mail.uk.easynet.net ([212.135.6.14]:40709 "EHLO
	smarthost4.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S262770AbVGOOrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 10:47:47 -0400
Message-ID: <42D7CC89.2040203@ukonline.co.uk>
Date: Fri, 15 Jul 2005 15:47:37 +0100
From: Andrew Benton <b3nt@ukonline.co.uk>
User-Agent: Mail/News Client 1.0+ (X11/20050624)
MIME-Version: 1.0
To: Patrick Boettcher <patrick.boettcher@desy.de>
CC: Johannes Stezenbach <js@linuxtv.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Michael Krufky <mkrufky@m1k.net>,
       video4linux-list@redhat.com
Subject: Re: cx22702.c, 2.6.13-rc3 and a pci Hauppauge Nova-T DVB-T TV card
References: <42D77E37.5010908@ukonline.co.uk> <20050715110938.GB9976@linuxtv.org> <Pine.LNX.4.61.0507151308450.15841@pub2.ifh.de> <42D7B2A0.2040301@ukonline.co.uk> <Pine.LNX.4.61.0507151459180.15841@pub2.ifh.de>
In-Reply-To: <Pine.LNX.4.61.0507151459180.15841@pub2.ifh.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Boettcher wrote:
> On Fri, 15 Jul 2005, Andrew Benton wrote:
>> Hi, I tried the patch but unfortunately the kernel didn't compile, it 
>> ended like this
>>
>> CC      drivers/media/video/cx88/cx88-blackbird.o
>> CC      drivers/media/video/cx88/cx88-dvb.o
>> drivers/media/video/cx88/cx88-dvb.c:169: error: unknown field 
>> `output_mode' specified in initializer
>> drivers/media/video/cx88/cx88-dvb.c:176: error: unknown field 
>> `output_mode' specified in initializer
> 
> Yes, I was in a hurry *slap* and made a mistake.
> 
> This one is correct (revert the other one):
> 
> Index: cx88-dvb.c
> ===================================================================
> RCS file: /cvs/video4linux/video4linux/cx88-dvb.c,v
> retrieving revision 1.42
> diff -u -3 -p -r1.42 cx88-dvb.c
> --- cx88-dvb.c    12 Jul 2005 15:44:55 -0000    1.42
> +++ cx88-dvb.c    15 Jul 2005 11:33:48 -0000
> @@ -180,12 +180,14 @@ static struct mt352_config dntv_live_dvb
>  #if CONFIG_DVB_CX22702
>  static struct cx22702_config connexant_refboard_config = {
>      .demod_address = 0x43,
> +    .output_mode   = CX22702_SERIAL_OUTPUT,
>      .pll_address   = 0x60,
>      .pll_desc      = &dvb_pll_thomson_dtt7579,
>  };
> 
>  static struct cx22702_config hauppauge_novat_config = {
>      .demod_address = 0x43,
> +    .output_mode   = CX22702_SERIAL_OUTPUT,
>      .pll_address   = 0x61,
>      .pll_desc      = &dvb_pll_thomson_dtt759x,
>  };
> 
> 
> Sorry,
> Patrick.
> 
> 

Thankyou, that patch works very well.
