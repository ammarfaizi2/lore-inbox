Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbUBUAiX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUBUAiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:38:23 -0500
Received: from leary.csoft.net ([63.111.22.80]:47030 "HELO mail63.csoft.net")
	by vger.kernel.org with SMTP id S261461AbUBUAhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:37:50 -0500
Message-ID: <4036A85D.9040409@mattcaron.net>
Date: Fri, 20 Feb 2004 19:37:49 -0500
From: Matthew Caron <matt@mattcaron.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2 PROBLEMs: mkinitrd fails during make install (2.6.1) + first
 network connect fails after boot (2.6.1)
References: <40268B01.10608@mattcaron.net> <20040208190812.07703fce.rddunlap@osdl.org>
In-Reply-To: <20040208190812.07703fce.rddunlap@osdl.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have resolved my 2 problems. I have included abbreviated versions 
below for reference.

Problem 1 was solved by workaround.
1.) Compile 3w-xxxx as a module and nothing complains (on both systems)
2.) Add a modprobe 3w-xxxx early in rc.sysinit and it gets loaded before 
anything important happens (boot drive is separate IDE, so this scheme 
works for me)
3.) On some machines (1 of 2), mkinitrd still reports the error quoted 
below when trying to put 3w-xxxx into the kernel. On all machines (2 of 
2) using 3w-xxxx modules, the kernel does not automagically load the 
modules on boot. I presume it's not supposed to. Of course, the first 
hangup means that one cannot boot from the 3w-xxxx array. I do not have 
a problem with this, but it bears considering, because some folks might 
want to do it.

Problem 2 was my fault.
I still had FreeS/WAN starting up in my rc5.d from the 2.4.x setup that 
I had and that seemed to be killing network communications. Turning that 
off seemed to fix things.

Randy.Dunlap wrote:
> On Sun, 08 Feb 2004 14:16:17 -0500 Matthew Caron <matt@mattcaron.net> wrote:
> 
> | PROBLEM 1:
> | 
> | 1. Summary:
> | 	mkinitrd fails during make install (2.6.1)
> | 
> | 2. Description:
> | 	mkinitrd fails with error:
> | 
> | No module 3w-xxxx found for kernel 2.6.1
> | mkinitrd failed
> | make[1]: *** [install] Error 1
> | make: *** [install] Error 2
> | 
> | config command was: 'make xconfig'
> | build command was: 'make clean modules_install install'

> | PROBLEM 2:
> | 
> | 1. Summary:
> | 	first network connect fails after boot
> | 
> | 2. Description:
> | 	The first connection to any host on any port fails after boot/reboot. 
> | Subsequent connects work fine. Typical errors are:
> | 
> | ssh: connect to host foobar port 22: Resource temporarily unavailable
> | 
> | Firebird reports "Document Contains No Data"


-- 
Freedom to learn, freedom to share,
freedom to change, freedom to improve.
Free Software: it's about Freedom.
--------------------------------------------------------------------
PGP Key: http://www.mattcaron.net/pgp_key.txt
  ~~ Matt Caron ~~

