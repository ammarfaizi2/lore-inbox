Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWCSBFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWCSBFh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 20:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWCSBFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 20:05:36 -0500
Received: from orfeus.profiwh.com ([82.100.20.117]:41485 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S1751162AbWCSBFg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 20:05:36 -0500
Message-ID: <441CAE6F.8020401@liberouter.org>
Date: Sun, 19 Mar 2006 02:05:28 +0059
From: Jiri Slaby <slaby@liberouter.org>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Ian Kent <raven@themaw.net>, Jiri Slaby <xslaby@fi.muni.cz>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: BUG: atomic counter underflow [Was: 2.6.16-rc6-mm1]
References: <E1FIYLc-00080b-00@decibel.fi.muni.cz> <Pine.LNX.4.64.0603131330210.21830@eagle.themaw.net> <441AF62A.9090203@gmail.com>
In-Reply-To: <441AF62A.9090203@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SpamReason: {}-{0,00}-{0,00}-{0,00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jiri Slaby napsal(a):
> Ian Kent napsal(a):
>>> On Sun, 12 Mar 2006, Jiri Slaby wrote:
>>>
>>>> Andrew Morton wrote:
>>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/
>>>> [snip]
>>>>> +remove-redundant-check-from-autofs4_put_super.patch
>>>>> +autofs4-follow_link-missing-funtionality.patch
>>>>>
>>>>> Update autofs4 patches in -mm.
>>>> Hello, 
>>>>
>>>> I caught this during ftp browsing autofs-bind-mounted directories. I don't know
>>>> circumstancies and if the patches above are source of problem. I also don't know
>>>> if -rc6-mm1 is the first one.
>>> btw what do you mean autofs-bind-mounted ?
> Hmm, I am unable to reproduce it :(.
Yup, I've got it:
while /bin/true; do cd /home/ftp/misc/.ftpaccess; done
[nonexistent dir]
kill it
and

Mar 19 02:03:08 localhost automount[25680]: failed to mount
/home/ftp/misc/.ftpaccess
Mar 19 02:03:08 localhost automount[25682]: failed to mount
/home/ftp/misc/.ftpaccess
Mar 19 02:03:08 localhost kernel: BUG: atomic counter underflow at:
Mar 19 02:03:08 localhost kernel:  [<c0104736>] show_trace+0x13/0x15
Mar 19 02:03:08 localhost kernel:  [<c0104873>] dump_stack+0x1e/0x20
Mar 19 02:03:08 localhost kernel:  [<c01d6c97>] autofs4_wait+0x751/0x93a
Mar 19 02:03:08 localhost kernel:  [<c01d543b>] try_to_fill_dentry+0xca/0x11c
Mar 19 02:03:08 localhost kernel:  [<c01d59b3>] autofs4_revalidate+0xe1/0x148
Mar 19 02:03:08 localhost kernel:  [<c0171338>] do_lookup+0x40/0x157
Mar 19 02:03:08 localhost kernel:  [<c0172ec4>] __link_path_walk+0x804/0xe8c
Mar 19 02:03:08 localhost kernel:  [<c017359c>] link_path_walk+0x50/0xe8
Mar 19 02:03:08 localhost kernel:  [<c01738b7>] do_path_lookup+0x10f/0x26d
Mar 19 02:03:08 localhost kernel:  [<c017429c>] __user_walk_fd+0x33/0x50
Mar 19 02:03:08 localhost kernel:  [<c0174412>] __user_walk+0x17/0x19
Mar 19 02:03:08 localhost automount[25683]: failed to mount
/home/ftp/misc/.ftpaccess
Mar 19 02:03:08 localhost kernel:  [<c0162fb3>] sys_chdir+0x1a/0x77
Mar 19 02:03:08 localhost kernel:  [<c0103127>] syscall_call+0x7/0xb
Mar 19 02:03:08 localhost automount[25684]: failed to mount
/home/ftp/misc/.ftpaccess

Now, I am going to test, if this dissapeared after your patch.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEHK5vMsxVwznUen4RAnFzAJ40HZllS1ypu5aH3LOLlg3AvZlhYwCfQc72
wL6CuAzQxu+IdR6+Da68vR8=
=HvFQ
-----END PGP SIGNATURE-----
