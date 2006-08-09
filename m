Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030565AbWHIHFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030565AbWHIHFI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 03:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030567AbWHIHFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 03:05:08 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:44169 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030565AbWHIHFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 03:05:06 -0400
Subject: Re: [PATCH] CONFIG_RELOCATABLE modpost fix
From: Magnus Damm <magnus@valinux.co.jp>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       ebiederm@xmission.com
In-Reply-To: <20060809062918.GA10903@mars.ravnborg.org>
References: <20060808083307.391.45887.sendpatchset@cherry.local>
	 <20060808183954.GA8300@mars.ravnborg.org>
	 <1155087156.4341.66.camel@localhost>
	 <20060809062918.GA10903@mars.ravnborg.org>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 16:06:38 +0900
Message-Id: <1155107198.4341.87.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 08:29 +0200, Sam Ravnborg wrote:
> On Wed, Aug 09, 2006 at 10:32:36AM +0900, Magnus Damm wrote:
>  
> > Your patch seems to work as expected if I add a return 0 at the end of
> > modpost.c:secref_whitelist(). I like how you printed out the number of
> > modules being processed.
> Thanks - fixed now. My gcc (3.4.6-r1 from Gentoo did not warn)

Interesting. I have the 3.4.6-r1 ebuild installed too, but I happened to
have the 3.3.6 profile selected by default. Which explains why things
still work as expected here.

> >I have one minor comment about your patch:
> > 
> > Modpost seems to get run twice on vmlinux if the kernel is built with
> > "make all". I think it would be best to run modpost on vmlinux only when
> > vmlinux is built - never when modules are processed.
> 
> Thesecond time modpost runs vmlinux is used to pick up symbol
> information to check that all symbols are valid etc.
> The alternative was to trust the symbols being read from Module.symvers
> and that would be OK in most cases but I could imagine situations where
> Module.symvers was deleted but vmlinux kept.
> 
> So therefore the more expensive solution to run modpost twice on vmlinux
> was chosen.

I understand. I'm not that worried about build performance, more the
fact that all the warnings from vmlinux will get spit out twice.

Thanks,

/ magnus

