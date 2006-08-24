Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbWHXRZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbWHXRZP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWHXRZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:25:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55481 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030402AbWHXRZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:25:13 -0400
Subject: Re: [OLPC-devel] Re: [PATCH 0/4] Compile kernel with
	-fwhole-program --combine
From: David Woodhouse <dwmw2@infradead.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: devel@laptop.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-tiny@selenic.com, linux-kernel@vger.kernel.org
In-Reply-To: <200608241915.47451.arnd.bergmann@de.ibm.com>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433068.3012.115.camel@pmac.infradead.org>
	 <Pine.LNX.4.61.0608241840440.16422@yvahk01.tjqt.qr>
	 <200608241915.47451.arnd.bergmann@de.ibm.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 18:25:07 +0100
Message-Id: <1156440307.3012.165.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 19:15 +0200, Arnd Bergmann wrote:
> It's probably true, but the way it's done today gave us CONFIG_MODVERSIONS
> and EXPORT_SYMBOL_GPL, which would break when turning EXPORT_SYMBOL into a
> simple __attribute__(). 

ELF can do symbol versioning too. But I don't really see a simple way to
make normal ELF linking work with a kernel like that. The vmlinux ELF
file is long gone by the time the kernel boots -- it needs its own
mechanism for managing its symbols anyway; its own internal dynamic
linker. I suppose you _could_ make it work from the standard ELF linkage
but I don't think it'd be fun.

ObMODVERSIONS: Forgot to mention that my makefile hacks for --combine
break that completely. It tries to preprocess all the files together
with 'gcc -E -D__GENKSYMS__ *.c' -- and you can't do that. 

-- 
dwmw2

