Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310783AbSCHJvj>; Fri, 8 Mar 2002 04:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310781AbSCHJva>; Fri, 8 Mar 2002 04:51:30 -0500
Received: from bpdcwm01.bpcl.broadband.hu ([195.184.181.2]:9469 "HELO
	mx01.broadband.hu") by vger.kernel.org with SMTP id <S310780AbSCHJvU>;
	Fri, 8 Mar 2002 04:51:20 -0500
Message-ID: <3C88890C.6010303@mail.externet.hu>
Date: Fri, 08 Mar 2002 10:49:00 +0100
From: Boszormenyi Zoltan <zboszor@mail.externet.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011014
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ext2/Ext3 partition label abuse
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a RedHat 7.2 machine installed from scratch.
Recently I installed RedHat 7.2 on another machine
that has two harddisks (/dev/hda and /dev/hdc)
The second is in a removable bay.
Linux was installed on /dev/hdc.

My main machine also has a hdd bay (/dev/hdc) and I have
put the new machine's removable hdd into the main one
and booted up. (I had to copy some files and no network
between the machines.)

On boot I had strange errors that said that this and that
partitions cannot be found. I observed the following.

The / partition contains the main machine's data from /dev/hda2
although the mount command lists / as mounted from /dev/hdcX.
Every other partitions are mounted from /dev/hdc.

The problem is that /etc/fstab as used by RedHat, lists the partition
by LABEL=/mountpoint which labels can be found on both
/dev/hda and /dev/hdc.

The /proc/partitions "file" lists the partitions in disk-reversed order,
e.g.:

/dev/hdc1  ....
...
/dev/hdc10 ...
/dev/hda1 ...
...
/dev/hda9 ...

Is there a way to fix this? Yes there is: vendors should not use
LABEL=XXX method in /etc/fstab. Either use the proper
device/partition or the UUID. The downside is that fsck messages
would not be as pretty-printed as now. Or maybe the partitions
should not be registered in disk-reversed order...

Best regards,
Zoltán Böszörményi


