Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289883AbSAPGPM>; Wed, 16 Jan 2002 01:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289884AbSAPGPC>; Wed, 16 Jan 2002 01:15:02 -0500
Received: from zeus.kernel.org ([204.152.189.113]:47273 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289883AbSAPGOp>;
	Wed, 16 Jan 2002 01:14:45 -0500
Subject: Performance: Neighbour table overflow
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF742EAB6F.38453691-ON65256B43.0021390F@in.ibm.com>
From: "Rajasekhar Inguva" <irajasek@in.ibm.com>
Date: Wed, 16 Jan 2002 11:43:46 +0530
X-MIMETrack: Serialize by Router on d23m0067/23/M/IBM(Release 5.0.8 |June 18, 2001) at
 16/01/2002 11:43:49 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I have observed that when the ARP cache is full , any further networking
apps fail with error "Neighbour table overflow" until a timer expires and
the cache is cleared. Below is a detailed re-creation scenario....

1) Set  /proc/sys/net/ipv4/neigh/default/gc_thresh1,2,3  to values 2
2) ping one_neighbour ( arp cache now has this entry )
3) ping another_neighbour ( arp cache has now 2 entries )
4) ping third_neighbour

    Neighbour table overflow
    Ping: No buffer space available

Until the timer expires and the arp cache gets cleared , no further network
connections succeed.

IMHO, in situations wherein stale entries do exist in the cache and the
cache is full, then one should not wait for a timer expiry but remove a few
entries asap.

I get a feeling it might violate some rfc's , but i am not really sure....

Any feedback ?

Regards,

Raj

