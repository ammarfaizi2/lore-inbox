Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030519AbWHIG3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030519AbWHIG3i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030543AbWHIG3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:29:37 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:47824 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030519AbWHIG3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:29:37 -0400
Date: Wed, 9 Aug 2006 08:29:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       ebiederm@xmission.com
Subject: Re: [PATCH] CONFIG_RELOCATABLE modpost fix
Message-ID: <20060809062918.GA10903@mars.ravnborg.org>
References: <20060808083307.391.45887.sendpatchset@cherry.local> <20060808183954.GA8300@mars.ravnborg.org> <1155087156.4341.66.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155087156.4341.66.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 10:32:36AM +0900, Magnus Damm wrote:
 
> Your patch seems to work as expected if I add a return 0 at the end of
> modpost.c:secref_whitelist(). I like how you printed out the number of
> modules being processed.
Thanks - fixed now. My gcc (3.4.6-r1 from Gentoo did not warn)

>I have one minor comment about your patch:
> 
> Modpost seems to get run twice on vmlinux if the kernel is built with
> "make all". I think it would be best to run modpost on vmlinux only when
> vmlinux is built - never when modules are processed.

Thesecond time modpost runs vmlinux is used to pick up symbol
information to check that all symbols are valid etc.
The alternative was to trust the symbols being read from Module.symvers
and that would be OK in most cases but I could imagine situations where
Module.symvers was deleted but vmlinux kept.

So therefore the more expensive solution to run modpost twice on vmlinux
was chosen.

	Sam
