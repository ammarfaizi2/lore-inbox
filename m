Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031350AbWLEU6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031350AbWLEU6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031360AbWLEU6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:58:42 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:56312 "EHLO mail.mnsu.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031350AbWLEU6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:58:41 -0500
Message-ID: <4575DD73.9010008@mnsu.edu>
Date: Tue, 05 Dec 2006 14:58:27 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Marty Leisner <linux@rochester.rr.com>, linux-kernel@vger.kernel.org,
       bug-cpio@gnu.org, martin.leisner@xerox.com
Subject: Re: ownership/permissions of cpio initrd
References: <200612052024.kB5KOY1o023781@laptop13.inf.utfsm.cl> <4575D7F4.3060707@mnsu.edu> <Pine.LNX.4.61.0612052139180.18570@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612052139180.18570@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> It appears to not be standard with fedora for sure... but while it origiginally
>> was/is a Debian package it looks like there is source if you'd like to build it
>> on other systems.  It was originally designed to tackle the exact problem you
>> are confronting.
>>
>> See:
>> http://freshmeat.net/projects/fakeroot/
>>
>> About:
>> Fakeroot runs a command in an environment were it appears to have root
>> privileges for file manipulation, by setting LD_PRELOAD to a library with
>> alternative versions of getuid(), stat(), etc. This is useful for allowing
>> users to create archives (tar, ar, .deb .rpm etc.) with files in them with root
>> permissions/ownership. Without fakeroot one would have to have root privileges
>> to create the constituent files of the archives with the correct permissions
>> and ownership, and then pack them up, or one would have to construct the
>> archives directly, without using the archiver.
>>     
>
> Ugh that sounds even more than a hack. At least for one-user 
> archives, I guess nobody at Debian knows that tar has a --user and 
> --group option.
>
>
> 	-`J'
>   

...It also let's you mknod and friends, and let's you set permissions to 
files to more than just ONE user.  The whole point of the commands is to 
let you make distribution files without root access.  Of course you can 
fake all of this with a special archiver command.... I'm just throwing 
out options.

$ fakeroot
# mkdir root
# mkdir root/dev/
# mknod root/dev/null c 1 3
# mknod root/dev/sda1 b 8 1
# chown root.disk root/dev/sda1
# cd root
# tar cvf ../root.tar ./
# exit
$ tar tvf root.tar
drwxr-xr-x root/root         0 2006-12-05 14:54 ./
drwxr-xr-x root/root         0 2006-12-05 14:54 ./dev/
crw-r--r-- root/root       1,3 2006-12-05 14:54 ./dev/null
brw-r--r-- root/disk       8,1 2006-12-05 14:54 ./dev/sda1

-- 
Jeffrey Hundstad


