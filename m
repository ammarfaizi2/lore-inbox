Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281326AbRKHDHk>; Wed, 7 Nov 2001 22:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281333AbRKHDHa>; Wed, 7 Nov 2001 22:07:30 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:56838 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S281326AbRKHDHU>;
	Wed, 7 Nov 2001 22:07:20 -0500
Message-Id: <5.1.0.14.0.20011108133358.009fcaa0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 08 Nov 2001 14:07:10 +1100
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
From: Stuart Young <sgy@amc.com.au>
Subject: Re: Yet another design for /proc. Or actually /kernel.
In-Reply-To: <20011108012051.C568@blu>
In-Reply-To: <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu>
 <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:20 AM 8/11/01 +0100, antirez wrote:
>put every string inside () and only quotes ( and ) with \
>and quotes \ itself with \\, than use brackets to delimit
>string _and_  provide information about the format:
>
>((dev/hda1)(/home/mbrennek/stuff and)(vfat)(rw)(0)(0))
>((/dev/hda2)(/var/tmp)(ext2)(rw)(0)(0))

Now that is just really annoying, and hardly useful.

Why not just allow the user to specify what the field separation character 
is. If the entry/file is opened for writing, then the data passed to it is 
used as the separator. If it's opened in read, just output as normal.

So if say /proc/kernel/foo normally exports...

bar-a1  bar-a2  bar-a3
bar-b1  bar-b2  bar-b3
[===>         ] 40%

...and you pass a colon ":", it spits out...

bar-a1:bar-a2:bar-a3
bar-b1:bar-b2:bar-b3
40

This allows the user to make the choice. If they use the wrong character, 
they can always change it. If they don't specify one, they get the default 
output (which is what existing scripts will expect). From a code 
perspective, you should only need to make all your separators (formatting) 
as variables in the code, and substitute the separator character(s) if 
there is one that's been passed, and just drop the remaining 'pretty' 
garbage totally.

Also means you can easily use command line tools like cut (-d option), 
readline (the read function in bash, and the $IFS variable), and so on, to 
parse the data, quickly and effectively.


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

