Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263304AbVGOLRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbVGOLRg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 07:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVGOLOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 07:14:38 -0400
Received: from znsun1.ifh.de ([141.34.1.16]:46281 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S263273AbVGOLN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 07:13:26 -0400
Date: Fri, 15 Jul 2005 13:11:50 +0200 (CEST)
From: Patrick Boettcher <patrick.boettcher@desy.de>
X-X-Sender: pboettch@pub2.ifh.de
To: Johannes Stezenbach <js@linuxtv.org>
Cc: Andrew Benton <b3nt@ukonline.co.uk>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Michael Krufky <mkrufky@m1k.net>,
       video4linux-list@redhat.com
Subject: Re: cx22702.c, 2.6.13-rc3 and a pci Hauppauge Nova-T DVB-T TV card
In-Reply-To: <20050715110938.GB9976@linuxtv.org>
Message-ID: <Pine.LNX.4.61.0507151308450.15841@pub2.ifh.de>
References: <42D77E37.5010908@ukonline.co.uk> <20050715110938.GB9976@linuxtv.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: ALL_TRUSTED,AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005, Johannes Stezenbach wrote:

> Andrew Benton wrote:
>> My pci TV card (a Hauppauge Nova-T DVB-T) works fine with a 2.6.13-rc2
>> kernel but won't work with a 2.6.13-rc3 by a process of elimination I've
>> found that if I reverse this part of the 2.6.13-rc3 patch the card works
>> fine. Please do not include this in the 2.6.13 kernel.
>
> Reversing this patch is not the right fix as it would break
> support for the cxusb.c driver. I guess the output_mode needs to
> be set for the Hauppauge Nova-T DVB-T (cx88-dvb.c).
> cx88-dvb.c is in video4linux CVS, not DVB CVS.
>
> Patrick, can you send a patch for this?

Hmm, yes. When I changed the cx22702-driver to make it work with the
cxusb-driver, I added another field to the struct cx22702_config to
determine the output type.

I was well aware that this breaks support for the PCI cards, that's why I
created a patch for the cx88-dvb.c and posted it the v4l-mailing list and
ask for inclusion.

This was the Mail:
http://www.linuxtv.org/pipermail/linux-dvb/2005-June/002383.html

This is the patch:
Index: cx88-dvb.c
===================================================================
RCS file: /cvs/video4linux/video4linux/cx88-dvb.c,v
retrieving revision 1.42
diff -u -3 -p -r1.42 cx88-dvb.c
--- cx88-dvb.c	12 Jul 2005 15:44:55 -0000	1.42
+++ cx88-dvb.c	15 Jul 2005 11:06:22 -0000
@@ -166,12 +166,14 @@ static int mt352_pll_set(struct dvb_fron

  static struct mt352_config dvico_fusionhdtv = {
  	.demod_address = 0x0F,
+	.output_mode   = CX22702_SERIAL_OUTPUT,
  	.demod_init    = dvico_fusionhdtv_demod_init,
  	.pll_set       = mt352_pll_set,
  };

  static struct mt352_config dntv_live_dvbt_config = {
  	.demod_address = 0x0f,
+	.output_mode   = CX22702_SERIAL_OUTPUT,
  	.demod_init    = dntv_live_dvbt_demod_init,
  	.pll_set       = mt352_pll_set,
  };

Please include. Thanks

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>

best regards,
Patrick.

--
   Mail: patrick.boettcher@desy.de
   WWW:  http://www.wi-bw.tfh-wildau.de/~pboettch/
