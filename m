Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267029AbUBMOOa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 09:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267033AbUBMOOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 09:14:30 -0500
Received: from f22.mail.ru ([194.67.57.55]:54289 "EHLO f22.mail.ru")
	by vger.kernel.org with ESMTP id S267029AbUBMOO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 09:14:28 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: der.eremit@email.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initrd Question
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.204.70.139]
Date: Fri, 13 Feb 2004 17:14:25 +0300
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1Are5J-000KGt-00.arvidjaar-mail-ru@f22.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> echo 0x0100 > /proc/sys/kernel/real-root-dev
>
> This makes no sense as you're using pivot_root. 

this makes all sort of sense. Please check sources. It is required so that kernel will not attempt to mount root passed to it by loader. You are welcome to clean up the code :)

>> mount -n -o ro /dev/sda2 /new_root
>
> This doesn't even match with the 0x0100 above, now does it?

so what? kernel happily ignores real-root-dev, it is possible that some user-level tools may be confused but I have not seen any so far.

>> pivot_root /new_root /new_root/initrd
>
> You should cd into /new_root before running pivot_root,

Huh? Why?

SYNOPSIS
       pivot_root new_root put_old

>> if [ -c initrd/dev/.devfsd ]
>>   then
>>           echo "Mounting devfs..."
>>           mount -n -t devfs none dev
>> fi
>
> Should you check for /dev/.devfsd on the real root here? I thought .devfsd
> is created by the devfsd process, 

you are wrong here, sorry. .devfsd is created by devfs.

-andrey


