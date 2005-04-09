Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVDIUSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVDIUSd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 16:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVDIUSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 16:18:33 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:57545 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261380AbVDIUS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 16:18:28 -0400
Date: Sat, 9 Apr 2005 22:18:25 +0200
From: David Weinehall <tao@acc.umu.se>
To: linux-kernel@vger.kernel.org, Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: patch to fix bashism
Message-ID: <20050409201825.GF7969@khan.acc.umu.se>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Martin Schlemmer <azarah@nosferatu.za.org>
References: <20050408211200.GX15412@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408211200.GX15412@boetes.org>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 11:11:38PM +0159, Han Boetes wrote:
> Hi,
> 
> This patch fixes a three bashisms in
> scripts/gen_initramfs_list.sh;
> 
> I'm not sure of the intention of the second change (local
> name=...). So it's very well possible that:
> 
> +       local name="${location%/$srcdir}"
> 
> is more appropriate.

This patch is not going to work; local is a bash:ism too, hence this
will fail when /bin/sh is a more strict POSIX-shell.  However,
it is quite likely that the use of local is merely due to the
(totally correct) instinct of always limiting the scope of variables.
Most scripts that I've POSIX-fixed so far could just have the local
removed with no bad effects.

> --- scripts/gen_initramfs_list.sh.orig	2005-03-27 14:53:15.628883408 +0200
> +++ scripts/gen_initramfs_list.sh	2005-03-27 15:12:20.093898280 +0200
> @@ -1,4 +1,7 @@
> -#!/bin/bash
> +#!/bin/sh
> +
> +# script is sourced, the shebang is ignored.
> +
>  # Copyright (C) Martin Schlemmer <azarah@nosferatu.za.org>
>  # Released under the terms of the GNU GPL
>  #
> @@ -56,9 +59,9 @@
>  
>  parse() {
>  	local location="$1"
> -	local name="${location/${srcdir}//}"
> +	local name="${location#$srcdir/}"
>  	# change '//' into '/'
> -	name="${name//\/\///}"
> +	name=`echo $name|sed -e 's|//|/|g'`

Using $(...) instead of `...` helps readability quite a lot for
things like this...

[snip]


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
