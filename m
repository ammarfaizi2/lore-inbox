Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291775AbSCIMUf>; Sat, 9 Mar 2002 07:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292660AbSCIMUQ>; Sat, 9 Mar 2002 07:20:16 -0500
Received: from ns.ithnet.com ([217.64.64.10]:33541 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S291775AbSCIMUF>;
	Sat, 9 Mar 2002 07:20:05 -0500
Date: Sat, 9 Mar 2002 13:19:56 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020309131956.77ebf679.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I just upgraded a host from 2.2.19 to 2.2.21-pre3 and discovered a problem with kernel nfs. Setup is this:

knfs-server is 2.4.19-pre2
knfs-client is 2.2.21-pre3

First mount some fs (mountpoint /backup). Then go and mount some other fs from the same server (mountpoint /mnt), do some i/o on the latter and umount it again. Now try to access /backup. You see:
1) /backup (as a fs) vanished, you get a stale nfs handle.
2) umount /backup; mount /backup does not work. client tells "permission denied". server tells "rpc.mountd: getfh failed: Operation not permitted"

Only solution: restart nfs-server (no reboot required), then everything works again.
Same setup works with 2.2.19-client.

Any hints?

Regards,
Stephan

