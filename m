Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAOTG7>; Mon, 15 Jan 2001 14:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbRAOTGu>; Mon, 15 Jan 2001 14:06:50 -0500
Received: from stud4.tuwien.ac.at ([193.170.75.21]:64519 "EHLO
	stud4.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S129431AbRAOTGi>; Mon, 15 Jan 2001 14:06:38 -0500
Date: Mon, 15 Jan 2001 20:06:35 +0100 (MET)
From: Robert Reither <e8925573@student.tuwien.ac.at>
To: linux-kernel@vger.kernel.org
Subject: Problems with bigblock support of fat
Message-ID: <Pine.HPX.4.10.10101152002410.23822-100000@stud4.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I encounted really bad problems with 2048 Bytes/sec MO-Drive.
I'm using an Olympus PowerMO 640.
230MB Media works fine, but if i try to use 640(2048B/S) medias i'm really
in troubles. Looks quite the same as the problems i've reported for the
2.1.x kernels some time ago. (2.2.17/18 works fine 4 me).

OK, what i did :

Using kernel 2.4.0 on an Athlon TB 750 with 128 MB
MO was formated with FAT32.

i mounted the mo drive ...

i try to read a file from it (used : 'pico /mo/file.txt') ...
And got a nice crash : Segmentation Fault

OK, was easy to find this bug, fs/fat/cvf.c has a bug in bigblock_cvf struct
the field with the read function was a NULL.
I changed this to generic_file_read (like with default blocksize), and
tested it. First seemed to work fine, but :

I could read/write a file now, but the written data was not compatible
with DOS Systems (Tested under DOS6.22, WIN98SE) !

If i write a file to an empty MO-Disk, the start-cluster is 2 in the 
table. But the real data was written to (and also read from)
cluster 33 by linux !

I already posted this report to the maintainer of the fat-fs(Gordon Chaffee)
 a month ago, but i did not get a response yet. 
(tested it with kernel -test8 and -test9)


############################################################################
Robert Reither                8925573 E754 (ja wirklich schon !!)
TU-Vienna
AUSTRIA
############################################################################

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
