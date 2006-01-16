Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWAPCKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWAPCKL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 21:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWAPCKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 21:10:10 -0500
Received: from main.gmane.org ([80.91.229.2]:56707 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932167AbWAPCKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 21:10:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [PATCH 2/2] kbuild: fix make -jN with multiple targets with make
 O=...
Date: Mon, 16 Jan 2006 11:09:51 +0900
Message-ID: <dqev9f$pnc$1@sea.gmane.org>
References: <20060115212602.GB26627@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060115)
In-Reply-To: <20060115212602.GB26627@mars.ravnborg.org>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> [It is pushed out at:
> git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git]
> 
> The way multiple targets was handled with make O=...
> broke because for each high-level target make spawned
> a parallel make resulting in a broken build.
> Reported by Keith Owens <kaos@ocs.com.au>

When did it break? Are any of the released (not -git) kernels affected?

> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> ---
> 
>  Makefile |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> 296e0855b0f9a4ec9be17106ac541745a55b2ce1
> diff --git a/Makefile b/Makefile
> index deedaf7..b3dd9db 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -106,12 +106,13 @@ KBUILD_OUTPUT := $(shell cd $(KBUILD_OUT
>  $(if $(KBUILD_OUTPUT),, \
>       $(error output directory "$(saved-output)" does not exist))
>  
> -.PHONY: $(MAKECMDGOALS)
> +.PHONY: $(MAKECMDGOALS) cdbuilddir
> +$(MAKECMDGOALS) _all: cdbuilddir
>  
> -$(filter-out _all,$(MAKECMDGOALS)) _all:
> +cdbuilddir:
>  	$(if $(KBUILD_VERBOSE:1=),@)$(MAKE) -C $(KBUILD_OUTPUT) \
>  	KBUILD_SRC=$(CURDIR) \
> -	KBUILD_EXTMOD="$(KBUILD_EXTMOD)" -f $(CURDIR)/Makefile $@
> +	KBUILD_EXTMOD="$(KBUILD_EXTMOD)" -f $(CURDIR)/Makefile $(MAKECMDGOALS)
>  
>  # Leave processing to above invocation of make
>  skip-makefile := 1

Kalin.
-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

