Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319196AbSHNE3l>; Wed, 14 Aug 2002 00:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319197AbSHNE3k>; Wed, 14 Aug 2002 00:29:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27666 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319196AbSHNE3k>; Wed, 14 Aug 2002 00:29:40 -0400
Message-ID: <3D59DD94.6040406@zytor.com>
Date: Tue, 13 Aug 2002 21:33:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Benjamin LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@zip.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
References: <Pine.GSO.4.21.0208140016140.3712-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> I have a better suggestion.  How about we make write(2) on /dev/console to
> act as printk()?  IOW, how about making _all_ writes to console show up in
> dmesg?
> 
> Then we don't need anything special to do logging _and_ we get output
> of init scripts captured.  For free.  dmesg(8) would pick that up, klogd(8)
> will work as is, etc.
> 

/dev/console is probably unsuitable for this (/dev/console is an 
interactive device), but something like /dev/kmsg would probably be a 
good idea -- it can also replace /proc/kmsg.

However, Andrew's sys_syslog() change does what I need, since users are 
used to calling syslog(3) to log messages anyway.

	-hpa


