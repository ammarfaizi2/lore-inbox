Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVCBQce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVCBQce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVCBQcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:32:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:6579 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262300AbVCBQca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:32:30 -0500
Date: Wed, 2 Mar 2005 08:28:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: kai@germaschewski.name, sam@ravnborg.org, rusty@rustcorp.com.au,
       vincent.vanackere@gmail.com, keenanpepper@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
Message-Id: <20050302082846.1b355fa4.akpm@osdl.org>
In-Reply-To: <20050302140019.GC4608@stusta.de>
References: <422550FC.9090906@gmail.com>
	<20050302012331.746bf9cb.akpm@osdl.org>
	<65258a58050302014546011988@mail.gmail.com>
	<20050302032414.13604e41.akpm@osdl.org>
	<20050302140019.GC4608@stusta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> > In lib/Makefile, remove parser.o from the lib-y: rule and add
>  > 
>  > obj-y	+= parser.o
> 
>  This I didn't find.
> 
>  Is it really the intention to silently omit objects that are not 
>  referenced or could this be changed?

In some cases, yes, it it desirable.  For example, lib/extable.c provides a
default implementation of an exception table sorter but if the architecture
defies its own, the linker will skip the default version in lib/.

At least, that's what the thinking was a few years ago.  But it's such a
special-case that we can probably forget about it and just drive the build
and linkage with config now.

>  Why doesn't an EXPORT_SYMBOL create a reference?

It does, but that reference is within the same compilation unit as the
definition.  IOW: there are no references to the symbol which are external
to the symbol's file.   There's still nothing to drag that file in.
