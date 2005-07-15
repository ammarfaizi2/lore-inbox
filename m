Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263269AbVGONDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbVGONDP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 09:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbVGONDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 09:03:15 -0400
Received: from znsun1.ifh.de ([141.34.1.16]:32991 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S263269AbVGONDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 09:03:14 -0400
Date: Fri, 15 Jul 2005 15:01:53 +0200 (CEST)
From: Patrick Boettcher <patrick.boettcher@desy.de>
X-X-Sender: pboettch@pub2.ifh.de
To: Andrew Benton <b3nt@ukonline.co.uk>
Cc: Johannes Stezenbach <js@linuxtv.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Michael Krufky <mkrufky@m1k.net>,
       video4linux-list@redhat.com
Subject: Re: cx22702.c, 2.6.13-rc3 and a pci Hauppauge Nova-T DVB-T TV card
In-Reply-To: <42D7B2A0.2040301@ukonline.co.uk>
Message-ID: <Pine.LNX.4.61.0507151459180.15841@pub2.ifh.de>
References: <42D77E37.5010908@ukonline.co.uk> <20050715110938.GB9976@linuxtv.org>
 <Pine.LNX.4.61.0507151308450.15841@pub2.ifh.de> <42D7B2A0.2040301@ukonline.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: ALL_TRUSTED,AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005, Andrew Benton wrote:
> Hi, I tried the patch but unfortunately the kernel didn't compile, it ended 
> like this
>
> CC      drivers/media/video/cx88/cx88-blackbird.o
> CC      drivers/media/video/cx88/cx88-dvb.o
> drivers/media/video/cx88/cx88-dvb.c:169: error: unknown field `output_mode' 
> specified in initializer
> drivers/media/video/cx88/cx88-dvb.c:176: error: unknown field `output_mode' 
> specified in initializer

Yes, I was in a hurry *slap* and made a mistake.

This one is correct (revert the other one):

Index: cx88-dvb.c
===================================================================
RCS file: /cvs/video4linux/video4linux/cx88-dvb.c,v
retrieving revision 1.42
diff -u -3 -p -r1.42 cx88-dvb.c
--- cx88-dvb.c	12 Jul 2005 15:44:55 -0000	1.42
+++ cx88-dvb.c	15 Jul 2005 11:33:48 -0000
@@ -180,12 +180,14 @@ static struct mt352_config dntv_live_dvb
  #if CONFIG_DVB_CX22702
  static struct cx22702_config connexant_refboard_config = {
  	.demod_address = 0x43,
+	.output_mode   = CX22702_SERIAL_OUTPUT,
  	.pll_address   = 0x60,
  	.pll_desc      = &dvb_pll_thomson_dtt7579,
  };

  static struct cx22702_config hauppauge_novat_config = {
  	.demod_address = 0x43,
+	.output_mode   = CX22702_SERIAL_OUTPUT,
  	.pll_address   = 0x61,
  	.pll_desc      = &dvb_pll_thomson_dtt759x,
  };


Sorry,
Patrick.
