Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264375AbUE0NQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbUE0NQu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 09:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUE0NQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 09:16:33 -0400
Received: from penti.sit.fi ([193.167.33.237]:48865 "EHLO penti.sit.fi")
	by vger.kernel.org with ESMTP id S264349AbUE0NQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 09:16:22 -0400
Date: Thu, 27 May 2004 16:16:19 +0300 (EEST)
From: Harald Hannelius <harald@arcada.fi>
X-X-Sender: harald@penti.sit.fi
To: linux-kernel@vger.kernel.org
Subject: Poor NFS performance, kernel 2.6.6.  
Message-ID: <Pine.LNX.4.58.0405271612350.12816@penti.sit.fi>
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Fnord: +++ath
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[already posted this on the nfs-list too]

Hi there,

I'm running two servers, both Dual Opterons with Broadcom Gb NICs. I'm
using the bcm5700 driver and I see no errors whatsoever with 'ifconfig'.
These NICs are onboard PCIX:100MHz:64-bit.

I'm using nfs-utils-1.0.6 and the 2.6.6 kernel, compiled with both NFSv3
and NFSv4 support. The client and servers are identical except for the
server having a scsi-raid under /home and the client being and IDE-box.

Distribution slackware-9.1 on both computers.

/etc/exports;

   /home   193.167.32.175(ro,no_root_squash,async)

/etc/fstab;

  193.167.32.187:/home    /home   nfs     \
 defaults,noauto,rsize=32768,wsize=32768,nfsvers=3 0 0

(as you can see I have experimented with different rsize,wsize without any
noticeable effect, same goes for nfsvers 2 and 3. I even mounted the
filesystem as ext2 on the server and as ext3 with data=journal with no
effect)

The computers are connected through a HP 8-port Gb switch and are on the
same subnet.

rsync over ssh gives me roughly 200Mbps (37 GB dataset)
netcat over tcp with a 2GB file gives me 457 Mbps
netcat over udp with a 2GB file gives me 640 Mbps

But dd'ing the 2GB file over nfs as some NFS-HOWTO suggests takes over 5
minutes. That should equal to something around 49 Mbps, correct?

The netcat takes 25 secs to transfer 2GB file.

I installed kernel 2.4.26 and the netcat finished in 29seconds (550Mbps).
With kernel 2.4.26 the 'time cat largefile > /dev/null' over NFS took just
1min3s on the client. Which should equal to something like 254Mbps.


Is there some way I can look at the nfs-server what it's doing? Any
suggestions on solutions for this?

And what datarates over NFS could I expect on a setup like this?
Half-wirespeed maybe?

Thanks in advance,

  Harald



-- 
A: Top Posters
Q: What is the most annoying thing on mailing lists?

Harald H Hannelius | harald/a\arcada.fi      | GSM +358 50 594 1020
