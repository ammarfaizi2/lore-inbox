Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVA3Twf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVA3Twf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 14:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVA3Twf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 14:52:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15771 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261773AbVA3Twb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 14:52:31 -0500
Date: Sun, 30 Jan 2005 19:52:30 +0000
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild: shorthand ym2y, ym2m etc
Message-ID: <20050130195230.GA871@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20050130193733.GA8984@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050130193733.GA8984@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have in several cases the need to transpose a i'm' to 'y' in the Kbuild
> files.
> One example is the following snippet from sound/Makefile:
> ifeq ($(CONFIG_SND),y)
>   obj-y += last.o
> endif
> 
> Alternative syntax could be:
> obj-$(call y2y,CONFIG_SND) += last.o

This should go away with either syntax, and I don't think yours is much
cleaner..

> ifeq ($(CONFIG_FB),y)
>   obj-$(CONFIG_PPC)                 += macmodes.o
> endif
> 
> Altetnative syntax:
> obj-$(call yx2x,CONFIG_FB,CONFIG_PPC) += mcmodes.o

obj-$(CONFIG_FB)$(CONFIG_PPC)		+= macmodes.o

would be a lot more obvious, but I'm not sure how to handle
it for the case where one of them evaluates to m

