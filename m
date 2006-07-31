Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWGaQK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWGaQK7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWGaQK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:10:58 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:34765 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1751250AbWGaQK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:10:58 -0400
Message-ID: <44CE2B90.5030905@bootc.net>
Date: Mon, 31 Jul 2006 17:10:56 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Ben Dooks <ben@fluff.org>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Proposal: common kernel-wide GPIO interface
References: <44CA7738.4050102@bootc.net> <20060730130811.GI10495@pengutronix.de> <20060730220200.GB8907@home.fluff.org>
In-Reply-To: <20060730220200.GB8907@home.fluff.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks wrote:
> On Sun, Jul 30, 2006 at 03:08:11PM +0200, Robert Schwebel wrote:
>> Chris,
>>
>> On Fri, Jul 28, 2006 at 09:44:40PM +0100, Chris Boot wrote:
>>> I propose to develop a common way of registering and accessing GPIO pins on 
>>> various devices.
>> I've attached the gpio framework we have developed a while ago; it is
>> not ready for upstream, only tested on pxa and has probably several
>> other drawbacks, but may be a start for your activities. One of the
>> problems we've recently seen is that for example on PowerPCs you don't
>> have such a clear "this is gpio pin x" nomenclature, so the question
>> would be how to do the mapping here.
> 
> Right, my $0.02 worth:

[snip]

Some very interesting comments and suggestions! Thanks very much for all the
info, that's exactly the sort of stuff I needed.

> 3) The sysfs interface should be configurable, as systems
>    with lots of GPIO would end up with large numbers of
>    files and directories in sysfs.

My current idea is to divide the interfaces by GPIO device and port. I've so far
not seen a GPIO device that couldn't be divided into ports of <= 32 bits. How
wide can a 'port' actually become?

Somehow I think that a separate device/file for each pin or possibly even port 
might not be a wise idea. For example, twiddling individual pins on a GPIO when 
you connect an LCD, I2C, or SPI interface seems extremely inefficient...

> 4) you probably want to ensure pull-up resistors are off if the
>    output is being driven. 

Yes, very good idea! So far I haven't managed to fry any chips by driving a 
pulled up/down output, but it's so easy to make the mistake...

Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/


