Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280322AbRKIXxK>; Fri, 9 Nov 2001 18:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280323AbRKIXxB>; Fri, 9 Nov 2001 18:53:01 -0500
Received: from elin.scali.no ([62.70.89.10]:8455 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S280322AbRKIXwt>;
	Fri, 9 Nov 2001 18:52:49 -0500
Date: Sat, 10 Nov 2001 00:52:47 +0100 (CET)
From: Terje Eggestad <terje.eggestad@scali.no>
To: <linux-kernel@vger.kernel.org>
Subject: confused about raw-io blocksizes
Message-ID: <Pine.LNX.4.30.0111092333100.24890-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm curious as to what sets the smallest legal blocksize for raw-io, I
get different values for different partitions on the same disk drive.

In all my tests I've used
raw /dev/raw/raw2 <block speclial file>
and to test block size:
dd if=/dev/raw/raw2 of=/dev/null bs=N count=1
where N is either 512, 1024, or 4096.
(I've a RH7.1 with a dd that do propper buffer alignment)
Failure is always "invalid argument" which singify either misaligned
buffer or illegal read length.

What confuses me is that when raw2 is bound to /dev/hda bs=512 is ok.
However when binding raw2 to the different partitions on /dev/hda, some
are ok with 512, some will only accept 1024, and one required 4096.

When creating an lvm vg on one partition (/dev/hda6), and I've created
two logical volumes on it, one was ok with 1024 and the other required
4096. When binding a raw to /dev/hda6 dd with bs=512 was ok.


When doing dd on the block special files bs=512  is always OK.



The reason I messing with this is that I'm working with an animal called
Oracle Real Application Cluster 9i which need a partiontion on a shared
disk to hold the cluster config. Installation stopped because the program
oracle provides to format the partition do 512 byte io, and require a
character raw device...

TJ

-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY
_________________________________________________________________________

