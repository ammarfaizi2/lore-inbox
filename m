Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129207AbQKBEvR>; Wed, 1 Nov 2000 23:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129573AbQKBEvI>; Wed, 1 Nov 2000 23:51:08 -0500
Received: from www.wen-online.de ([212.223.88.39]:57362 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129207AbQKBEvC>;
	Wed, 1 Nov 2000 23:51:02 -0500
Date: Thu, 2 Nov 2000 05:50:46 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tom Rini <trini@kernel.crashing.org>,
        "David S. Miller" <davem@redhat.com>, garloff@suse.de,
        jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
In-Reply-To: <3A00B3D6.AC53E32@mandrakesoft.com>
Message-ID: <Pine.Linu.4.10.10011020529050.1061-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Jeff Garzik wrote:

> Alan Cox wrote:
> > Mandrake kgcc I believe is egcs 1.1.2
> 
> Correct...
> 
> Though Richard Henderson's message recent about 'gcc -V ...' not doing
> the right thing has me worried...  egcs 1.1.2 not gcc 2.95.2 is
> definitely being called when '/usr/bin/kgcc' is executed, but I'm still
> worried that some details might be getting lost... 
> http://boudicca.tux.org/hypermail/linux-kernel/2000week44/1069.html

It's best to use a seperate driver for each compiler.  I don't know of
any other way it can bite you, but one way is if you if you have drivers
built with different arch names trying to call the right compiler innards
with -V.  You also need -b archname for it to get it right.

[root]:# gcc -v
Reading specs from /usr/lib/gcc-lib/i586-linux-gnu/gcc-2.95.2/specs
gcc version gcc-2.95.2 19991024 (release)
[root]:# gcc -V 2.8.1 -v
Using builtin specs.  <== danger Will Robinson. (think about includes etc)
gcc driver version gcc-2.95.2 19991024 (release) executing gcc version 2.8.1
[root]:# gcc -V 2.8.1 -b i486-linux-gnu -v
Reading specs from /usr/lib/gcc-lib/i486-linux-gnu/2.8.1/specs
gcc driver version gcc-2.95.2 19991024 (release) executing gcc version 2.8.1

I always diddle Makefile.in to build/install the driver with a non gcc
name for this reason.  Each driver knows where it's innards lives without
needing to be told (and risking me accidentally telling it lies:)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
