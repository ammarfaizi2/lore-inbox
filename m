Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272483AbRH3VVq>; Thu, 30 Aug 2001 17:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272482AbRH3VV2>; Thu, 30 Aug 2001 17:21:28 -0400
Received: from ns.roland.net ([65.112.177.35]:31755 "EHLO earth.roland.net")
	by vger.kernel.org with ESMTP id <S271138AbRH3VVH>;
	Thu, 30 Aug 2001 17:21:07 -0400
Message-ID: <3B8EAEC0.4090905@roland.net>
Date: Thu, 30 Aug 2001 16:23:12 -0500
From: Jim Roland <jroland@roland.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Venkatesh Ramachandran <rvenky@cisco.com>, linux-users@cisco.com,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        brussels-linux@cisco.com, Mathangi Kuppusamy <mathangi@cisco.com>
Subject: Re: Linux Mounting problem
In-Reply-To: <Pine.LNX.3.95.1010830112028.1525A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

He is getting these errors because his /etc/rc.d/rc.sysinit is shuttling 
all output from the commands in the script to be written to /dev/null 
and his FS is mounted as read-only.  It never gets mounted as read-write 
because of fsck failing to approve the check with an OK status.  If 1-2 
boots in rescue mode (or as "linux single") don't fix the errors, the 
last step (e2fsck) should be run and should fix the error, unless there 
is serious drive corruption.

Regards,
Jim Roland, RHCE


Richard B. Johnson wrote:

>On Thu, 30 Aug 2001, Venkatesh Ramachandran wrote:
>
>>Hello,
>>   I am using Redhat Linux 7.1
>>   During reboot, i get the message " Mounting / as readonly"
>>   And, it enters into maintenance mode...( & all other steps fail -
>>/proc not mounted, swap not mounted, fsck fails)
>>   I did the following :
>>   mount -t proc proc /proc
>>   fsck /dev/hda1
>>   The following error messages : ERROR : Couldn't open /dev/null
>>(Read-only file system)
>>
>
>First, verify that /dev/null is a character device, major=1, minor=3.
>`file /dev/null`.
>It may have gotten changed to some real file because of some errors.
>
>In maintenance mode do:
>
>/sbin/mount -n -o remount /dev/hda1 # Mount r/w, no write to /etc/mtab
>/bin/rm /dev/null             # Delete it
>/bin/mknod /dev/null c 1 3    # Make a new one
>/bin/chmod 777 /dev/null      # Accessible by everyone in all modes
>/bin/chown root.sys /dev/null # Standard ownership
>/sbin/umount /dev/hda1        # Now unmount it
>/sbin/mount /proc /proc -t proc # You can mount it if you want
>/sbin/e2fsck -f /dev/hda1     # Fix the disk
>... After you fix the errors ...
>`exec /sbin/init auto`  (or exit if from a startup script)
>
>Cheers,
>Dick Johnson
>
>Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
>
>    I was going to compile a list of innovations that could be
>    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>    was handled in the BIOS, I found that there aren't any.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


