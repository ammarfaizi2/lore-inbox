Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272277AbRH3PhS>; Thu, 30 Aug 2001 11:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272273AbRH3PhI>; Thu, 30 Aug 2001 11:37:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272272AbRH3PhB>; Thu, 30 Aug 2001 11:37:01 -0400
Date: Thu, 30 Aug 2001 11:37:02 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Venkatesh Ramachandran <rvenky@cisco.com>
cc: linux-users@cisco.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, brussels-linux@cisco.com,
        Mathangi Kuppusamy <mathangi@cisco.com>
Subject: Re: Linux Mounting problem
In-Reply-To: <3B8E5791.5BBE92A2@cisco.com>
Message-ID: <Pine.LNX.3.95.1010830112028.1525A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Venkatesh Ramachandran wrote:

> Hello,
>    I am using Redhat Linux 7.1
>    During reboot, i get the message " Mounting / as readonly"
>    And, it enters into maintenance mode...( & all other steps fail -
> /proc not mounted, swap not mounted, fsck fails)
>    I did the following :
>    mount -t proc proc /proc
>    fsck /dev/hda1
>    The following error messages : ERROR : Couldn't open /dev/null
> (Read-only file system)
> 

First, verify that /dev/null is a character device, major=1, minor=3.
`file /dev/null`.
It may have gotten changed to some real file because of some errors.

In maintenance mode do:

/sbin/mount -n -o remount /dev/hda1 # Mount r/w, no write to /etc/mtab
/bin/rm /dev/null             # Delete it
/bin/mknod /dev/null c 1 3    # Make a new one
/bin/chmod 777 /dev/null      # Accessible by everyone in all modes
/bin/chown root.sys /dev/null # Standard ownership
/sbin/umount /dev/hda1        # Now unmount it
/sbin/mount /proc /proc -t proc # You can mount it if you want
/sbin/e2fsck -f /dev/hda1     # Fix the disk
... After you fix the errors ...
`exec /sbin/init auto`  (or exit if from a startup script)

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


