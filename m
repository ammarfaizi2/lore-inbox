Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289053AbSAZKcl>; Sat, 26 Jan 2002 05:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289054AbSAZKcc>; Sat, 26 Jan 2002 05:32:32 -0500
Received: from [213.165.223.190] ([213.165.223.190]:384 "EHLO
	alpha.linuxassembly.org") by vger.kernel.org with ESMTP
	id <S289053AbSAZKcR>; Sat, 26 Jan 2002 05:32:17 -0500
Date: Sat, 26 Jan 2002 13:32:28 +0300 (MSK)
From: Konstantin Boldyshev <konst@linuxassembly.org>
To: linux-kernel@vger.kernel.org
Subject: /proc and /dev/pts [acm]time bug
Message-ID: <Pine.LNX.4.43L.0201261315350.24406-100000@alpha.linuxassembly.org>
Organization: Linux Assembly [http://linuxassembly.org]
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It seems that there's a bug in how kernel sets time values
on directories when mounting virtual filesystems on them
(at least /proc and /dev/pts). If local time is not GMT,
it seems to add GMT offset to directory time. I.e. when
localtime is GMT+N, then /proc gets localtime+N time
(actually GMT+N*2), which leads to [acm]time in the
future (the same happens with GMT-N).

Try running 'stat /proc' right after boot and you'll get the idea.
Note that this is clearly /kernel/ issue (not glibc's or whatever),
it happens right after virtual fs is mounted. Perhaps it affects
virtual filesystems other than proc and devpts, but it doesn't
affect shm filesystem.

I tried on 2.4.17 and 2.0.39, both versions behave the same,
it seems that the bug is there for a long time :).

-- 
Regards,
Konstantin

