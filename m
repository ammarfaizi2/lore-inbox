Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWHAVZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWHAVZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWHAVZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:25:38 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:50143 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751018AbWHAVZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:25:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=uZYDyBdK4j1vvyyfCblrDhvI7Ev1LqeU5ejf22DkrscnUkl9JBq+rgJ1UCIidGInbxg4flGR8NlQZ6UzN12ln3cWtYWwy6x3qo2zaFS6mHae9wCbbGdLT0Te9+cX/uxXpIgu2DWbKYqTh75Z3Nisvz+8JFMLpVvSAgSC0BId+tc=
Message-ID: <44CFC6CC.8020106@gmail.com>
Date: Tue, 01 Aug 2006 15:25:32 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Robert Schwebel <r.schwebel@pengutronix.de>
CC: Chris Boot <bootc@bootc.net>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Proposal: common kernel-wide GPIO interface
References: <44CA7738.4050102@bootc.net> <20060730130811.GI10495@pengutronix.de>
In-Reply-To: <20060730130811.GI10495@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:
> Chris,
>
> On Fri, Jul 28, 2006 at 09:44:40PM +0100, Chris Boot wrote:
>   
>> I propose to develop a common way of registering and accessing GPIO pins on 
>> various devices.
>>     
>
> I've attached the gpio framework we have developed a while ago; it is
> not ready for upstream, only tested on pxa and has probably several
> other drawbacks, but may be a start for your activities. One of the
> problems we've recently seen is that for example on PowerPCs you don't
> have such a clear "this is gpio pin x" nomenclature, so the question
> would be how to do the mapping here.
>
> Robert 
>   
this is cool to see.  Using a class-driver is very different from the 
vtable-approach
that I used (struct nsc_gpio_ops) in pc8736x_gpio and scx200_gpio.

Are any of the limitation youve cited above related to the 
/sys/class/gpio paths below ?

+	  To set pin 63 to low (to start the motor) do a:
+	   $ echo 0 > /sys/class/gpio/gpio63/level
+	  Or to stop the motor again:
+	   $ echo 1 > /sys/class/gpio/gpio63/level
+	  To get the level of the key (pin 8) do:
+	   $ cat /sys/class/gpio/gpio8/level
+	  The result will be 1 or 0.
+
+	  To add new GPIO pins at runtime (lets say pin 88 should be an input)
+	  you can do a:
+	   $ echo 88:in > /sys/class/gpio/map_gpio
+	  The same with a new GPIO pin 95, it should be an output and at high level:
+	   $ echo 95:out:hi > /sys/class/gpio/map_gpio
+




