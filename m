Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWBMBAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWBMBAz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWBMBAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:00:55 -0500
Received: from smtp.enternet.hu ([62.112.192.21]:7940 "EHLO smtp.enternet.hu")
	by vger.kernel.org with ESMTP id S1751480AbWBMBAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:00:54 -0500
Message-ID: <01c801c63039$de70c780$9d00a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [QUESTION] NFS and new kernels.
Date: Mon, 13 Feb 2006 02:07:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, list,

I use the NFS couple of years, so i think, i know what am i doing.
I have 7 servers, that boots from NFS, using nfsroot.
Now i plan to replace the NFS server, to completely newer system, and i get
seriously strange messages.
The general problem is i cannot mount any NFS shares, at all, after i
upgrade the kernel the FC4-based kernel(2.6.11) to 2.6.16-rcX.
I have spend some days to read mans, faqs, howtos, mailing list, but did not
find any interesting.
This tells me: i am the stupid. :-)

The general problem, is this:

(client)[root@st-0001 root]# mount: 192.168.0.2://mountpoint failed, reason
given by server: Permission denied
(server)[root@NetCenter log]# mount: localhost://mountpoint failed, reason
given by server: Permission denied
(client)[root@st-0001 root]# showmount -e 192.168.0.2
/mnt/EXT                192.168.2.*
/mnt/EXT/NFS/ROOT       (everyone)
/mountpoint            st-0001
etc...

[root@st-0001 root]# rpcinfo -p 192.168.0.2
   program vers proto   port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
    100011    1   udp    999  rquotad
    100011    2   udp    999  rquotad
    100003    2   udp   2049  nfs
    100003    3   udp   2049  nfs
    100003    4   udp   2049  nfs
    100003    2   tcp   2049  nfs
    100003    3   tcp   2049  nfs
    100003    4   tcp   2049  nfs
    100005    1   udp   1010  mountd
    100005    1   tcp   1013  mountd
    100005    2   udp   1010  mountd
    100005    2   tcp   1013  mountd
    100005    3   udp   1010  mountd
    100005    3   tcp   1013  mountd


(server "NetCenter")
Feb  4 03:42:47 NetCenter rpc.mountd: mount request from unknown host
127.0.0.1 for /mountpoint (/mountpoint)
Feb  4 02:09:03 NetCenter rpc.mountd: authenticated mount request from
192.168.2.50:728 for /mountpoint (/mountpoint)
Feb 10 19:51:09 NetCenter mountd[26698]: authenticated mount request from
st-0001:894 for /mountpoint (/mountpoint)
...

[root@NetCenter log]# cat /proc/fs/nfs/exports:
# Version 1.1
# Path Client(Flags) # IPs
/mountpoint       st-0001(rw,no_root_squash,async,wdelay)

The additional problem is, i cannot add, to this file all line in the
/etc/exports.
Only the named hosts.
The exportfs -ra did not add, the * host.

Before i upgrade the nfs-utils-1.0.8-rc2, the old exportfs did not add
anything!

The firewall, is off, on both systems.
The /etc/hosts.allow and deny are both empty.

What have i missing?

Thanks,
Janos

