Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWDTUyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWDTUyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWDTUyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:54:35 -0400
Received: from canuck.infradead.org ([205.233.218.70]:4309 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751301AbWDTUye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:54:34 -0400
Subject: Re: [RFC: 2.6 patch] let arm use drivers/Kconfig
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <20060420120624.GO25047@stusta.de>
References: <20060417144823.GC7429@stusta.de>
	 <1145285754.13200.15.camel@pmac.infradead.org>
	 <20060420120624.GO25047@stusta.de>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 21:54:11 +0100
Message-Id: <1145566451.11909.111.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 14:06 +0200, Adrian Bunk wrote:
> > This dependency is incorrect. It's only one or two chip-specific drivers
> > which require that the architecture correctly handle alignment traps,
> > and even then it's only actually apparent when used with JFFS2 which
> > actually _gives_ it an unaligned buffer occasionally. Everything else
> > works fine.
>
> Can anyone tell me which chip-specific drivers are affected by this 
> issue so that I can send a patch?

Disabling those chip drivers isn't necessarily the answer, since they
can still be used in most cases; just not for JFFS2. Perhaps we should
just disable JFFS2 if BROKEN_UNALIGNED is set -- or disable JFFS2 on NOR
flash if it's set. 

Get the generic BROKEN_UNALIGNED thing done across all architectures
which need it, and we'll work out precisely where to use it.

-- 
dwmw2

