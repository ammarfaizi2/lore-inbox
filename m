Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbVLIWiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVLIWiA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVLIWiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:38:00 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:12480 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S932482AbVLIWh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:37:59 -0500
Message-ID: <439A0746.80208@mnsu.edu>
Date: Fri, 09 Dec 2005 16:37:58 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
References: <1134154208.14363.8.camel@mindpipe>
In-Reply-To: <1134154208.14363.8.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>I'm trying to build an x66-64 kernel on a 32 bit system (Ubuntu 5.10).
>I added -m64 to the CFLAGS as per the gcc docs.  But the build fails
>with:
>
>$ make ARCH=x86_64
>  [...]
>  CC      init/initramfs.o
> 
>

I have successfully done this using Debian/Sid.

1. I changed the linux/Makefile:
ARCH            ?= x86_64
CROSS_COMPILE   ?= x86_x64-linux-

2. The I changed the path to include the following /tmp/lin64/ directory:
PATH=/tmp/lin64:$PATH

3. I made a bunch of scripts as follows all in the /tmp/lin64/ directory:
x86_x64-linux-ar:
#!/bin/bash
ar $@

x86_x64-linux-gcc:
#!/bin/bash
has32=`echo "$@" | grep -- "-m32"`
if [ "$has32" = "" ] ; then
        gcc -m64 $@
else
        gcc $@
fi

x86_x64-linux-ld:
#!/bin/bash
ld -m64 $@

x86_x64-linux-nm:
#!/bin/bash
nm $@

x86_x64-linux-objcopy:
#!/bin/bash
objcopy $@

