Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWFQJgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWFQJgw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 05:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWFQJgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 05:36:52 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:9391 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751205AbWFQJgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 05:36:51 -0400
Date: Sat, 17 Jun 2006 11:36:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Herbert Poetzl <herbert@13thfloor.at>
cc: Grzegorz Kulewski <kangur@polcom.net>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk
Subject: Re: [RFC][PATCH 00/20] Mount writer count and read-only bind mounts
 (v2)
In-Reply-To: <20060617033531.GA25823@MAIL.13thfloor.at>
Message-ID: <Pine.LNX.4.61.0606171135560.15799@yvahk01.tjqt.qr>
References: <20060616231213.D4C5D6AF@localhost.localdomain>
 <Pine.LNX.4.63.0606170125110.14464@alpha.polcom.net>
 <1150501318.7926.22.camel@localhost.localdomain>
 <Pine.LNX.4.63.0606170202020.14464@alpha.polcom.net> <20060617033531.GA25823@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >I assume you're talking about this kind of situation:
>> >
>> >mount --bind /local/writable/dir /chroot/untrusted/area/
>> >mount --o remount,ro /chroot/untrusted/area/
>> 
>> Well, actually about some kind of VPS: openvz or something like that.
>> But yes, this is the same kind of scenario.
>
>yes, Linux-VServer provides this kind of ro --bind mounts
>without the race, as the the flags are passed on the actual
>mount
>
>> >This has no r/w window in the chroot area:
>> >
>> >mount --bind /local/writable/dir /tmp/area/
>> >mount --o remount,ro /tmp/area/
>> >mount --bind /tmp/area/ /chroot/untrusted/area/
>> >umount /tmp/area/
>> 
>> Well, it looks a little scarry and complicated at first. And probably
>> requires you to know that semantic of --bind lets you do the last
>> unmount. But if you are saying that this makes kernel smaller, faster
>> and less buggy then you are probably very right.
>
>well, it makes the kernel more consistant in it's behaviour,
>because especially for --rbind mounts, the logic what is
>changed where and when is not as well defined as one would
>wish ...
>
>btw, you could get the same result by simply doing:
>
>mount --bind /local/writable/dir /tmp/area/
>mount --o remount,ro /tmp/area/
>mount --move /tmp/area/ /chroot/untrusted/area/
>

Just a nitpick, you all use "--o" ... :)
mount: option `--o' is ambiguous




Jan Engelhardt
-- 
