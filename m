Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289577AbSAVX7z>; Tue, 22 Jan 2002 18:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289585AbSAVX7p>; Tue, 22 Jan 2002 18:59:45 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:59635 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S289577AbSAVX7b>; Tue, 22 Jan 2002 18:59:31 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200201222237.g0MMb7a17456@enterprise.bidmc.harvard.edu> 
In-Reply-To: <200201222237.g0MMb7a17456@enterprise.bidmc.harvard.edu>  <200201222216.g0MMGj317058@enterprise.bidmc.harvard.edu> <3C4DE863.6E486FA5@mandrakesoft.com> 
To: "Kristofer T. Karas" <ktk@bigfoot.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [Patch - 2.4.17++] Fix undefined ksym in minix.o, ext2.o, sysv.o 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Jan 2002 23:58:53 +0000
Message-ID: <8704.1011743933@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ktk@bigfoot.com said:
> Fair enough.  A "grep -r" showed it existing only in ./fs/ and only
> ref'd by  ext2, sysv and minix; so I figured a conditional wrap-around
> wouldn't hurt.   But I didn't stop to consider 3rd party modules... 

It's not just third-party modules. Even the modules in the tree get bitten 
by such brokenness - consider what happens if you compile your kernel 
without support for the filesystem in question but later need to compile 
the module. With the #ifdef there, you'd need to recompile (and reboot) the 
whole thing.

Anything in the kernel image which is dependent on CONFIG_*_MODULE is, as a 
general rule, broken. Sometimes there are justifications for it. Not often, 
though.

--
dwmw2


