Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKYC3P>; Fri, 24 Nov 2000 21:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129153AbQKYC2z>; Fri, 24 Nov 2000 21:28:55 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:58891 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S129091AbQKYC2o>;
        Fri, 24 Nov 2000 21:28:44 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: ebiederm@xmission.com (Eric W. Biederman)
cc: linux-kernel@vger.kernel.org, "Matt D. Robinson" <yakker@alacritech.com>
Subject: Re: LKCD from SGI 
In-Reply-To: Your message of "24 Nov 2000 16:40:50 PDT."
             <m1ofz5vszh.fsf@frodo.biederman.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 25 Nov 2000 12:58:37 +1100
Message-ID: <5009.975117517@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Nov 2000 16:40:50 -0700, 
ebiederm@xmission.com (Eric W. Biederman) wrote:
>Peter Samuelson <peter@cadcamlab.org> writes:
>
>> [Matt D. Robinson]
>> > Any way we can standardize 'make install' in the kernel?  It's
>> > disturbing to have different install mechanisms per platform ...
>> > I can make the changes for a few platforms.
>> 
>> 2.5 material, already on the todo list.
>
>What is the thought on this.  There is an issue with different
>boot loaders needing rather dramatically different formats...

2.5 kernel build wish list[1] has a couple of entries for standardising
the install targets.  My thinking (and I know that some people disagree
with this) is that the standard targets of a linux compile are only

* vmlinux
* System.map
* modules in the kernel tree (not installed yet)
* any other bits and pieces that are required to compile external
  modules against this config.

The install phases are many and varied, depending on whether you are
installing on this machine, on another machine, does your boot loader
understand ELF, do you have to do the [b]zImage fiddling first, are you
doing a network boot from ROM, a network boot over tftp etc.

In current kernels the install phases are mixed in with the compile
phase which makes it difficult to handle different install targets.
2.5 will have a default make target which does the compile phase but
does nothing that is install related, i.e. default is no [b]zImage, no
modules_install etc.  There will be separate install targets for any
combination that is required and for which people can be bothered
writing the make scripts.

[1] ftp://ftp.<country>.kernel.org/pub/linux/kernel/projects/kbuild/makefile-wishlist-2.5-...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
