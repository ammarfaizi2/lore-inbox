Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbULTDIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbULTDIO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 22:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbULTDIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 22:08:13 -0500
Received: from h002078c680df.ne.client2.attbi.com ([24.34.94.87]:53209 "EHLO
	joshuawise.com") by vger.kernel.org with ESMTP id S261399AbULTDIF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 22:08:05 -0500
Message-ID: <41C6420F.10109@joshuawise.com>
Date: Sun, 19 Dec 2004 22:07:59 -0500
From: Joshua Wise <joshua@joshuawise.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernhard Ager <ager@in.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Joystick not found on Linux/amd64
References: <Pine.LNX.4.58.0412200235440.6947@tuvok.enterprise>
In-Reply-To: <Pine.LNX.4.58.0412200235440.6947@tuvok.enterprise>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Ager wrote:
> Hello,
> 
> I just tried out version 8.03 of X-Plane for Linux. Works really smoothly 
> for me, except that the joystick is not found :-( The joystick 
> itself should be working, as e.g. jstest tells me: 
> 
> Joystick (Analog 4-axis 4-button joystick) has 4 axes and 4 buttons. Driver version is 2.1.0.
> 
> The issue might be, that I am using Linux on the amd64 architecture and 
> letting run X-Plane in the 32bit "emulation", though I can't really see 
> why.
I've had a report of this problem in the past. I have a vague 
understanding of why it happens, but I'm not sure how to fix it.

As far as I can tell, the problem is that my code uses the joystick 
ioctls to get the version, passing it a 32-bit address to return the 
version into. This doesn't work out so hot in the 64-bit kernel, which 
decides that my 32-bit address is full of crap, and gives me an errno of 
-EFAULT, which means that I passed it a bad address. My code handles 
this by not detecting the joystick at all, thinking that the version is 
too old, since the kernel didn't change it.

So, basically, I think I know why it happens, but I'm not certain 
whether its my code at fault or the kernel's. This is a good question. 
I'm going to cc: this to LKML, in the hope that somebody there can 
provide some insight.

I am not subscribed to LKML - anyone on there who is responding, please 
cc: me in your responses.

joshua
