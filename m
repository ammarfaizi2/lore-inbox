Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277297AbRJJQPB>; Wed, 10 Oct 2001 12:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277302AbRJJQOv>; Wed, 10 Oct 2001 12:14:51 -0400
Received: from c009-h019.c009.snv.cp.net ([209.228.34.132]:7577 "HELO
	c009.snv.cp.net") by vger.kernel.org with SMTP id <S277299AbRJJQOh>;
	Wed, 10 Oct 2001 12:14:37 -0400
X-Sent: 10 Oct 2001 16:15:02 GMT
Date: Wed, 10 Oct 2001 09:16:13 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@desktop>
To: <linux-kernel@vger.kernel.org>
Subject: seq i/o kills all kernels
Message-ID: <Pine.LNX.4.33.0110100847390.19056-100000@desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just did some more testing with 2.4.10-ac10, 2.4.10-ac10-eatcache, and
2.4.11.  Fast sequential i/o on any of these kernels makes the system
stop doing anything else.

On 2.4.10-ac10 and 2.4.10-ac10-eatcache, the performance is the same.  I
start a mmap i/o process that reads and writes 16MB blocks in a 1GB file.
This proceeds at about 20MB/s while nothing else is running.  XMMS is
undisturbed by this activity.  Then, I start dd if=/dev/zero of=bigfile
bs=32k count=32768.  This proceeds at 40MB/s but XMMS stops completely and
the mmap i/o rate at the same time fals to about 100KB/s.  Essentially no
other process makes progress while the dd is running.  The system is
unusable.

On 2.4.11, XMMS skips[1] but the mmap i/o continues to make progress at
about 5MB/s.  The dd proceeds as well, slightly slower than under
2.4.10-ac10[-eatcache].  Interactive behavior is abyssmal.

The machine is 1.4GHz Athlon, 256MB main memory, software RAID-1 on
aic7xxx.

No, I haven't tried preemptible kernel yet.

-jwb

[1] Skipping is a gentle term.  XMMS plays 10ms bursts every 5-10 seconds.

