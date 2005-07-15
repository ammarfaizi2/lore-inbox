Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263262AbVGOM5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbVGOM5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 08:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbVGOM5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 08:57:12 -0400
Received: from smarthost2.mail.uk.easynet.net ([212.135.6.12]:11021 "EHLO
	smarthost2.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S263262AbVGOM5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 08:57:11 -0400
Message-ID: <42D7B2A0.2040301@ukonline.co.uk>
Date: Fri, 15 Jul 2005 13:57:04 +0100
From: Andrew Benton <b3nt@ukonline.co.uk>
User-Agent: Mail/News Client 1.0+ (X11/20050624)
MIME-Version: 1.0
To: Patrick Boettcher <patrick.boettcher@desy.de>
CC: Johannes Stezenbach <js@linuxtv.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Michael Krufky <mkrufky@m1k.net>,
       video4linux-list@redhat.com
Subject: Re: cx22702.c, 2.6.13-rc3 and a pci Hauppauge Nova-T DVB-T TV card
References: <42D77E37.5010908@ukonline.co.uk> <20050715110938.GB9976@linuxtv.org> <Pine.LNX.4.61.0507151308450.15841@pub2.ifh.de>
In-Reply-To: <Pine.LNX.4.61.0507151308450.15841@pub2.ifh.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Boettcher wrote:
> On Fri, 15 Jul 2005, Johannes Stezenbach wrote:
> 
>> Andrew Benton wrote:
>>> My pci TV card (a Hauppauge Nova-T DVB-T) works fine with a 2.6.13-rc2
>>> kernel but won't work with a 2.6.13-rc3 by a process of elimination I've
>>> found that if I reverse this part of the 2.6.13-rc3 patch the card works
>>> fine. Please do not include this in the 2.6.13 kernel.
>>
>> Reversing this patch is not the right fix as it would break
>> support for the cxusb.c driver. I guess the output_mode needs to
>> be set for the Hauppauge Nova-T DVB-T (cx88-dvb.c).
>> cx88-dvb.c is in video4linux CVS, not DVB CVS.
>>
>> Patrick, can you send a patch for this?
> 
> Hmm, yes. When I changed the cx22702-driver to make it work with the
> cxusb-driver, I added another field to the struct cx22702_config to
> determine the output type.
> 
> I was well aware that this breaks support for the PCI cards, that's why I
> created a patch for the cx88-dvb.c and posted it the v4l-mailing list and
> ask for inclusion.
> 
> This was the Mail:
> http://www.linuxtv.org/pipermail/linux-dvb/2005-June/002383.html
> 
> This is the patch:
> Index: cx88-dvb.c
> ===================================================================
> RCS file: /cvs/video4linux/video4linux/cx88-dvb.c,v
> retrieving revision 1.42
> diff -u -3 -p -r1.42 cx88-dvb.c
> --- cx88-dvb.c    12 Jul 2005 15:44:55 -0000    1.42
> +++ cx88-dvb.c    15 Jul 2005 11:06:22 -0000
> @@ -166,12 +166,14 @@ static int mt352_pll_set(struct dvb_fron
> 
>  static struct mt352_config dvico_fusionhdtv = {
>      .demod_address = 0x0F,
> +    .output_mode   = CX22702_SERIAL_OUTPUT,
>      .demod_init    = dvico_fusionhdtv_demod_init,
>      .pll_set       = mt352_pll_set,
>  };
> 
>  static struct mt352_config dntv_live_dvbt_config = {
>      .demod_address = 0x0f,
> +    .output_mode   = CX22702_SERIAL_OUTPUT,
>      .demod_init    = dntv_live_dvbt_demod_init,
>      .pll_set       = mt352_pll_set,
>  };
> 
> Please include. Thanks
> 
> Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
> 
> best regards,
> Patrick.
> 
> -- 
>   Mail: patrick.boettcher@desy.de
>   WWW:  http://www.wi-bw.tfh-wildau.de/~pboettch/
> 
> 

Hi, I tried the patch but unfortunately the kernel didn't compile, it ended like this

  CC      drivers/media/video/cx88/cx88-blackbird.o
  CC      drivers/media/video/cx88/cx88-dvb.o
drivers/media/video/cx88/cx88-dvb.c:169: error: unknown field `output_mode' specified in initializer
drivers/media/video/cx88/cx88-dvb.c:176: error: unknown field `output_mode' specified in initializer
make[4]: *** [drivers/media/video/cx88/cx88-dvb.o] Error 1
make[3]: *** [drivers/media/video/cx88] Error 2
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2
andy:~$
