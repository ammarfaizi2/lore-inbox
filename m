Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129665AbQKFAaN>; Sun, 5 Nov 2000 19:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129642AbQKFAaE>; Sun, 5 Nov 2000 19:30:04 -0500
Received: from napalm.go.cz ([212.24.148.98]:50692 "EHLO napalm.go.cz")
	by vger.kernel.org with ESMTP id <S129117AbQKFA3y>;
	Sun, 5 Nov 2000 19:29:54 -0500
Date: Mon, 6 Nov 2000 01:29:24 +0100
From: Jan Dvorak <johnydog@go.cz>
To: Lutz Pressler <lp@SerNet.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.(0-test10): /proc security hole
Message-ID: <20001106012924.A7469@napalm.go.cz>
Mail-Followup-To: Lutz Pressler <lp@SerNet.DE>,
	linux-kernel@vger.kernel.org
In-Reply-To: <8u3lom$5es$1@server1.GoeNet.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8u3lom$5es$1@server1.GoeNet.DE>; from lp@SerNet.DE on Sun, Nov 05, 2000 at 01:02:14PM +0000
Organization: (XNET.cz)
X-URL: http://doga.go.cz/
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2000 at 01:02:14PM +0000, Lutz Pressler wrote:
> Hello,
> 
> I do not think that the following behaviour (2.4.0-test10 on i386, also
> tested with 2.4.0-test8) is intended: 
> 
..
> This is bad. 2.2 kernels don't show this behavior. There _any_
> /proc/PID/cwd "directory" has no group or world permissions
> at all.
> 
> I haven't looked at the code at all yet. Anybody with a fix?

I wonder that noone rospond. I can confirm this - in 2.2.x links to cwd,
exe etc. pointed to nowhere (readlink failed) when there was insufficient
privileges to enter the dir. In 2.4.x the links blindly points to directory
setting all its privileges for access by /proc. Because everyone has dirs
drwxr-xr-x in his home, such dirs now become accesible through /proc if user
is in them. This is real security leak. 

ex:

[johnydog@napalm 210]$ whoami
johnydog
[johnydog@napalm 210]$ pwd
/proc/210
[johnydog@napalm 210]$ ls -l ./cwd
lrwxrwxrwx    1 root     root            0 Nov  6 01:26 ./cwd -> /root/.mc
[johnydog@napalm 210]$ cd /root/.mc
bash: /root/.mc: Permission denied
[johnydog@napalm 210]$ cd cwd
[johnydog@napalm cwd]$ ls -l
total 53
-rw-r--r--    1 root     root           35 Nov  6 01:16 Tree
-rw-r--r--    1 root     root        13203 May 31 11:54 ext
-rw-------    1 root     root        15952 Nov  6 01:16 history
-rw-------    1 root     root           20 May  6  1998 hotlist
-rw-r--r--    1 root     root         6417 Nov  6 01:16 ini
drwx------    2 root     root         3072 Nov  6 01:16 tmp
-rw-r--r--    1 root     root        10121 Jun 30 17:04 tree
[johnydog@napalm cwd]$


Jan Dvorak <johnydog@go.cz>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
