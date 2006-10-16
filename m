Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbWJPHNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWJPHNF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 03:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWJPHNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 03:13:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:51611 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751480AbWJPHND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 03:13:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eSIs1yYWYGyEJLhWlPHvbwrEptNcegLiX6Vfzf+E5R3Pot2dPbZP/+qS0aqwAivO0dJnoft7PEQIoS/jBo2MXToZPhebcAisaD/By1zbcrIgbqlzE4hu5I/5om8AtSJ5gP+YoJTg7F75q+uaSL0c8TTsglzA5mU1s06Z/zqRaSU=
Message-ID: <46465bb30610160013v47524589g39c61465b5955f65@mail.gmail.com>
Date: Mon, 16 Oct 2006 16:13:00 +0900
From: "Mohit Katiyar" <katiyar.mohit@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: NFS inconsistent behaviour
In-Reply-To: <A93BD15112CD05479B1CD204F7F1D4730513DB@exch-04.noida.hcltech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <A93BD15112CD05479B1CD204F7F1D4730513DB@exch-04.noida.hcltech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am currently using 2.6.16.21-0.8-smp kernel and SLES10 distribution.
I have two machines Machine1 and Machine2 both 4 processors SMP
machines.

The /etc/fstab file on both machines is as follows

/dev/sda3 / reiserfs acl,user_xattr 1 1
/dev/sda4 /home reiserfs acl,user_xattr 1 2
/dev/sda2 swap swap defaults 0 0
proc /proc proc defaults 0 0
sysfs /sys sysfs noauto 0 0
debugfs /sys/kernel/debug debugfs noauto 0 0
usbfs /proc/bus/usb usbfs noauto 0 0
devpts /dev/pts devpts mode=0620,gid=5 0 0

## NFS
##
server1k:/export/server1/s25vol1 /mnt/nfs1 nfs hard,intr,tcp
server2k:/export/server2/s25vol2 /mnt/nfs2 nfs hard,intr,tcp
server2k:/export/server2/s25_2sp /mnt/nfs3 nfs hard,intr,tcp

Now on Machine1 when I try to repeatedly mount/unmount the nfs
partition by the following procedure

[Machine1:] while :; do mount -a -F -t nfs ;umount -a -t nfs ; done

The partitions are mounted and unmounted two or three times and after
that the process comes to halt and after some time the following
message keeps on coming

and mounting/unmounting stops.

mount: RPC: Remote system error - Connection timed out

mount: RPC: Remote system error - Connection timed out

mount: RPC: Remote system error - Connection timed out

.

..

.

.

On Machine2 when I try the same mounting/unmounting infinitely then
after 30 seconds or around the following messages starts to display

mount: server2k:/export/server2/s25_2sp: can't read superblock
mount: server1k:/export/server1/s25vol1: can't read superblock
mount: server2k:/export/server2/s25vol2: can't read superblock
mount: server2k:/export/server2/s25_2sp: can't read superblock
mount: server1k:/export/server1/s25vol1: can't read superblock

.

.

.

Also there are several lockd daemon created

> $ ps -ef | grep lockd
> root 21 15 0 13:51 ? 00:00:00 [kblockd/0]
> root 22 15 0 13:51 ? 00:00:00 [kblockd/1]
> root 23 15 0 13:51 ? 00:00:00 [kblockd/2]
> root 24 15 0 13:51 ? 00:00:00 [kblockd/3]
> root 11715 1 0 13:58 ? 00:00:00 [lockd]
> root 11762 1 0 13:58 ? 00:00:00 [lockd]
> root 11765 1 0 13:58 ? 00:00:00 [lockd]
> root 11800 1 0 13:58 ? 00:00:00 [lockd]
> root 11801 1 0 13:58 ? 00:00:00 [lockd]
> root 11811 1 0 13:58 ? 00:00:00 [lockd]
> root 11823 1 0 13:58 ? 00:00:00 [lockd]
> root 11825 1 0 13:58 ? 00:00:00 [lockd]
> root 11834 1 0 13:58 ? 00:00:00 [lockd]
> root 11835 1 0 13:58 ? 00:00:00 [lockd]
> root 11839 1 0 13:58 ? 00:00:00 [lockd]
> root 11859 1 0 13:58 ? 00:00:00 [lockd]
> root 11860 1 0 13:58 ? 00:00:00 [lockd]
> root 11870 1 0 13:58 ? 00:00:00 [lockd]
> root 11879 1 0 13:58 ? 00:00:00 [lockd]
> root 11883 1 0 13:58 ? 00:00:00 [lockd]
> root 11884 1 0 13:58 ? 00:00:00 [lockd]
> root 11894 1 0 13:59 ? 00:00:00 [lockd]
> root 11913 1 0 13:59 ? 00:00:00 [lockd]
> root 11915 1 0 13:59 ? 00:00:00 [lockd]
> root 11927 1 0 13:59 ? 00:00:00 [lockd]
> root 11928 1 0 13:59 ? 00:00:00 [lockd]
> root 11929 1 0 13:59 ? 00:00:00 [lockd]
> root 11940 1 0 13:59 ? 00:00:00 [lockd]
> root 11953 1 0 13:59 ? 00:00:00 [lockd]
> root 11963 1 0 13:59 ? 00:00:00 [lockd]
> root 11964 1 0 13:59 ? 00:00:00 [lockd]
> root 11965 1 0 13:59 ? 00:00:00 [lockd]
> root 11974 1 0 13:59 ? 00:00:00 [lockd]
> root 11978 1 0 13:59 ? 00:00:00 [lockd]
> root 11979 1 0 13:59 ? 00:00:00 [lockd]
> root 11988 1 0 13:59 ? 00:00:00 [lockd]
> root 11989 1 0 13:59 ? 00:00:00 [lockd]
> root 12264 1 0 13:59 ? 00:00:00 [lockd]
> root 12268 1 0 13:59 ? 00:00:00 [lockd]
> root 12488 1 0 13:59 ? 00:00:00 [lockd]
> root 12489 1 0 13:59 ? 00:00:00 [lockd]
> root 12490 1 0 13:59 ? 00:00:00 [lockd]
> root 12500 1 0 13:59 ? 00:00:00 [lockd]
> nfs 12905 10345 0 13:59 pts/1 00:00:00 grep lockd

There are no messages in the /var/log/messages.

If I try to mount/unmount the partitions manually without a loop they
completely work fine. I am able to mount and unmount them without any
problem. But whenever this is put in a infinite loop it goes to
inconsistent state.

Is it a some kind of bug?

Does anyone faced the same problem or anyone can help me in the case
what is going wrong and where?

TIA

Mohit Katiyar

HCL Technologies Ltd.
