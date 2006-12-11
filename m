Return-Path: <linux-kernel-owner+w=401wt.eu-S937425AbWLKSEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937425AbWLKSEJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937426AbWLKSEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:04:09 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:60010 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937425AbWLKSEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:04:06 -0500
Date: Mon, 11 Dec 2006 19:04:14 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, Herbert Poetzl <herbert@13thfloor.at>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
Message-ID: <20061211180414.GA18833@aepfle.de>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, Linus Torvalds wrote:

> +static char __initdata linux_banner[] =
> +	"Linux version " UTS_RELEASE
> +	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
> +	" (" LINUX_COMPILER ")"
> +	" " UTS_VERSION "\n";

main.o gets linked after misc.o, so this will not work. Having both as
globals in the same c file in the right order, that will probably fix
it. Let my try.

strings ../O-maple_defconfig/vmlinux | grep -w Linux
Starting Linux PPC64 %s
Linux
Linux version %s (olaf@g5) (gcc version 4.1.0 (SUSE Linux)) %s
<6>%s: device enabled (Linux)
Linux version 2.6.19-g9202f325-dirty (olaf@g5) (gcc version 4.1.0 (SUSE Linux)) #3 SMP Mon Dec 11 18:59:15 CET 2006
Linux
Linux
Linux


