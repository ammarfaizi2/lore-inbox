Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWGKQ27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWGKQ27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWGKQ27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:28:59 -0400
Received: from canuck.infradead.org ([205.233.218.70]:27617 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750764AbWGKQ26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:28:58 -0400
Subject: Re: RFC: cleaning up the in-kernel headers
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
In-Reply-To: <20060711160639.GY13938@stusta.de>
References: <20060711160639.GY13938@stusta.de>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 17:28:43 +0100
Message-Id: <1152635323.3373.211.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 18:06 +0200, Adrian Bunk wrote:
> I'd like to cleanup the mess of the in-kernel headers, based on the 
> following rules:
> - every header should #include everything it uses
> - remove unneeded #include's from headers
> 
> This would also remove all the implicit rules "before #include'ing 
> header foo.h, you must #include header bar.h" you usually only see
> when the compilation fails.
> 
> There might be exceptions (e.g. for avoiding circular #include's) but 
> these would be special cases.

Seems eminently sensible. Please make sure you don't introduce
regressions in the output of 'make headers_install' by unconditionally
including files which don't exist in the export -- if something is only
_used_ within #ifdef __KERNEL__ then it should only be #included within
#ifdef __KERNEL__ too.

It would be nice in the general case if we could actually _compile_ each
header file, standalone. There may be some cases where that doesn't
work, but it's a useful goal in most cases, for bother exported headers
_and_ the in-kernel version. For the former case it would be nice to add
it to 'make headers_check' once it's realistic to do so.

I still think it would be quite nice if we could _eliminate_ some of
those ifdefs, to be honest -- but I'm not overly bothered about that
now, because 'make headers_install' works well enough.

-- 
dwmw2

