Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758937AbWK2XJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758937AbWK2XJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758940AbWK2XJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:09:28 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:35039 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1758937AbWK2XJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:09:27 -0500
Subject: Re: 2.6.19-rc6-mm2
From: Kay Sievers <kay.sievers@vrfy.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Greg KH <greg@kroah.com>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <456E0F92.2010200@shadowen.org>
References: <20061128020246.47e481eb.akpm@osdl.org>
	 <200611281235.45087.m.kozlowski@tuxland.pl>
	 <20061128223058.GC16152@kroah.com>
	 <1164791161.3613.106.camel@pim.off.vrfy.org>
	 <456E0F92.2010200@shadowen.org>
Content-Type: text/plain
Date: Thu, 30 Nov 2006 00:09:10 +0100
Message-Id: <1164841750.3618.12.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4ddcc9dd12ba6cf3155e4d81b383efda
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-29 at 22:54 +0000, Andy Whitcroft wrote:
> Kay Sievers wrote:
> > On Tue, 2006-11-28 at 14:30 -0800, Greg KH wrote:
> >> On Tue, Nov 28, 2006 at 12:35:43PM +0100, Mariusz Kozlowski wrote:
> >>> Hello,
> >>>
> >>> 	When CONFIG_MODULE_UNLOAD is not set then this happens:
> >>>
> >>>   CC      kernel/module.o
> >>> kernel/module.c:852: error: `initstate' undeclared here (not in a function)
> >>> kernel/module.c:852: error: initializer element is not constant
> >>> kernel/module.c:852: error: (near initialization for `modinfo_attrs[2]')
> >>> make[1]: *** [kernel/module.o] Error 1
> >>> make: *** [kernel] Error 2
> >>>
> >>> Reference to 'initstate' should stay under #ifdef CONFIG_MODULE_UNLOAD
> >>> as its definition I guess.
> >>>
> >>> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> >>>
> >>> --- linux-2.6.19-rc6-mm2-a/kernel/module.c      2006-11-28 12:17:09.000000000 +0100
> >>> +++ linux-2.6.19-rc6-mm2-b/kernel/module.c      2006-11-28 12:05:01.000000000 +0100
> >>> @@ -849,8 +849,8 @@ static inline void module_unload_init(st
> >>>  static struct module_attribute *modinfo_attrs[] = {
> >>>         &modinfo_version,
> >>>         &modinfo_srcversion,
> >>> -       &initstate,
> >>>  #ifdef CONFIG_MODULE_UNLOAD
> >>> +       &initstate,
> >>>         &refcnt,
> >>>  #endif
> >> Kay, is this correct?  I think we still need this information exported
> >> to userspace, even if we can't unload modules, right?
> > 
> > Yes, instead we should move the attribute out of the ifdef, so
> > it will be there, even when modules can't be unloaded.

> You here say move the attribute, but the patch here just adds it.  Is
> this right??  Looking at whats there before this patch it appears to
> duplicate the code from inside the #ifdef, so we have two copies when
> CONFIG_MODULE_UNLOAD is defined.

It just replaces the patch "modules-state.patch" in Greg's tree, that
adds the attribute, it's not on top of it.

Thanks,
Kay

