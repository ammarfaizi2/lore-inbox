Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVLMC6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVLMC6G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 21:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVLMC6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 21:58:05 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:48968 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932364AbVLMC6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 21:58:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gBtvOljf11ItuK1iBP6Hr25oV5yNewxkXheejanirw2IfQvPyocBxmnZsLZdlAMROSgE8w0PkkTdDRg24eXsF5c/a9KNesybHSE2uUyNFpeGXVZAgFANpbLZfcVtonPuEEdxYW5BdOvI/d6beDyefAlCneMUgEm0lyjcixUF7LU=
From: Kurt Wall <kwallinator@gmail.com>
To: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 3/3] [kconfig] Direct use of lxdialog routines by menuconfig
Date: Mon, 12 Dec 2005 21:59:03 -0500
User-Agent: KMail/1.8.2
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org, sam@ravnborg.org,
       kbuild-devel@lists.sourceforge.net
References: <20051212004159.31263.89669.stgit@machine.or.cz> <200512112218.27286.kwallinator@gmail.com> <20051212112033.GB8025@pasky.or.cz>
In-Reply-To: <20051212112033.GB8025@pasky.or.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512122159.03296.kwallinator@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 December 2005 06:20 am, Petr Baudis wrote:
> Dear diary, on Mon, Dec 12, 2005 at 04:18:26AM CET, I got a letter
> where Kurt Wall <kwallinator@gmail.com> said that...
>

[...]

> > > +     submenu->data = (void *) !submenu->data;
> >
> > Shouldn't this be:
> >      submenu->data = (void *) (long) !submenu->data;
>
> You are right, it should be so at least for consistency - it'll be fixed
> in the next resend of the patch. I can't see why is it needed, though -
> shouldn't the int be padded to void* anyway?

The cast to long quiets a warning from gcc. Without the cast, it
complains:

$ make menuconfig
  HOSTCC  scripts/kconfig/mconf.o
scripts/kconfig/mconf.c: In function `conf':
scripts/kconfig/mconf.c:699: warning: cast to pointer from integer of 
different size
  HOSTLD  scripts/kconfig/mconf
scripts/kconfig/mconf arch/x86_64/Kconfig

I like the changes, though -- menuconfig is much snappier and easier on
the eyes without the nasty flashing.

Kurt
-- 
"I'd love to go out with you, but it's my parakeet's bowling night."
