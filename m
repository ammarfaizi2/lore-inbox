Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130619AbRCPQOw>; Fri, 16 Mar 2001 11:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130656AbRCPQOo>; Fri, 16 Mar 2001 11:14:44 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:63501 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S130619AbRCPQO0>; Fri, 16 Mar 2001 11:14:26 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Message-ID: <86256A11.00590FF8.00@smtpnotes.altec.com>
Date: Fri, 16 Mar 2001 10:12:42 -0600
Subject: Re: How to mount /proc/sys/fs/binfmt_misc ?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thanks for the quick response.  I took your suggestion (a) and created
/etc/binfmt_misc, and set up a test in my rc.local to mount it and register my
usual entries there if /proc/sys/fs/binfmt_misc doesn't exist.  So now it works
with both 2.4.3-pre4 and 2.4.2-ac20.

Wayne




Alexander Viro <viro@math.psu.edu> on 03/16/2001 09:37:49 AM

To:   Wayne Brown/Corporate/Altec@Altec
cc:   linux-kernel@vger.kernel.org

Subject:  Re: How to mount /proc/sys/fs/binfmt_misc ?





On Fri, 16 Mar 2001 Wayne.Brown@altec.com wrote:

>   The release notes specify this:
>
>      mount -t binfmt_misc none /proc/sys/fs/binfmt_misc
>
> but this doesn't work because
>
>      mount: mount point /proc/sys/fs/binfmt_misc does not exist

Grr... OK, I've been an overoptimistic idiot and missed that ugliness.

Solutions:
     a) mount it on some real place. And write there to register
entries instead of the bogus /proc/sys/fs/binfmt_misc
     b) add a couple of proc_mkdir() into fs/proc/root.c
That is, add
     proc_mkdir("sys/fs", 0):
     proc_mkdir("sys/fs/binfmt_misc", 0);
after the line that says
     proc_mkdir("sys", 0);

I would strongly recommend (a). In the long run we'll need to go that
way.



