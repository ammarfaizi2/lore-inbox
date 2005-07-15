Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVGOVYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVGOVYk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 17:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVGOVYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 17:24:39 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:48349 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261215AbVGOVYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 17:24:39 -0400
Date: Fri, 15 Jul 2005 14:24:32 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       stable@kernel.org
Subject: Re: [PATCH 2.6.13-rc3] kbuild: When checking depmod version,
 redirect stderr
Message-Id: <20050715142432.15f6752b.rdunlap@xenotime.net>
In-Reply-To: <20050715145636.GU7741@smtp.west.cox.net>
References: <20050715145636.GU7741@smtp.west.cox.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005 07:56:36 -0700 Tom Rini wrote:

> When running depmod to check for the correct version number, extra
> output we don't need to see, such as "depmod: QM_MODULES: Function not
> implemented" may show up.  Redirect stderr to /dev/null as the version
> information that we do care about comes to stdout.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> 
> diff --git a/Makefile b/Makefile
> --- a/Makefile
> +++ b/Makefile
> @@ -875,7 +875,7 @@ modules_install: _modinst_ _modinst_post
>  
>  .PHONY: _modinst_
>  _modinst_:
> -	@if [ -z "`$(DEPMOD) -V | grep module-init-tools`" ]; then \
> +	@if [ -z "`$(DEPMOD) -V 2>/dev/null | grep module-init-tools`" ]; then \
>  		echo "Warning: you may need to install module-init-tools"; \
>  		echo "See http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt";\
>  		sleep 1; \

Well, seeing "QM_MODULES" is a great indicator that someone is using
modutils instead of module-init-tools, so I'd like to see it stay.
IOW, I somewhat disagree with "extra output we don't need to see."

---
~Randy
