Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUC2VQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUC2VQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:16:45 -0500
Received: from chaos.analogic.com ([204.178.40.224]:35458 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261821AbUC2VQn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:16:43 -0500
Date: Mon, 29 Mar 2004 16:17:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Lev Lvovsky <lists1@sonous.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: older kernels + new glibc?
In-Reply-To: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com>
Message-ID: <Pine.LNX.4.53.0403291602340.2893@chaos>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004, Lev Lvovsky wrote:

> Hello,
>
> I'm not sure what, if any interrelations there are between the various
> versions of glibc, and the kernel.
>
> Specifically, a piece of telecom hardware that we use out in the field
> requires a 2.2.x kernel to compile the drivers, however, after choosing
> an arbitrary "new" release of a linux distro, and downgrading the
> kernel, we are able to compile and install the drivers, and
> subsequently use the hardware.
>
> Are there any URLs/Docs that I could look at to understand what, if any
> relationships glibc, and the kernel have?
>
> thank you!
> -lev

For glibc compatibility you need to get rid of the sym-link(s)
/usr/include/asm and /usr/include/linux in older distributions.
You need to replace those with headers copied from the kernel
in use when the C runtime library was compiled. If you can't find
those, you can either upgrade your C runtime library, or copy
headers from some older kernel that was known to work.

In any event, you need to remove the sym-link that ends up
pointing to your 'latest and greatest' kernel.

If you do this, you should find no incompatibilities between
user-mode code and any (within reason, 0.99 might not work)
kernel version.

Drivers are a different problem. There is no possibility
of just compiling old drivers and having them work. Drivers
need to be modified for each kernel version major version
number and, sometimes, even minor version numbers.

Sometimes you are lucky, usually not. Modules written for
2.4.x will not compile on 2.6.x and there is no compatibility
layer to accommodate. You need to look at how new modules are
written for a new version and modify your module code
accordingly. One can usually just compile and then 'fix' the
resulting errors. However, this might not produce a working
driver because some functions you count on might not exist
anymore. It compiles fine, but won't install.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


