Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281458AbRLLRYO>; Wed, 12 Dec 2001 12:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281473AbRLLRYF>; Wed, 12 Dec 2001 12:24:05 -0500
Received: from mail-smtp.uvsc.edu ([161.28.224.157]:14359 "HELO
	mail-smtp.uvsc.edu") by vger.kernel.org with SMTP
	id <S281458AbRLLRXy> convert rfc822-to-8bit; Wed, 12 Dec 2001 12:23:54 -0500
Message-Id: <sc172fdb.090@mail-smtp.uvsc.edu>
X-Mailer: Novell GroupWise Internet Agent 5.5.4.1
Date: Wed, 12 Dec 2001 10:22:04 -0700
From: "Tyler BIRD" <BIRDTY@uvsc.edu>
To: <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: NFS woes in 2.5.1-pre8
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Search the kernel sources at: http://lxr.linux.no/source/kernel/?v=2.4.13 or 2.4.26, etc
I know the ip addres for each interface are stored somewhere.
They have to be because they are passed down to the net driver inside of  socket buffers ( skb )
as a struct tcphdr *  and they have to be appended to each packet.

Tyler


>>> Russell King <rmk@arm.linux.org.uk> 12/12/01 09:43AM >>>
I'm not sure if this is expected or not, but I'm seeing odd behaviour with
NFS on 2.5.1-pre8:

[root@assabet bin]$vdir ../lib
-rwxr-xr-x    1       51       51   29091 Dec 12  2001 libts-0.0.so.0.0.0
../lib: Input/output error
[root@assabet bin]$uname -a
Linux assabet 2.5.1-pre8 #69 Mon Dec 10 22:21:15 GMT 2001 armv4l unknown
[root@assabet bin]$

Looking at the NFS traffic:

16:27:09.051301 assabet.arm.linux.org.uk.33f11c24 > raistlin.arm.linux.org.uk.nfs: 148 lookup fh Unknown/1 "libts-0.0.so.0" (DF)
16:27:09.061306 raistlin.arm.linux.org.uk.nfs > assabet.arm.linux.org.uk.33f11c24: reply ok 128 lookup fh Unknown/1 (DF)

Admittedly raistlin is running a rather old, obsolete NFS server, which has
up until now worked faultlessly for around 2 years: Universal NFS Server
2.2beta48

Appologies, but I'm not sure how I got it into this state either - last
thing I had done was to overwrite the files in ../lib and bin with new sets
on the NFS server.  The only directory that is suffering is ../lib.
(there's bin and ../include as well, both of which would've had their
files overwritten with later versions).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/

