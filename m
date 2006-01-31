Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWAaCEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWAaCEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 21:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWAaCEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 21:04:44 -0500
Received: from smtpout.mac.com ([17.250.248.73]:27604 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030263AbWAaCEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 21:04:43 -0500
In-Reply-To: <43DE98B9.6010008@tmr.com>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <Pine.LNX.4.61.0601262139290.27891@yvahk01.tjqt.qr> <20060127080026.GR4311@suse.de> <43DE98B9.6010008@tmr.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <74B203F5-441F-4953-A95D-FEA162700876@mac.com>
Cc: Jens Axboe <axboe@suse.de>, Albert Cahalan <acahalan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rmatthias.andree@gmx.de
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 30 Jan 2006 21:04:37 -0500
To: Bill Davidsen <davidsen@tmr.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 30, 2006, at 17:52, Bill Davidsen wrote:
> What is not easily available in Linux is a nice single place to  
> find out what mass storage (disk/optical/floppy/ZIP/LS120/tape)  
> devices are on the system, and what the system calls them.

Yes it is available, and a whole slew of GUI applications use it.   
It's called "hal", or Hardware Abstraction Layer, and it has small  
hooks into udev and a bit of sysfs code so that it has a list of all  
devices of various types and knows what their associated udev-created  
device nodes are.  This means that I can configure udev to put my CD  
drive on /dev/burner and correctly written GUI programs will just  
find it and work.

> Because for low tech users udev is the problem, not the solution.  
> The user doesn't want to tell the system what to call the device,  
> he wants to see what's there, and that includes serial numbers of  
> drives (where available) because if a user has several drives it's  
> likely that they are identical.

Your average low-tech user installing stock Debian (Not even  
something targeted at user-friendliness like Ubuntu), will end up  
with udev/hal installed.  When he plugs in his burner, it will get  
the name /dev/cdrom[0-9] behind the scenes, and hal will notice.   
When he starts up k3b, it will use hal and automatically notice his  
drive, showing him brand, serial number, etc.

> Instead of having the user tell the system what to call a device,  
> let the system tell the user what it is called.

Uhh, both happen.  The system tells userspace "I just got/have a  
device with brand 'foo', specs 'bar', serial 'baz', etc".  Userspace  
(behind the scenes, without your low-tech user caring) creates a  
device node "/dev/cdrom[0-9]" and alerts hal, which sends it to your  
application, which nicely alerts the user.  As an admin who does a  
lot on the command line, I can tie certain drive serial numbers to / 
dev/blue_burner and /dev/red_burner for my own ease-of-command-line- 
use without breaking the aforementioned hal system.

Cheers,
Kyle Moffett

--
I have yet to see any problem, however complicated, which, when you  
looked at it in the right way, did not become still more complicated.
   -- Poul Anderson



