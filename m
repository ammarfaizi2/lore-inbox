Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293096AbSB1AUQ>; Wed, 27 Feb 2002 19:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293095AbSB1ATc>; Wed, 27 Feb 2002 19:19:32 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:53936 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S293094AbSB1ATJ>; Wed, 27 Feb 2002 19:19:09 -0500
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
X-Comment-To: Alan Cox
In-Reply-To: <fa.kjtklqv.gnqri3@ifi.uio.no> <fa.g63p78v.1e7kv8e@ifi.uio.no>
Subject: Re: Linux 2.4.19pre1-ac1
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: daria.co.uk
Message-ID: <7180.3c7d7778.11315@trespassersw.daria.co.uk>
Date: Thu, 28 Feb 2002 00:19:04 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <fa.g63p78v.1e7kv8e@ifi.uio.no>,
	Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>> >> With 19-pre1-ac1 on a reiserfs partition I cannot patch a kernel. Patch
>> >> fails with "Invalid cross-device link" or "Out of disk space".
>> AF> 
>> AF> I can reproduce this too on ext2, so this does not seem to be FS related. 
>> 
>> Likewise (reiserfs here). Numerous fuzz or outright patch failures
>> with 2.4.19-pre1-ac1.
AC> 
AC> See the other mail for the questions - and reply to that too if you can. 
AC> Right now I've not managed to reproduce it. Do you see the problem on
AC> 2.4.19-pre1 (non -ac) [that has the same reiserfs changes in as -ac does]

There were no problems with 2.4.19-pre1, to which I reverted, pulled
the full 2.4.18, and patched back up to 2.4.19-pre1-ac2.

Booted into 2.4.19-pre1-ac2.

Patched back down to 2.4.18 and then back up to 2.4.19-pre1-ac2 again,
no problems seen.

Rebuilt 2.4.19-pre1-ac2 in 2.4.19-pre1-ac2. Reboot.

Ran the following twice.

for i in $(seq 1 10)
do 
 bzcat /net/tw/home/jrh/dl/patch-2.4.19-pre1-ac2.bz2 | patch -p1 -R
 bzcat /net/tw/home/jrh/dl/patch-2.4.19-pre1.bz2 | patch -p1 -R
 sleep 1
 bzcat /net/tw/home/jrh/dl/patch-2.4.19-pre1.bz2 | patch -p1  
 bzcat /net/tw/home/jrh/dl/patch-2.4.19-pre1-ac2.bz2 | patch -p1 
 echo "===========>" Step $i 
done

No problems seen. ac1 would have not have survived the above, so I'm
pretty sure that 2.4.19-pre1-ac2 has fixed the pre1 problems.


