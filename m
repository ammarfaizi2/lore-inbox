Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVK2XBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVK2XBq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbVK2XBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:01:46 -0500
Received: from kirby.webscope.com ([204.141.84.57]:20919 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S964796AbVK2XBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:01:45 -0500
Message-ID: <438CDDBC.1070704@m1k.net>
Date: Tue, 29 Nov 2005 18:01:16 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirk Lapray <kirk.lapray@gmail.com>
CC: Gene Heskett <gene.heskett@verizon.net>, video4linux-list@redhat.com,
       CityK <CityK@rogers.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Perry Gilfillan <perrye@linuxmail.org>, Don Koch <aardvark@krl.com>
Subject: Re: Gene's pcHDTV 3000 analog problem
References: <200511282205.jASM5YUI018061@p-chan.krl.com>	 <200511291335.18431.gene.heskett@verizon.net>	 <438CA1E3.7010101@m1k.net>	 <200511291546.27365.gene.heskett@verizon.net> <438CC83E.50100@m1k.net> <c35b44d70511291435i5f07bc88g429276ef659c28c5@mail.gmail.com>
In-Reply-To: <c35b44d70511291435i5f07bc88g429276ef659c28c5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirk Lapray wrote:

> I only run the cards in digital mode.  I have no need to tune to any 
> analog channels with them.  When I was working on nxt200x I was able 
> to tune both analog and digital channels on the HDTV Wonder, but I 
> have never tried to tune to any analog channels using the HD3000.  
> This was using kernel 2.6.13 and the cvs v4l and dvb trees.
>
> I am not sure when I will have some time to test 2.6.15-rc3, but if I 
> get some time I will try analog support on this and my current setup.
>
> Kirk
>
Kirk-

Please test your cards in analog mode, or I fear that we may have to 
cause NXT200X to depend on BROKEN.

Here's why....

A few months ago, as we added the nxt200x module to cvs, I told you that 
with nxt200x loaded into memory, I had some extra devices showing up on 
my i2c bus.  At the time, I was using another cx88 card, and it did not 
use the nxt200x module itself, although it loads up into memory 
automatically by the cx88-dvb module.

You told me that there was some code in nxt200x module that somehow 
opens up a channel to hidden i2c devices.  Why would this code affect my 
system if my device is not using the nxt200x module?

Is there code being run at nxt200x module load that is causing this 
BEFORE cx88-dvb calls nxt200x_attach() ?

It seems that Gene, Perry and Don are having problems with their analog 
tuners (they each have pcHDTV 3000) ever since nxt200x got added.

Gene, Perry and Don - What happens if you have the cx88 module loaded, 
but you do NOT load up cx88-dvb (nxt200x will not be loaded) ... Does 
the problem persist?

You do not need cx88-dvb to view analog television.

Kirk, we need a control group!  Please test analog on both boards.

Kirk, there is a thread on the v4l/dvb mailing lists right now about an 
i2c gate dealing with Hauppauge cards and cx22702 frontend.  What Steve 
Toth has described about this 'i2c gate' is starting to sound similar to 
what you mentioned about making hidden i2c devices visible.

I'm getting the feeling that nxt200x is indeed the problem.

Gene, Perry and Don .... Another thing you can try -- Once again, 
install v4l-dvb cvs on top of your running kernel, but this time, before 
compiling, edit v4l-dvb/v4l/Makefile , and remove the line:

 EXTRA_CFLAGS += -DHAVE_NXT200X=1

... This line appears twice, you only need to remove the top one, as it 
pertains to the cx88 card, although it is safe to remove both for the 
purposes of this test.

If this fixes your problem, then we know that nxt200x is the cause.

-Mike

