Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbUK3Sya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbUK3Sya (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUK3Sx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:53:58 -0500
Received: from fire.osdl.org ([65.172.181.4]:16787 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262265AbUK3Sva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:51:30 -0500
Message-ID: <41ACA5C0.1060509@osdl.org>
Date: Tue, 30 Nov 2004 08:54:24 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yihan Li <Yihan.Li@Edgewater.CA>
CC: linux-kernel@vger.kernel.org
Subject: Re: patch RTAI (fusion-0.6.4) with kernel 2.6.9 on Fedora Core 3
References: <000901c4d70c$0ecf1bd0$8500a8c0@WS055>
In-Reply-To: <000901c4d70c$0ecf1bd0$8500a8c0@WS055>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yihan Li wrote:
> Help needed!
> I am trying to patch RTAI (fusion-0.6.4) with kernel 2.6.9 on Fedora 
> Core 3.
> The following steps are what I was following:
> 
> I download a varnilla version of linux-2.6.9 from www.kernel.org,
> Unpack the kernel source:
> # cd /usr/src
> # tar xvjf linux-2.6.9.tar.bz2
> # ln -s linux-2.6.9 linux
> 
> Unpack or copy RTAI to  /usr/src/fusion-0.6.4.tar.bz2
> # ln -s fusion-0.6.4  rtai
> 
> Patch the kernel:
> # cd /usr/src/linux
> # patch -p1 < ../rtai/arch/i386/patches/adeos-linux-2.6.9-i386-r8.patch
> Copy the existing (Fedora) kernel config file to /usr/src/linux
> # cp /boot/config-2.6.xxxx /usr/src/linux/.configConfigure the kernel:
> # make menuconfig
> # make
> 
> After 8 mins, I get error messages as following:
> drivers/scsi/qla2xxx/qla_os.c: In function `qla2x00_queuecommand':
> drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining failed in
> call to 'qla2x00_callback': function not considered for inlining
> drivers/scsi/qla2xxx/qla_os.c:269: sorry, unimplemented: called from here
> drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining failed in
> call to 'qla2x00_callback': function not considered for inlining
> drivers/scsi/qla2xxx/qla_os.c:269: sorry, unimplemented: called from here
> make[3]: *** [drivers/scsi/qla2xxx/qla_os.o] Error 1
> make[2]: *** [drivers/scsi/qla2xxx] Error 2
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2
> 
> My guess is my configuration is not right, and don't know what to do, 
> really
> need a hand ...
> 
> I wish to be personally CC'ed the answers/comments in response to my
> posting.

Some functions (inline) and function prototypes in that driver are
not in the order needed.  It's been fixed for some time now.
Check linux-2.6.10-rc2 or the -mm patches.

-- 
~Randy
