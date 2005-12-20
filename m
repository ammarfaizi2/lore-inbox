Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVLTQjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVLTQjm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 11:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVLTQjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 11:39:42 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:9612 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751125AbVLTQjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 11:39:42 -0500
Message-ID: <43A833DC.3080204@tmr.com>
Date: Tue, 20 Dec 2005 11:39:56 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sander@humilis.net
CC: Willy Tarreau <willy@w.ods.org>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, greg@kroah.com, axboe@suse.de,
       vandrove@vc.cvut.cz, aia21@cam.ac.uk, akpm@osdl.org
Subject: Re: [RFC] Let non-root users eject their ipods?
References: <1135047119.8407.24.camel@leatherman> <20051220051821.GM15993@alpha.home.local> <2cd57c900512192206g7292cb1m@mail.gmail.com> <20051220085653.GA3137@favonius> <2cd57c900512200131l4ff29837o@mail.gmail.com> <20051220093802.GA15866@favonius>
In-Reply-To: <20051220093802.GA15866@favonius>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote:
> Coywolf Qi Hunt wrote (ao):
> 
>>2005/12/20, Sander <sander@humilis.net>:
>>
>>>Coywolf Qi Hunt wrote (ao):
>>>
>>>>2005/12/20, Willy Tarreau <willy@w.ods.org>:
>>>>
>>>>>On Mon, Dec 19, 2005 at 06:51:58PM -0800, john stultz wrote:
>>>>>
>>>>>>      I'm getting a little tired of my roommates not knowing how to safely
>>>>>>eject their usb-flash disks from my system and I'd personally like it if
>>>>>>I could avoid bringing up a root shell to eject my ipod. Sure, one could
>>>>>>suid the eject command, but that seems just as bad as changing the
>>>>>>permissions in the kernel (eject wouldn't be able to check if the user
>>>>>>has read/write permissions on the device, allowing them to eject
>>>>>>anything).
>>>>>
>>>>>You may find my question stupid, but what is wrong with umount ? That's
>>>>>how I proceed with usb-flash and I've never sent any eject command to
>>>>>it (I even didn't know that the ioctl would be accepted by an sd device).
>>>>
>>>>IMHO, umount doesn't guarantee sync, isn't it?
>>
>>Actually I was think umount(2), since this is the kernel list, but off
>>topic here.
>>
>>
>>>I'm pretty sure it does :-)
>>
>>That is because: usually your removable media is not the file system
>>root, hence umount(8) can return successfully only if no processes are
>>busy working on it.
>>
>>If you boot from or chroot/pivot into a removable media, and you
>>remount it ro, and unplug it, then you may lose data.
> 
>  
> eject wont help you here, right?
> 
> And the OP was talking about usb-flash sticks his roommates use and his
> ipod. He doesn't need to eject those. umount will do.
> 
Using umount still leaves the iPod flashing a "do not disconnect" 
message as I recall, while eject clears it. So while umount may be all 
the o/s needs, and all some external storage media need, it may be 
highly desirable to do the eject for the benefit of the attached device, 
to cue it to finish whatever it's caching internally. Whatever eject 
does clearly is device visible, and in the case of iPod the device 
objects if it isn't given.

I would think that allowing it on any device on which the caller has 
write permission would cover the security aspects. In this case I would 
prefer not taking the "my XXX doesn't need it" approach, and do it 
unless there's a reason not to.

Not allowing a CD/DVD burner to "prevent media removal" on a device for 
which the user has write permission is another case of questionable 
security. Since that prevents unpatched growisofs from being used by a 
user it has a real negative effect and no obvious (to me) security 
benefit. I don't think of a case where I want to pull a media as it's 
burning...

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
