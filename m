Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVL2RAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVL2RAF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 12:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbVL2RAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 12:00:04 -0500
Received: from quark.didntduck.org ([69.55.226.66]:9623 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1750867AbVL2RAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 12:00:03 -0500
Message-ID: <43B41639.6060301@didntduck.org>
Date: Thu, 29 Dec 2005 12:00:41 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Split out screen_info from tty.h
References: <200512291639.jBTGdfLZ015516@laptop11.inf.utfsm.cl>
In-Reply-To: <200512291639.jBTGdfLZ015516@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Brian Gerst <bgerst@didntduck.org> wrote:
>> This makes it possible for boot code to use screen_info without dragging in
>> all of tty.h.
> 
> Why is that a problem? Introducing yet another .h that developers have to
> remember and use appropiately has a cost, so... and I see no changes except
> for different #include lines in your patch.

x86_64 carried a copy of screen_info in miscsetup.h which was out of
date with the master copy in tty.h.  It couldn't include the full tty.h
because it is compiling in 32-bit mode (causes warnings from unrelated
junk in tty.h).  Splitting it out means that x86_64 can get the bare
minimum it needs to compile the boot loader while having the definition
in one place.

--
				Brian Gerst
