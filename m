Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUDKTQg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 15:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUDKTQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 15:16:36 -0400
Received: from ip213-185-37-13.laajakaista.mtv3.fi ([213.185.37.13]:46772 "EHLO
	home.holviala.com") by vger.kernel.org with ESMTP id S262450AbUDKTQf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 15:16:35 -0400
From: Kim Holviala <kim@holviala.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5 : problem with MS Intellimouse Explorer buttons when using X
Date: Sun, 11 Apr 2004 22:16:33 +0300
User-Agent: KMail/1.6.1
Cc: Vitez Gabor <gabor@swszl.szkp.uni-miskolc.hu>
References: <20040410135327.GA12573@swszl.szkp.uni-miskolc.hu>
In-Reply-To: <20040410135327.GA12573@swszl.szkp.uni-miskolc.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200404112216.33308.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 April 2004 16:53, Vitez Gabor wrote:

> I recently ugraded from 2.4.23 to 2.6.5. Everything works fine, except for
> my mouse: when I press the buttons on the left side of the mouse, the
> system generates button press/release events for the proper buttons and for
> the buttons on the top of the mouse. The mouse worked well with 2.4.23.

2.4 and 2.6 handle mouse differently; 2.4 has /dev/psaux which is just a 
direct channel into the port while 2.6 inteprets all mouse stuff and 
regenerates a virtual /dev/psaux.

Try modprobing the even device (modprobe evdev) to get /dev/input/event?. Then 
run hexdump -C /dev/input/event1 (or whatever even device represents your 
mouse) to see what REALLY happens in the kernel. Don't worry about the first 
8 octets, the stuff you want is in the last 8. Might be a good idea to switch 
to a console so that extra mouse clicks won't do any strange things.

>         Option          "Protocol"              "ExplorerPS/2"
> #       Option          "Protocol"              "ImPS/2"
>         Option          "Buttons"               "7"
>         Option          "ZAxisMapping"          "6 7"

I use an Explorer at work, don't have the Buttons directive at all and my 
ZAxMap is "4 5". That way everything works, but the side buttons are missing. 
That's with 2.6.5 and Gentoo.



Kim

