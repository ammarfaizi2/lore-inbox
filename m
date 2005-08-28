Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbVH1BTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbVH1BTj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 21:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbVH1BTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 21:19:39 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:27769 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751020AbVH1BTh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 21:19:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aE2UmQe7BrSMC3Q4UELLKuy6Wyjnw/8qX4XdbiwIM/TpzTlKho5eAIc8o+j3CNtXawgmB73LV5s18FfpHp8Rfnkm5ncdEHlplF2kNHst/HVV7jyUBaPZDgdMrYViWE3P0JFvBtfXYwMZJZ4LAyo8RFDrSloHw6xWesI+NqaEk9c=
Message-ID: <88ee31b70508271819610af2ea@mail.gmail.com>
Date: Sun, 28 Aug 2005 10:19:34 +0900
From: Jerome Pinot <ngc891@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [KCONFIG] Can't compile 2.6.12 without Gettext
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050827174934.GL6471@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <88ee31b705082421303697aef7@mail.gmail.com>
	 <20050827124751.GK6471@stusta.de>
	 <88ee31b7050827082345a393bd@mail.gmail.com>
	 <20050827174934.GL6471@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/05, Adrian Bunk <bunk@stusta.de> wrote:
[...]
> You said "full gettext" was required and that the presence of "gettext
> binaries" should be checked what surprised me. It seems this is not the
> problem. Under Linux, libintl.h is not shipped with gettext but with the
> C library if you are using glibc or dietlibc.

I said the libintl.h file didn't solve the problem
 
> I do not question your point that "uClibc is widely used", but it's
> widely used to _run_ a Linux kernel.
> You said you are "thinking about small or embedded system with specific
> toolchain". If a system is so limited that you run uClibc on it, is this
> really the right system to _compile_ a kernel on? Where's the problem
> with cross-compiling the kernel for such a system?

You need the libc headers, to compile a kernel.
If you want to really work cleanly, i.e. be as much independant of the
host system as possible, you will not compile on another system, or
even use a cross-compiler, but use your own environnement system in
chroot. Everything in your system should have been built with the same
toolchain.

The LFS project shown very nice informations about this 1 or 2 years
ago. They still found bytes of the host system in the final build
binaries (sorry, can't find back the mail with figures). They had to
change completly the way of doing the toolchain. You can check the
beginning of chapter 5 from current book for more informations.

Shall every toolchain have gettext?
I don't think so. Sometimes, you just don't need all the nls bloat.

Moreover, Kconfig should check before trying to compile. It could be a
nasty way to introduce "some code" to the build program. Hum.

Anyway, there is no need of this kind of dependency to actually
compile the kernel. I still could use gcc in the source tree to get my
binaries.

The rationnal way should be to check for correct nls implementation
and just not use it if it's missing. It's a matter of adding 2 #define
in the code and add a proper test.

I don't understand why gettext must be _required_

-- 
Jerome Pinot
ftp://ngc891.blogdns.net/pub
