Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbQLOVDc>; Fri, 15 Dec 2000 16:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131409AbQLOVDW>; Fri, 15 Dec 2000 16:03:22 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:40453 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S131244AbQLOVDM>; Fri, 15 Dec 2000 16:03:12 -0500
Message-ID: <3A3A7F25.2050203@redhat.com>
Date: Fri, 15 Dec 2000 14:29:25 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
CC: ferret@phonewave.net, Alexander Viro <viro@math.psu.edu>,
        LA Walsh <law@sgi.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
In-Reply-To: <20001215152137.K599@almesberger.net> <Pine.LNX.3.96.1001215090857.16439A-100000@tarot.mentasm.org> <20001215184644.R573@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My solution to this has always been to make a cross compiler environment 
(even if it is the same processor family). Thusly i386-linux-gcc knows 
that the target system's include files are in:

/usr/local/<project>-tools/i386-linux/include (/linux, /asm)

The other advantage to this is that I can switch my host environment 
(within reason - compatible host glibcs, ok) and not have to change the 
target compiler.

Werner Almesberger wrote:

> ferret@phonewave.net wrote:
> 
>> Just out of curiosity, what would happen with redirection if your source
>> tree for 'the currently running kernel' version happens to be configured
>> for a different 'the currently running kernel', perhaps a machine of a
>> foreign arch that you are cross-compiling for?
> 
> 
> Two choices:
>  1) try to find an alternative. If there's none, fail.
>  2) make the corresponding asm or asm/arch branch available (non-trivial
>     and maybe not desirable)
> 
> 
>> I do this: I use ONE machine to compile kernels for five: four i386 and
>> one SUN4C. My other machines don't even HAVE /usr/src/linux, so where does
>> this redirection leave them?
> 
> 
> Depends on your distribution: if it doesn't install any kernel-specific
> headers, you wouldn't be able to compile programs requiring anything
> beyond what it provided by your libc. Otherwise, there could be a
> default location (such as /usr/src/linux is a default location now).
> 
> The main advantage of a script would be that one could easily compile
> for multiple kernels, e.g. with
> 
> export TARGET_KERNEL=2.0.4
> make
> 
> Even if your system is running 2.4.13-test1.
> 
> The architecture could be obtained from the tree or the tree could be
> picked based on the architecture. This is a policy decision that could
> be hidden in the script.
> 
> - Werner


-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
