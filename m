Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932842AbWAIG3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932842AbWAIG3G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 01:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWAIG3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 01:29:06 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:60098 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932842AbWAIG3B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 01:29:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=f6gYuy6CgqPgphuSer/upHutNuWseHez3QfDwKVuMZivYrQMoMeKLno0fIb+ihjVgUFcNMuHzyW4u7y4RMTMVNA9gSlOcrHeP+o803S+/5VX2H6yGiX3oOV/N3gUJFBp3e7MP7ebjTSdRa8cXUFlmnZWR72lZaPVpJjD2yras78=
Message-ID: <f0309ff0601082229u3fc5e415m12be9dc921f4a099@mail.gmail.com>
Date: Sun, 8 Jan 2006 22:29:00 -0800
From: Nauman Tahir <nauman.tahir@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: X86_64 and X86_32 bit performance difference [Revisited]
Cc: kernelnewbies@nl.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All
I have posted this problem before. Now mailing again after testing as
recommeded in previous replys.
My configuration is:

Hardware:
HP Proliant DL145 (2 x AMD Optaron 144)
14 GB RAM

OS:
FC 4

Kernel
2.6.xx

As suggested by some friend, I compiled same kermel with maximum
possible common configuration options both on 32 and 64 bit. Tested my
deriver and got the same result.
Let me explain in detail whats going on.
I have a block device driver which uses my RAMDISK for caching the
data for some Target disk.
I have implemented two simple caching policies in it. I am running
IOTEST to see the IO rate of my driver. My RAMDISK differs for 32 and
64 bit versions. 32 bit version uses kmap family to read/write data
to/from memory while 64 bit version uses __va function call to get the
virtual address directly to avoid ioremap which sleeps and slows down
the IO rate considerably.RAMDISK individually gives very high IO rate
with IOTEST but perormance with my driver gets about one fourth. This
only happens when I run the whole thing on X86_64 bit compiled kernel.
Things works well on 32 bit version. Driver for both versions is same.
I can also not figure out what kernel configuration option is making
the difference if there is any.

My code does not seems to have portablility issues. Like calculations
are based on unsigned long. There are few threads involved based on
kernel_thread as used in MD driver.

Any ideas whats is the cause of performance difference? what areas to
look for ??

Nauman
