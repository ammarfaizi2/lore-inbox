Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268802AbUHLVNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268802AbUHLVNX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUHLVKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:10:37 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:35459 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S268788AbUHLVIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:08:51 -0400
Message-ID: <411BDD11.8070400@tmr.com>
Date: Thu, 12 Aug 2004 17:11:45 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Wright <timw@splhi.com>
CC: Martin Mares <mj@ucw.cz>, Joerg Schilling <schilling@fokus.fraunhofer.de>,
       James.Bottomley@steeleye.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <20040807001427.GA10890@ucw.cz><200408070001.i7701PSa006663@burner.fokus.fraunhofer.de> <1091899593.20043.14.camel@kryten.internal.splhi.com>
In-Reply-To: <1091899593.20043.14.camel@kryten.internal.splhi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Wright wrote:
> On Fri, 2004-08-06 at 17:14, Martin Mares wrote:
> 
>>Hello!
>>
>>
>>>I see always the same answers from Linux people who don't know anyrthing than
>>>their belly button :-(
>>>
>>>Chek Solaris to see that your statements are wrong.
>>
>>Well, so could you please enlighten the Linux people and say in a couple
>>of words how it could be done?
>>
>>				Have a nice fortnight
> 
> 
> I can offer reasons as to why it cannot :-)
> 
> The path_to_inst stuff assumes a simple physical bus topology. It is
> completely unsuited to e.g. a fibre-channel fabric. It is also unsuited
> to iSCSI - my disks aren't attached to eth0, they're attached to
> whichever interface has a route to the server. It's also worthless for
> USB. The controller, bus and target are meaningless - the target number
> is dynamically assigned at plugin so giving a name to controller 0, bus
> 0 target 3 is utterly pointless.
> 
> Linux and/or associated drivers has mechanisms to handle consistent
> naming for a number of these (WWPN-binding for FC, similar device
> binding of the unique ids for iSCSI, the hotplug infrastructure for usb
> etc.). All of these map devices to consistent device names in /dev. The
> "Unix" way of accessing devices has always been via names in /dev. I
> completely fail to understand why Joerg wants to try to force a naming
> model that is both alien to the native systems (I want /dev/cdrw on
> Linux; I probably want D: on Windows or something like that), and is
> inadequate to the task if you move beyond the simple world of parallel
> SCSI.

But they *don't* map to consistent device names. All hot pluggable 
devices seem to map to the next available name. Looking at one of my 
utility systems, it has IDE drives mapped by Redhat with ide-scsi, real 
SCSI drives, a couple of flash card slots mapped to SCSI, and a USB 
device, all in the /dev/sdX namespace. And in the order in which they 
were detected (connected, in other words).

Joerg hasn't made it any better, but it isn't great anyway. I recommend 
a script to do discovery and make symlinks somewhere to names which 
always match the same device.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
