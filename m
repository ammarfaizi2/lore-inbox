Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVCBXfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVCBXfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVCBXe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:34:59 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:60594 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S261375AbVCBXcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:32:53 -0500
Message-ID: <42264D23.6010206@f2s.com>
Date: Wed, 02 Mar 2005 23:32:51 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Initialisation sequencing.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have a problem. It affects both modular and non modular builds, and I 
dont see an obviously correct solution.

The problem is that I have a video chip which supports some GPIOs and an 
LCD display.

some LCD functions are controlled via the GPIOs, like backlighting.

so the driver is split into a video driver which exports three GPIO 
related functions, and a backlight driver which requires them to work. 
Both are on the platform bus.

the problem occurs when the backlight driver gets probed before the 
video driver. it tries to access the GPIO functions, which try to write 
to random locations as the memory hasnt been ioremap()ed by the as yet 
unprobed video driver, and it all predictably falls over in a gibbering 
heap.

I cant spin at this point without deadlocking the video driver and 
ending up never being able to call the gpio functions, for obvious reasons.

I've tried making the backlight driver a child of the video driver, 
hoping the probe functions are called in 'bus order', ie. parents first. 
This failed.

I could make the backlight driver initialise late, but that seems like a 
hack. scheduling work risks deadlock.

what is the correct solution? does one exist?
