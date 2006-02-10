Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWBJVFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWBJVFF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWBJVFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:05:05 -0500
Received: from mail.tmr.com ([64.65.253.246]:54925 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932195AbWBJVFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:05:04 -0500
Message-ID: <43ED005F.5060804@tmr.com>
Date: Fri, 10 Feb 2006 16:06:39 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nix <nix@esperi.org.uk>
CC: Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>	<Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>	<20060125144543.GY4212@suse.de>	<Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>	<20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>	<20060125181847.b8ca4ceb.grundig@teleline.es>	<20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix>
In-Reply-To: <878xt3rfjc.fsf@amaterasu.srvr.nix>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

red brick + atlantaNix wrote:
> On 25 Jan 2006, Matthias Andree prattled cheerily:
> 
>>Jens Axboe wrote:


>>Hm. sysfs, procfs, udev, hotplug, netlink (for IPv6) - this all looks rather
>>complicated and non-portable. I understand that applications that can just
>>open every device and send SCSI INQUIRY might want to do that on Linux, too.
> 
> 
> Applications (already) do this by asking HAL, which can be informed of
> new devices in a variety of ways: the up-and-coming one is for the
> kernel to notify udevd, following which a udev rule sends a dbus message
> to HAL. Everything from the dbus message on up is cross-OS portable.
> -scanbus is *totally* unnecessary.

I notice that the first thing people suggest is to make things like 
udev, hal and sysfs required instead of optional to do something as 
simple as burn a CD. As I mentioned before, if the kernel provided a 
list of devices then applications wouldn't break every time a new kernel 
came out which needs a new this, and new that, and a few new other 
support things.

The kernel could provide a list of devices by category. It doesn't have 
to name them, run scripts, give descriptions, or paint them blue. Just a 
list of all block devices, tapes, by major/minor and category (ie. 
block, optical, floppy) would give the application layer a chance to do 
it's own interpretation. HAL is great, but because it's not part of the 
kernel it's also going to suffer from "tracking error" for some changes. 
I find it easier to teach someone to use -scanbus than to explain how to 
make rules for udev.
> 
> (Furthermore, it fails to work in a quite laughable fashion in the
> presence of hotpluggable storage media. udev handles giving hotpluggable
> storage media consistent device names with extreme ease, and tells HAL
> about them so that users see the new devices appear even if they don't
> have a clue that /dev even exists.
> 
> The change that J. Random Nontechnical User will ever run `cdrecord
> -scanbus' is *nil*, and applications don't run it either because they
> can't judge between all the devices that are listed to pick the one
> which is a CD recorder (consider the consequences should they guess
> wrong!). Instead, they invariably ask for a device name, or, in more
> recent versions get the info from HAL. HAL knows if something is a CD
> recorder because its backend, e.g. udev, told it.)
> 
Worth repeating: I find it easier to teach someone to use -scanbus than 
to explain how to make rules for udev. HAL is the right answer, but *in* 
the kernel, where it will track changes. Since -scanbus tells you a 
device is a CDrecorder, or something else, *any user* is likely to be 
able to tell it from DCD, CD-ROM, etc. Nice like of text for most devices...

Note: my example of major/minor is just that, almost any presentation 
which showed all devices user applications would normally use, in a well 
defined way, would address the identifications issue.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
