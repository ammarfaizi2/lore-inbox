Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275778AbRJJNu2>; Wed, 10 Oct 2001 09:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275789AbRJJNuT>; Wed, 10 Oct 2001 09:50:19 -0400
Received: from [195.66.192.167] ([195.66.192.167]:7443 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S275778AbRJJNuC>; Wed, 10 Oct 2001 09:50:02 -0400
Date: Wed, 10 Oct 2001 16:47:10 +0200
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <49983926.20011010164710@port.imtp.ilyichevsk.odessa.ua>
To: "Richard B. Johnson" <root@chaos.analogic.com>,
        Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel size
In-Reply-To: <Pine.LNX.3.95.1011010084118.8134B-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1011010084118.8134B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard,
Wednesday, October 10, 2001, 3:00:32 PM, you wrote:

RBJ> Yes... but.  The final test was using bzImage which became about 1k
RBJ> shorter after making the changes to vmlinux.lds.
...
RBJ> -rw-r--r--   1 root     root       575432 Oct  9 13:49 bzImage
RBJ> -rw-r--r--   1 root     root       581384 Oct  1 13:27 bzImage.OLD
...
RBJ> The size change of the raw image is even more evident:
...
RBJ> -rwxr-xr-x   1 root     root      1548916 Oct  9 13:49 vmlinux
RBJ> -rwxr-xr-x   1 root     root      1590692 Oct  1 13:26 vmlinux.OLD
...
RBJ> Also I was not complaining about anything. One respondent noted
RBJ> that compiling the kernel with a new 'C' compiler resulted in
RBJ> a large increase in kernel size. Some of us then attempted to
RBJ> find out simple ways to get the kernel size back down. I showed
RBJ> that some 'C' compiler versions have enormous ID strings that
RBJ> are wasting space. I also mentioned that some versions align
RBJ> everything on 16-byte boundaries and there doesn't seem to
RBJ> be any way to turn off this 'feature'.

Ok. Learning from makefiles: bzImage's copressed part is made
by gzipping toplevel 'vmlinux' processed via objcopy.

If anybody feel so inclined, I suggest doing
#objdump -O binary -R .note -R .comment -S   vmlinux vmlinux.stripped
(that's what make bzImage does, feeding result to gzip)
and inspecting 'vmlinux.stripped' for large zeroed areas
and big/strange regular patterns. That might be oversized tables.

I'd like to be enlightened how I can translate offsets in
'vmlinux.stripped' to corresponding kernel func/var...
-- 
Best regards, vda
mailto:vda@port.imtp.ilyichevsk.odessa.ua


