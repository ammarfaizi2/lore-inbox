Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266916AbSKOWpe>; Fri, 15 Nov 2002 17:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266911AbSKOWpd>; Fri, 15 Nov 2002 17:45:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62469 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266908AbSKOWpZ>;
	Fri, 15 Nov 2002 17:45:25 -0500
Message-ID: <3DD57A84.2070805@pobox.com>
Date: Fri, 15 Nov 2002 17:51:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PARAM 2/4
References: <20021115222725.258EC2C129@lists.samba.org>
In-Reply-To: <20021115222725.258EC2C129@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> Just fixed arch/i386/mach-voyager/setup_arch_pre.h from previous send.
>
> Makes a nice, easy to use, hard to misuse PARAM() macro for modules
> and boot parameters alike.  Implements the types required for current
> kernel usage.
>
> Jeff Garzik doesn't like the name PARAM (I had to rename the
> asm-i386/setup.h PARAM to "PARAMS", but it's only used in that header
> and one other.  I can't think of a better name.  KPARAM seems
> redundant.  MODULE_PARAM is misleading and wrong.


That's only because you never bother with drivers.
_Please_ look at the bigger picture.

1) I note you ignored Matthew Wilcox's example of module_init being used 
in two different ways.

2) "proper", converted-to-Rusty-style driver code is going to have

	MODULE_blah
	MODULE_foo
	MODULE_bar
	PARAM

You think that looks good??

3) modules a.k.a. drivers are going to be the more common users of this 
interface.

4) even where arch code uses boot cmdline params, they are typically 
clustered together, which makes their purpose all the more obvious.



> OTOH, linux/param.h was taken, so I put it in linux/params.h, which is
> pretty sucky.


Another namespace collision?  Who would have thought...

PARAM is ugly in drivers, and way too generic.

	Jeff



