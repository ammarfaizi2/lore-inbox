Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271794AbRIJICg>; Mon, 10 Sep 2001 04:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273073AbRIJIC3>; Mon, 10 Sep 2001 04:02:29 -0400
Received: from xsmtp.ethz.ch ([129.132.97.6]:21638 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S271794AbRIJICO> convert rfc822-to-8bit;
	Mon, 10 Sep 2001 04:02:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
content-class: urn:content-classes:message
Subject: Re: OOPS[devfs]: reproducible in vfs_follow_link 2.4.9,2.4.10-pre4
Date: Mon, 10 Sep 2001 09:59:27 +0200
Message-ID: <3B9C72DF.1080200@dplanet.ch>
Thread-Topic: OOPS[devfs]: reproducible in vfs_follow_link 2.4.9,2.4.10-pre4
Thread-Index: AcE5zu6fMGAIaaVwEdWZHACQJ4nSeQ==
From: "Giacomo Catenazzi" <cate@dplanet.ch>
To: "Richard Gooch" <rgooch@ras.ucalgary.ca>
Cc: "Alexander Viro" <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Sep 2001 08:02:34.0547 (UTC) FILETIME=[F2F80030:01C139CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:

> Giacomo A. Catenazzi writes:
>>Richard Gooch wrote:
>>>Alexander Viro writes:
>>>>On Thu, 6 Sep 2001, Giacomo Catenazzi wrote:
>>>>>
>>>>>Since yesterdey, every time I run a 2.4.9 or 2.4.10pre-4 without
the
>>>>>"devfs=nomount" I
>>>>>have two oops + /usr, /home /boot not mounted (all (also /): ext2).
>>>>>
>>>>      Don't use devfs. One of the known bugs - devfs passes a string
>>>>to vfs_follow_link() and doesn't care to preserve it until
>>>>vfs_follow_link() is done.
>>>>
> [I said it was fixed for UP in recent devfs patches]
> 
>>>If people could test the latest devfs patch, that would be really
>>>helpful. Linus isn't applying it because he's concerned that the many
>>>SD support may break something. Even if you don't have many SD's,
>>>please apply the patch and send a message to the list (and Cc: me)
>>>stating whether or not your system still works.
>>>
>>No, your patch  didn't work.
>>I have still the oops.
>>
> 
> Hm! Is this a UP or SMP kernel?


UP

>>I investigates, and the oops come in the mountall script (in init.d),
>>when running: mount -avt nonfs,nosmbfs.
>>(I noticed thet at this point kernel load floppy modules, but when I
>>removed also the floppy module, the oops reappers.)
>>
> 
> Hm. I've had one other bug report which initially seemed to be
> devfs-related, but it was also related to the floppy driver as
> well. IIRC, elsewhere Alan noted there seemed to be some problems with
> the floppy driver. I suspect the bug you (and the other person) are
> having is related to the floppy driver and not devfs.
> 
> Please try renaming/removing your floppy driver and see if the problem
> persists. I bet it goes away. As Al mused, it was odd that the problem
> only appears now. While there are known races in devfs, no-one has
> ever encountered these in real life (targetted exploits are not "real
> life"). So I too am surprised that suddenly there appears a problem
> with devfs.


The causes seem be the bad interaction of devfs, floppy, mount and
devfsd.

After further investigations:
- Oops happens in 2.4.9, 10pre4 and 10pre5.
- devfs=nomount solve the bug
- the oops happens in mount (I should investigate also why mount load
the
    floppy module at boot time)
- removing floppy modules or comment the line in fstab solve the bug.
   (manually loading the floppy module works without oops)

The strange things:
the bugs appear only after few day of rebooting 2.4.9 and yet
is disappeard.
The possible change in environtment is the update (and then downgrade)
of devfsd (last version, only with with/without an extra patch, in
debian).
But updating and downgading seem not to cause oops at the next boot.
(I should still better invetigate about this. Maybe the bug is
due to dev-state, thus the bug appear only after the 2 reboot?
)


In any case, I will invetigate more this night. Do you have some
suggestions about tests to do?

> 
> In the meantime, my tree is getting closer to the stage where I will
> attempt a compile. Soon I will be able to dispel this dark cloud of
> "devfs races" that Al keeps muttering about :-)


Ok, I'm waiting also for these changes!


		giacomo


