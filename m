Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWBCF5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWBCF5p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 00:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWBCF5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 00:57:45 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:60309 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751174AbWBCF5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 00:57:44 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Fri, 3 Feb 2006 07:57:29 +0200
User-Agent: KMail/1.8.2
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
References: <200601281613.16199.vda@ilport.com.ua> <200602020925.00863.vda@ilport.com.ua> <43E25E39.4010908@tmr.com>
In-Reply-To: <43E25E39.4010908@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602030757.29640.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 February 2006 21:32, Bill Davidsen wrote:
> >>reiserfstune -s 1024 /dev/xxxx
> > 
> > I had reiserfsprogs 3.6.11 and reiserfstune (above command) made my /dev/sdc3
> > unmountable without -t reiserfs. I upgraded reiserfsprogs to 3.6.19 and now
> > reiserfsck /dev/sdc3 reports no problems, but mount problem persists:
> > 
> > # mount -t reiserfs /dev/sdc3 /.3
> > # umount /.3
> > # mount /dev/sdc3 /.3
> > mount: you must specify the filesystem type
> > # dmesg | tail -3
> > br: port 1(ifi) entering forwarding state
> > FAT: bogus number of reserved sectors
> > VFS: Can't find a valid FAT filesystem on dev sdc3.
> > 
> > "chown -Rc <n>:<m> ." now does not OOM kill the box, so this issue
> > is resolved, thanks!
> > 
> > Can I restore sdc3 somehow that I won't need -t reiserfs in mount command?
> > You can find result of
> > 
> > dd if=/dev/sdc3 of=1m bs=1M count=1
> > 
> > at http://195.66.192.167/linux/1m
> 
> At the risk of stating the obvious:
> 1 - is reaser a module, and is it loaded?
> 2 - did this ever work? I think you said you removed the entry from 
> fstab, was the filetype there which made it work?

1 - not a module, 2 - fstab line was "/dev/sdc3 /.3 auto noatime,rw 1 1".
But anyway. mount problem is solved now, mount from util-linux 2.11p
tried to "autodetect" fs and thought it's a FAT partition.

mount from busybox 1.0 works.
--
vda
