Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWGLSz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWGLSz5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWGLSz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:55:57 -0400
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63]:28283 "HELO
	smtp009.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750741AbWGLSz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:55:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=gf5tbk8P8myrjykSd/THw69vnq4DqoQX3uF6tG+8mSh3/DhP8E4oPtx5KTh1cYXHVa31lx+6zIetPPYf5h5iW4vXZTJLk95t/vCcypJyb6IROIOMMWDJ2PgVVaF1hZO+3ihlOumxeLWDy4+hTC3Q4EkBCrA3ZRMFxhTeWjKyqg0=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 4/5] UML - Reenable SysRq support
Date: Wed, 12 Jul 2006 20:56:00 +0200
User-Agent: KMail/1.9.1
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200607121640.k6CGe6nP021236@ccure.user-mode-linux.org>
In-Reply-To: <200607121640.k6CGe6nP021236@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607122056.01202.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 July 2006 18:40, Jeff Dike wrote:
> Sysrq works fine on UML.
>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>
> Index: linux-2.6.17/lib/Kconfig.debug
> ===================================================================
> --- linux-2.6.17.orig/lib/Kconfig.debug	2006-07-12 11:26:41.000000000 -0400
> +++ linux-2.6.17/lib/Kconfig.debug	2006-07-12 11:33:02.000000000 -0400
> @@ -18,7 +18,6 @@ config ENABLE_MUST_CHECK
>
>  config MAGIC_SYSRQ
>  	bool "Magic SysRq key"
> -	depends on !UML
>  	help
>  	  If you say Y here, you will have some control over the system even
>  	  if the system crashes for example during kernel debugging (e.g., you
Please reject this patch, the setting for UML is just elsewhere, in 
arch/um/Kconfig (and depends on MCONSOLE).

If kbuild doesn't handle well having an option declared twice now (it isn't 
very happy but it worked when I added the above dependency) we can rename the 
one in arch/um/Kconfig to MAGIC_SYSRQ_UML and make the one above like this 
(untested):

config MAGIC_SYSRQ
	bool
	prompt "Magic SysRq key" if !UML
	depends on MAGIC_SYSRQ_UML || !UML
	default y if UML

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
