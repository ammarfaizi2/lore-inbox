Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751807AbWHATJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbWHATJP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWHATJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:09:14 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:63458 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751810AbWHATJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:09:12 -0400
Date: Tue, 1 Aug 2006 21:08:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 4/33] i386: CONFIG_PHYSICAL_START cleanup
Message-ID: <20060801190838.GB12573@mars.ravnborg.org>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <11544302312298-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11544302312298-git-send-email-ebiederm@xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 05:03:19AM -0600, Eric W. Biederman wrote:
> Defining __PHYSICAL_START and __KERNEL_START in asm-i386/page.h works but
> it triggers a full kernel rebuild for the silliest of reasons.  This
> modifies the users to directly use CONFIG_PHYSICAL_START and linux/config.h
> which prevents the full rebuild problem, which makes the code much
> more maintainer and hopefully user friendly.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  arch/i386/boot/compressed/head.S |    8 ++++----
>  arch/i386/boot/compressed/misc.c |    8 ++++----
>  arch/i386/kernel/vmlinux.lds.S   |    3 ++-
>  include/asm-i386/page.h          |    3 ---
>  4 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/i386/boot/compressed/head.S b/arch/i386/boot/compressed/head.S
> index b5893e4..8f28ecd 100644
> --- a/arch/i386/boot/compressed/head.S
> +++ b/arch/i386/boot/compressed/head.S
> @@ -23,9 +23,9 @@
>   */
>  .text
>  
> +#include <linux/config.h>

You already have full access to all CONFIG_* symbols - kbuild includes
it on the commandline. So please kill this include.

	Sam
