Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVKTA5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVKTA5w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 19:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVKTA5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 19:57:51 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:12817 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750841AbVKTA5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 19:57:51 -0500
Message-ID: <437FCA07.40600@superbug.co.uk>
Date: Sun, 20 Nov 2005 00:57:43 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Does Linux support powering down SATA drives?
References: <437F63C1.6010507@perkel.com>
In-Reply-To: <437F63C1.6010507@perkel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel wrote:
> Trying to save power consumption. I have a backup drive that is used 
> only once a day to back up the main drive. So - why should I run it more 
> that 10 minutes a day? What I'd like to do is keep it in an off state 
> and then at night power it on, mount it up, do the backup, unmount it, 
> and shut it down. Can I do that?
> 

Support is being added soon, I think the latest 2.6.15-rc1 supports 
passthru. I had to install an extra patch due to a bug where it used the 
same IDE device irrespective of one asking for /dev/sda or /dev/sdb
I think the fix will be in rc2.

hdparm -S60 works fine for me. It spins down, and therefore stay nices a 
cool.
hdparm -y should work, and is like an immeadiate -S
hdparm -Y is kind of dangerous at the moment. It powers down the drive, 
but will not come back unless the entire IDE bus goes through a reset. 
The feature to support that is called hotplug, but that is not 
implemented yet for SATA. So, basically, if you do hdparm -Y, you won't 
be able to wake it up again at the moment. At least hdparm -S60 is a 
start towards what you want.

James
