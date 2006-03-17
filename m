Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWCQRrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWCQRrH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWCQRrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:47:06 -0500
Received: from orfeus.profiwh.com ([82.100.20.117]:10515 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S1030231AbWCQRrF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:47:05 -0500
Message-ID: <441AF62A.9090203@gmail.com>
Date: Fri, 17 Mar 2006 18:46:59 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: Ian Kent <raven@themaw.net>
CC: Jiri Slaby <xslaby@fi.muni.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: atomic counter underflow [Was: 2.6.16-rc6-mm1]
References: <E1FIYLc-00080b-00@decibel.fi.muni.cz> <Pine.LNX.4.64.0603131330210.21830@eagle.themaw.net>
In-Reply-To: <Pine.LNX.4.64.0603131330210.21830@eagle.themaw.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SpamReason: {}-{0,00}-{0,00}-{0,00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ian Kent napsal(a):
> On Sun, 12 Mar 2006, Jiri Slaby wrote:
> 
>> Andrew Morton wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/
>> [snip]
>>> +remove-redundant-check-from-autofs4_put_super.patch
>>> +autofs4-follow_link-missing-funtionality.patch
>>>
>>> Update autofs4 patches in -mm.
>> Hello, 
>>
>> I caught this during ftp browsing autofs-bind-mounted directories. I don't know
>> circumstancies and if the patches above are source of problem. I also don't know
>> if -rc6-mm1 is the first one.
> 
> btw what do you mean autofs-bind-mounted ?
Hmm, I am unable to reproduce it :(.
I have ftp dir, there is misc directory which is autofs maintained and --bind
mounted directories from some corners of / (i. e. ntfs and ext3 dirs mounted
through --bind).
in /etc/auto.master:
...
/home/ftp/misc /etc/auto.ftpmisc
...

in /etc/auto.ftpmisc:
...
l       -fstype=bind    :/l/latest
...

Somebody was browsing through the ftp binded tree and these bugs appeared (only
twice).
> 
>> BUG: atomic counter underflow at:
>>  [<c0104736>] show_trace+0x13/0x15
>>  [<c0104873>] dump_stack+0x1e/0x20
>>  [<c01d6c97>] autofs4_wait+0x751/0x93a
>>  [<c01d543b>] try_to_fill_dentry+0xca/0x11c
>>  [<c01d59b3>] autofs4_revalidate+0xe1/0x148
>>  [<c0171338>] do_lookup+0x40/0x157
>>  [<c0172ec4>] __link_path_walk+0x804/0xe8c
>>  [<c017359c>] link_path_walk+0x50/0xe8
>>  [<c01738b7>] do_path_lookup+0x10f/0x26d
>>  [<c017429c>] __user_walk_fd+0x33/0x50
>>  [<c016d226>] vfs_stat_fd+0x1e/0x50
>>  [<c016d30d>] vfs_stat+0x20/0x22
>>  [<c016d328>] sys_stat64+0x19/0x2d
>>  [<c0103127>] syscall_call+0x7/0xb
>>
> 
> There's some suspicious code in waitq.c.
> Could you try the following patch for me please?

I can't confirm... I don't know.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEGvYqMsxVwznUen4RAv+YAJ44g+S/1sPkwRRa5CURQ7r2bfXG/gCfavOk
EXGCvJfqpmMgaFmTcj/9gD0=
=3o55
-----END PGP SIGNATURE-----
