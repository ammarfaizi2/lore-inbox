Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVI0ACc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVI0ACc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 20:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVI0ACc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 20:02:32 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:23449 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750814AbVI0ACb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 20:02:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:From:Organization:To:Subject:Date:User-Agent:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=c54zfWWJSaD4wUxNAfITjMW7rMYJv56veX2qg2Y1KgUqKi6en/tP6TMEuBSYjDJrOu+4Aa/nd+g6+sr8ZVyH16I1hDPx/MMZ05+UUJBQSIIY9ZI1aanMZXab1taOGCkSJyiX4Gf3NZfslUuJGYP2IL5FRLzk6F4NT7NzWfg+1W8=  ;
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Crazy Idea: Replacing /dev using sysfs over time
Date: Mon, 26 Sep 2005 20:02:11 -0400
User-Agent: KMail/1.8.2
References: <200509261928.20701.shawn.starr@rogers.com>
In-Reply-To: <200509261928.20701.shawn.starr@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509262002.11834.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Or instead of even needing major/minor we just have:


/sys/class/sound
       `- - audio0
                |
                | - raw
        `-- dsp0
                |
                | - raw

Then instead, let udev know that audio0 and dsp0 belong to one sound card 
device or have it report this in sysfs:

/dev/class/sound
       `--sound0     
               | 
               | -- dev
               | -- device -> ../../../devices/pci0000:00
               `-- audio0
                     |- device  -> ../../../devices/pci0000:00/0000:00:1f.5
               `--dsp0
                     | -device -> ../../../devices/pci0000:00/0000:00:1f.5
               `--mixer0 
        `--sound1
               |
               | -dev   
               | -- device -> ../../../devices/pci0000:00:1a
               `--audio0
                       |- device 
--> ../../../devices/pci0000:00:1a/0000:00:1c.6

And so forth.


Then map sound0 devices in /dev/dsp0 /dev/mixer0 /dev/audio0  with udev

*NOTE: I am not avocating devfs, but more of keeping sysfs as the primary 
structure for devices.

On September 26, 2005 19:28, Shawn Starr wrote: > I wonder if in the future, 
we can just eliminate /dev altogether (or map it
> via sysfs until older apps move away from /dev). It just seems we could
> represent major,minor in a sysfs node:
>
>         /sys/class/block/
>         `-- sda
>
>             |-- sda1
>             |
>                     | - major
>                     | - minor
>                     | - raw
>             |
>             |-- sda2
>             |
>                     | - major
>                     | - minor
>                     | - raw
>
>             `-- sda3
>
> and so forth, or under a different branch elsewhere.
>
> Does it make sense? Logical? Illogical? Do we really need /dev other than
> for historical/legacy purposes?
>
> Shawn.
