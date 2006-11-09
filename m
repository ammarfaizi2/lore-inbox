Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424171AbWKISA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424171AbWKISA5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 13:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424176AbWKISA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 13:00:57 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:33968 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1424171AbWKISA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 13:00:56 -0500
Message-ID: <45536CCF.4020209@gmail.com>
Date: Thu, 09 Nov 2006 19:00:47 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jano <jasieczek@gmail.com>
CC: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>	 <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>	 <45534B31.50008@cfl.rr.com> <45534D2C.6080509@gmail.com>	 <455360CF.9070600@cfl.rr.com> <d9a083460611090922j75b97cd4u6cc53eeee52b2344@mail.gmail.com>
In-Reply-To: <d9a083460611090922j75b97cd4u6cc53eeee52b2344@mail.gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jano wrote:
> 2006/11/9, Jiri Slaby <jirislaby@gmail.com>:
>> Jano wrote:
>> > I've compiled it into the kernel, but it doesn't work.
>>
>> But I guess, you either haven't mkinitrd'ed it or you don't have an
>> initrd line
>> in your loader config (I can't see any difference in dmesgs diff)?
>>
> 
> It is quite possible. All I've done was:
> 
> # make all
> # make modules_install
> # make install
> 
> And update of /boot/grub/menu.lst. Additionally I've tried to do it using:
> 
> # make-kpkg --initrd kernel_image kernel_headers
> 
> And installing the deb package. Please correct me if I've made any
> mistakes.

Hmm, both should be sufficient, however initrd seems to be not loaded. What does
your grub config says and could you zcat [initrd] | cpio -t (or whatever it is
packed by)?

> 2006/11/9, Phillip Susi <psusi@cfl.rr.com>:
>> I didn't ask for /proc/mounts, I asked for the output of the mount
>> command with no arguments, which prints the contents of /etc/mtab.  I
>> was thinking that /etc/mtab might show the partitions as mounted even
>> though they are not, which could be why mount is complaining.
>>
> 
> Here you are, this is output of 'mount' while in recovery mode using
> kernel 2.6.18.1

If you have your /etc/mtab file on ro mounted partition while in recovery mode,
it's not being updated by mount...

> $ mount
> /dev/hda3 on / type ext3 (rw,errors=remount-ro)
> proc on /proc type proc (rw)
> /sys on /sys type sysfs (rw)
> varrun on /var/run type tmpfs (rw)
> varlock on /var/lock type tmpfs (rw)
> udev on /dev type tmpfs (rw)
> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
> devshm on /dev/shm type tmpfs (rw)
> /dev/hda1 on /boot type ext3 (rw)
> /dev/hda5 on /usr type ext3 (rw)
> 
> As you can see, no trace of /dev/hdb1.

Is the real reason EBUSY (as it should be) -- could you strace your mount command?

I'm clueless now, sorry.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
