Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWEHDHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWEHDHL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 23:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWEHDHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 23:07:11 -0400
Received: from waste.org ([64.81.244.121]:26064 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932265AbWEHDHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 23:07:10 -0400
Date: Sun, 7 May 2006 22:02:16 -0500
From: Matt Mackall <mpm@selenic.com>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Small patch to bloat-o-meter.
Message-ID: <20060508030216.GR15445@waste.org>
References: <200605071559.00253.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605071559.00253.rob@landley.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2006 at 03:59:00PM -0400, Rob Landley wrote:
> Workaround for the fact that gcc 4.x no longer provides consistent names for 
> static symbols.
> 
> Signed-off-by: Rob Landley <rob@landley.net>
> ---
> 
> When I added bloat-o-meter to busybox, I had to fix this to get useful 
> results.  Since the kernel version seems to be the master, I thought you 
> might be interested.
> 
> --- linux-old/scripts/bloat-o-meter	2006-05-07 15:47:23.000000000 -0400
> +++ linux-2.6.16/scripts/bloat-o-meter	2006-05-07 15:08:31.000000000 -0400
> @@ -18,7 +18,9 @@
>      for l in os.popen("nm --size-sort " + file).readlines():
>          size, type, name = l[:-1].split()
>          if type in "tTdDbB":
> -            sym[name] = int(size, 16)
> +            if name.find(".") != -1: name = "static." + name.split(".")[0]

if "." in name:

(just like 'if type in "tTdDbB":' above it)

> +            if name in sym: sym[name] += int(size, 16)
> +            else :sym[name] = int(size, 16)

else:

Actually, this probably wants to be:

sym.setdefault(name, 0) += int(size, 16)

-- 
Mathematics is the supreme nostalgia of our time.
