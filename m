Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWHCUZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWHCUZr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWHCUZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:25:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38160 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964882AbWHCUZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:25:46 -0400
Date: Thu, 3 Aug 2006 22:25:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
       Zachary Amsden <zach@vmware.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       v4l-dvb-maintainer@linuxtv.org, linux-acpi@vger.kernel.org
Subject: Options depending on STANDALONE
Message-ID: <20060803202543.GH25692@stusta.de>
References: <44D1CC7D.4010600@vmware.com> <1154603822.2965.18.camel@laptopd505.fenrus.org> <44D23B84.6090605@vmware.com> <20060803190327.GA14237@kroah.com> <44D24B31.2080802@vmware.com> <20060803193600.GA14858@kroah.com> <20060803195617.GD16927@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803195617.GD16927@redhat.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 03:56:17PM -0400, Dave Jones wrote:
> On Thu, Aug 03, 2006 at 12:36:00PM -0700, Greg Kroah-Hartman wrote:
> 
>  > > That is good to know.  But there is a kernel option which doesn't make 
>  > > much sense in that case:
>  > > 
>  > > [*] Select only drivers that don't need compile-time external firmware
>  > 
>  > No, that is very different.  That option is present if you don't want to
>  > build some firmware images from the source that is present in the kernel
>  > tree, and instead, use the pre-built stuff that is also present in the
>  > kernel tree.
> 
> You're describing PREVENT_FIRMWARE_BUILD.  The text Zach quoted is from
> STANDALONE, which is something else completely.  That allows us to not
> build drivers that pull in things from /etc and the like during compile.
> (Whoever thought that was a good idea?)

We should also look at what drivers do depend on STANDALONE:
- some OSS drivers
- one DVB driver option (DVB_AV7110_FIRMWARE)
- ACPI_CUSTOM_DSDT

The OSS drivers are more or less RIP, so let's ignore them.

Is DVB_AV7110_FIRMWARE really still required?
ALL other drivers work without such an option.

ACPI_CUSTOM_DSDT seems to be the most interesting case.
It's anyway not usable for distribution kernels, and AFAIR the ACPI 
people prefer to get the kernel working with all original DSDTs
(which usually work with at least one other OS) than letting the people 
workaround the problem by using a custom DSDT.

It might therefore be possile simply getting rid of CONFIG_STANDALONE?

> 		Dave

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

