Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278133AbRJWRqn>; Tue, 23 Oct 2001 13:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278139AbRJWRqe>; Tue, 23 Oct 2001 13:46:34 -0400
Received: from intranet.resilience.com ([209.245.157.33]:44504 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S278133AbRJWRqQ>; Tue, 23 Oct 2001 13:46:16 -0400
Message-ID: <3BD5ABF3.1040404@usa.net>
Date: Tue, 23 Oct 2001 10:42:11 -0700
From: Eric <ebrower@usa.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010802
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Q] pivot_root and initrd
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would it even be worthwhile to propose a patch that would set a flag 
when pivot_root is called during an initrd and prevent change_root from 
occuring once the linuxrc thread exits?

Your method of placing "initrx=xxx" and "root=xxx" is similar to my 
method of stuffing those values into /proc/sys/kernel/real_root_dev once 
the pivot_root is complete; I am not really happy with that solution, 
not the least of which because it is an undocumented work-around and 
somewhat unexpected behavior for a system call that is to (presumably) 
replace or augment change_root.

I was also hoping that Warner or Hans would chime-in either in defense 
of the current documentation or with clarifications...

E

HPA wrote:
>> 
>> I am mystified that the call to 'exec /sbin/init' works 
>> if you are using the standard (you mention "based on RedHat7.1"
>> util-linux") /sbin/init proggie, and that a standard RH7.1 
>> initscripts would not complain when the root filesystem is already 
>> mounted r/w.
>> 
>> I would also guess that you are susceptible to the kernel's 
>> change_root call if your /sbin/init terminates. I'll have to 
>> play with the disk a bit.
>> 
> 
> I modify the initscripts to not try to fsck and remount the root -- 
> its a ramfs (tmpfs in a later version) after all. If I had been 
> mounting a filesystem off the harddisk I would either have mounted it 
> readonly and left the init scripts as-is, or fscked it before 
> mounting. 
> 
> I pass the following command line options to the kernel (this is set 
> up in isolinux.cfg): 
> 
>         append initrd=initrd.gz root=/dev/ram0 init=/linuxrc single 
> 
> By specifying root=/dev/ram0 and an explicit init (which I'm calling 
> /linuxrc but could just as easily have called /sbin/init) I'm telling 
> the kernel that this is the final root, and effectively turn off most 
> of the initrd legacy weirdness. 
> 
> If /sbin/init exits, the kernel panics, just like it would normally do 
> if init goes away. 


