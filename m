Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313327AbSDGO2u>; Sun, 7 Apr 2002 10:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313328AbSDGO2t>; Sun, 7 Apr 2002 10:28:49 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:24077 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313327AbSDGO2s>;
	Sun, 7 Apr 2002 10:28:48 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available 
In-Reply-To: Your message of "Sun, 07 Apr 2002 16:18:12 +0200."
             <3CB05524.4643C805@linux-m68k.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Apr 2002 00:28:32 +1000
Message-ID: <28682.1018189712@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Apr 2002 16:18:12 +0200, 
Roman Zippel <zippel@linux-m68k.org> wrote:
>Keith Owens wrote:
>
>> kbuild 2.5:
>>   make -j8 oldconfig installable 8:51 (no make dep needed :)
>>   make -j8 oldconfig installable  :14 (second run, no changes)
>
>These 14 seconds (or 37 seconds on my machine) are always needed
>whatever I try, e.g. "make foo/bar.o" also needs that time.

make NO_MAKEFILE_GEN=1 foo/bar.o.  Very low overhead for quick and
dirty testing of changes, but if you want an accurate kernel build, you
have to take the overhead.  kbuild 2.4 overhead for a full build when
only minor changes have been made is even worse.

>Some other problems:
>"make foo/bar.[si]" doesn't work anymore.

Hmm, that was working, I will investigate.

>"touch include/linux/mm.h" doesn't cause a recompile of any object.

I have found some cases where the timestamps are not tracked correctly
so changes to dependencies are not always detected.  Fixed in
build-2.5-core-2, out tomorrow.

