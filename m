Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbSLUFwG>; Sat, 21 Dec 2002 00:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbSLUFwG>; Sat, 21 Dec 2002 00:52:06 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:5506 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S262040AbSLUFwE> convert rfc822-to-8bit; Sat, 21 Dec 2002 00:52:04 -0500
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'David Lang'" <dlang@diginsite.com>
Cc: "'Torben Frey'" <kernel@mailsammler.de>, <linux-kernel@vger.kernel.org>
Subject: RE: Horrible drive performance under concurrent i/o jobs (dlh problem?)
Date: Sat, 21 Dec 2002 00:00:16 -0600
Message-ID: <000d01c2a8b6$3d102e20$941e1c43@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <Pine.LNX.4.44.0212201343170.10189-100000@dlang.diginsite.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Raid 0 is better in terms of speed.

> IIRC raid0 is striping with no redundancy,
> good for speed, very bad for reliability.

I left that out figuring that since he's a system administrator that he'd
already know that.

>>> There's one partition on it, /dev/sda1

>> Oh no! This is bad news, both in terms of speed
>> and security.
>>
>> Lumping everything into one partition makes it
>> impossible to protect against the SUID/GUID
>> security vulnerability (security), and requires 
>> all reads and writes to be funneled through one
>> partition (speed).

> Here I have to disagree with you.
> for default system installs... [trimmed]

Oh yeah, I agree that default installs are woefully insufficient and
inadequate when it comes to security.  Red Hat should really get its act
together.  OpenBSD, for example, has only had two security holes in the
default installation over the past three years.

However, if he doesn't use separate partitions in the first place, he's
going to have to go back and repartition from scratch just to plug that
security hole.

On the other hand, if he does use separate partitions from the beginning,
all he as to do is change some mount options in the /etc/fstab file.

> As for speed, as long as you are on the same
> spindles there is no definante speed gain for
> having lots of partitions and there is a
> definante cost to having lots of partitions.
> If you think about it, if you have separate
> partitions you KNOW that you will have to seek
> across a large portion of the disk to get
> from /root to /var where they may not be
> seperated that much if they are one filesystem.

Ok, now here's where you're just plain wrong.

SHORT ANSWER: Segregating partitions reduces seek time.  Period.

LONG ANSWER: Reads and writes tend to be grouped within a partition.  For
example, if you're starting a program, you're going to be doing a lot of
reads somewhere in the /usr partition.  If the program uses temporary files,
you're going to do a lot of reads & writes in the /tmp partition.  If you're
saving a file, you're going to be doing lots of writes to the /home
partition.  Hence, since most disk accesses occur in groups within a
partition, preference should be giving to reducing seek time WITHIN a
partition, rather than reducing seek time BETWEEN partitions.

>> At an absolute MINIMUM, your partitions should be divided into:
>> /boot	032 MB
>> /tmp	512 MB
>> swap	1.5 - 3.0 times the amount of RAM,
>> 	not to exceed a 2 GB per swap partition limit
>> /root	  5 GB
>> /var	 10 GB
>> /usr	20% of what is leftover
>> /home	50% of what is leftover,
>> 	or at least 32 MB per user
>> /	30% of what is leftover

> The other problem with lots of partitions is
> that you almost always get into a situation
> where one partition fills up and you have to go
> to a significant amount of work to repartition
> things.

That's why my recommended numbers are as large as they are, and that's why
the /usr, /home, and / partitions are percentages of space leftover instead
of fixed sizes.  I see no situation where my recommended numbers are too low
for his system.

>> Switch to a Uniprocessor kernel, or see my next point.

> Definantly.

Finally.  We agree on something.  8-)

> [trimmed]...you run the possibility of filling [RAM]
> up and having the machine lockup.

Oh come on! Linux is the most stable, reliable, wonderful operating system
in existence.  It's the be-all, end-all of operating systems.  How can it
"lockup"?!?

Hahahahhahahahhahahhahah!

But seriously, you are correct in saying that Linux is piss poor in
utilizing memory beyond 1 GB, but hopefully someday either 1) the Linux
goons will get their act together and write some better code, or 2) he'll
switch to Windows 2000/XP Pro which CAN efficiently and effectively utilize
memory beyond 1 GB.

>> Further, SCSI really works better with two or more
>> processors.  SCSI is designed to take advantage of
>> multiple processors.  If you're not running multiple
>> processors, you might as well be running IDE, IMHO.

> Here I will disagree slightly. I see very significant
> advantages running SCSI even on single CPU machines.
> it all depends on your workload.

But isn't that the point?  His workload is so high that he needs the second
CPU to manage other processes while this program is generating vast amounts
of data?

Joseph Wagner

