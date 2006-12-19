Return-Path: <linux-kernel-owner+w=401wt.eu-S932778AbWLSUVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbWLSUVj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 15:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932859AbWLSUVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 15:21:39 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60067 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932778AbWLSUVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 15:21:38 -0500
Date: Tue, 19 Dec 2006 12:21:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Mike Frysinger" <vapier.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] search a little harder for mkimage
Message-Id: <20061219122135.8100b198.akpm@osdl.org>
In-Reply-To: <8bd0f97a0612182120q30361eceq6219b509f8add29a@mail.gmail.com>
References: <8bd0f97a0612182120q30361eceq6219b509f8add29a@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 00:20:42 -0500
"Mike Frysinger" <vapier.adi@gmail.com> wrote:

> this small patch checks to see if `${CROSS_COMPILE}mkimage` exists and
> if not, fall back to the standard `mkimage`
> 
> the Blackfin toolchain includes mkimage, but we dont want to namespace
> collide with any of the user's system setup, so we prefix it with our
> toolchain name
> -mike
> 
> 
> [check-cross-compile-mkimage.patch  text/x-patch (708B)]
> Check to see if the mkimage tool is part of the cross-compile toolchain.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> 
> --- a/linux-2.6/scripts/mkuboot.sh
> +++ b/linux-2.6/scripts/mkuboot.sh
> @@ -4,12 +4,15 @@
>  # Build U-Boot image when `mkimage' tool is available.
>  #
>  
> -MKIMAGE=$(type -path mkimage)
> +MKIMAGE=$(type -path ${CROSS_COMPILE}mkimage)

Do all bash versions support `type -path'?

Perhaps /usr/bin/which would be safer, dunno.

