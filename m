Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314123AbSDVLBG>; Mon, 22 Apr 2002 07:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314125AbSDVLBF>; Mon, 22 Apr 2002 07:01:05 -0400
Received: from firewall.conet.cz ([213.175.54.250]:54802 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S314123AbSDVLBF>; Mon, 22 Apr 2002 07:01:05 -0400
Message-ID: <3CC3ECD2.9000205@conet.cz>
Date: Mon, 22 Apr 2002 12:58:26 +0200
From: =?ISO-8859-2?Q?Libor_Van=ECk?= <libor@conet.cz>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Adding snapshot capability to Linux
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm going to start my dissertation work which is "Adding snapshop 
capability to Linux kernel with copy-on-write support". My idea is add 
it as another VFS - I know that there is some snapshot support in LVM 
but it's working on "device-level" and I'd like/have to do it on fs level.

My idea is to use it this way:
- I have running system with some "/foo" dir
- I want to make snapshot of "/foo/bar" to "/foo/snap1"
- I run "mount -t snapshot /foo/bar /foo/snap1"
- This creates virtual image of "/foo/bar" to the "/foo/snap1" with 
hidden file (something like journal) in "/foo/snap1" - all files are 
linked to "/foo/bar"
- Whenever is some file/dir changed in "/foo/bar" there is created 
physical copy of it to the snapshot(s) before writing changes (for 
making records about this will be used the hidden file)
- Of course that one directory can be snapshoted more times
- Probably the hidden file with records about all snapshots and details 
should be stored in "/foo/bar"
- Question is how to handle ACLs and EA for XFS/JFS/... and if it won't 
collide with journal

I'd like to do it not only because I have to but I want people to use it 
(I want to make it GPL) and maybe it will be one nice day part of Linux 
kernel ;-)

So I'd like if you can send me any suggestions/tips/warnings/links etc. 
before I start coding so I know what should I avoid/use.

Thanks,
Libor

