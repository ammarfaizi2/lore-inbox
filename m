Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265406AbSJRTOe>; Fri, 18 Oct 2002 15:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265407AbSJRTOd>; Fri, 18 Oct 2002 15:14:33 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265406AbSJRTOY>; Fri, 18 Oct 2002 15:14:24 -0400
Date: Fri, 18 Oct 2002 15:20:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
cc: Alexander Viro <viro@math.psu.edu>, Tigran Aivazian <aivazian@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Forced umount
In-Reply-To: <3DB055D7.7080908@gmx.net>
Message-ID: <Pine.LNX.3.95.1021018151840.150A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, Carl-Daniel Hailfinger wrote:
[SNIPPED,,,]
> 
> To put it another way: Is there any chance to umount / cleanly if / is local
> and /smbserver is a mounted remote SMB filesystem where the network link to
> the SMB server just went down? (Without waiting half an hour for a timeout.)
> 
> Thanks for your answer
> 
> Carl-Daniel
> 


You don't need to unmount a network drive (or any drive)
from a mount-point on a file-system before you umount that
file-system!

In other words, if I have quark:/tmp mounted on /tmp, I can
umount / without unmounting quark:/tmp. 

If the network file-system is r/o or otherwise immune to
incomplete operations, you can shut down your client system
with impunity.


For example:

Script started on Fri Oct 18 15:01:59 2002
# mount quark:/tmp /tmp
# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   6434704   9325264  41% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1768580    370244  83% /home/users
/dev/sda1              1048272    282768    765504  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
quark:/tmp              813598    430482    341082  56% /tmp
# umount /dos/drive_C
# umount /dos/drive_D
# umount /home/users
# umount /alt
# umount /
# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   6434704   9325264  41% /
quark:/tmp              813598    430482    341082  56% /tmp
# > /xxx
bash: /xxx: Read-only file system
# > /tmp/xxx
# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   6434704   9325264  41% /
quark:/tmp              813598    430482    341082  56% /tmp
# exit
exit

Script done on Fri Oct 18 15:05:39 2002

As you can see, '/' is now read-only, but /tmp is read-write.
It is save to hit the reset button or otherwise halt the CPU
at this time.

If your shutdown scripts or code 'think' you need to unmount
all the mount-points before you unmount '/', they are broken
and need to be fixed.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

