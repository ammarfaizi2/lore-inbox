Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbVJYW71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVJYW71 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVJYW71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:59:27 -0400
Received: from host-84-9-201-132.bulldogdsl.com ([84.9.201.132]:3459 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932464AbVJYW71
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:59:27 -0400
Date: Tue, 25 Oct 2005 23:58:15 +0100
From: Ben Dooks <ben@fluff.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sharp zaurus: prevent killing spitz-en
Message-ID: <20051025225815.GA31679@home.fluff.org>
References: <20051025190829.GA1788@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051025190829.GA1788@elf.ucw.cz>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2005 at 09:08:29PM +0200, Pavel Machek wrote:
> Hi!
> 
> This is wrong solution, but it prevents breaking flashing mechanism on
> spitz with too big kernel. It may be handy to someone...
> 
> 								Pavel
> 
> --- clean-rp/arch/arm/boot/Makefile	2004-12-25 13:34:57.000000000 +0100
> +++ linux-rp/arch/arm/boot/Makefile	2005-10-25 20:43:58.000000000 +0200
> @@ -53,6 +53,12 @@
>  $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
>  	$(call if_changed,objcopy)
>  	@echo '  Kernel: $@ is ready'
> +	@ls -al $@
> +	@wc -c $@ | ( read SIZE Y; \
> +		if [ $$SIZE -gt 1294336 ]; then \
> +			echo '  Kernel is too big, would kill spitz'; \
> +			rm $@; \
> +		fi )
>  
>  endif

It would be better for each machine to export an config option
from the Kconfig to specify if they have a maximum size.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
