Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945933AbWBONWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945933AbWBONWp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 08:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945936AbWBONWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 08:22:45 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:13704 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1945933AbWBONWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 08:22:45 -0500
Date: Wed, 15 Feb 2006 14:19:04 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andi Kleen <ak@suse.de>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc3-mm1: i386 compilation broken
In-Reply-To: <200602141427.49763.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0602151404141.9696@scrub.home>
References: <20060214014157.59af972f.akpm@osdl.org> <20060214131715.GA10701@stusta.de>
 <200602141427.49763.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 14 Feb 2006, Andi Kleen wrote:

> Ok then the -ffreestanding was apparently still needed on other architectures too.
> I guess that part of the patch can be just dropped.

The main problem is still the sprintf optimization, so 
--fno-builtin-sprintf should fix it too.
That leaves only the single strchr, which is caused by an strpbrk 
optimization in zoran_procfs.c, where we could use --fno-builtin-strpbrk 
or simply directly replace that strpbrk with strchr.

If we really want to keep -ffreestanding, we have to rework how string.h 
is organized to allow enabling builtin functions, but still provide fall 
back functions. For example we had to add a lot of "#define foo 
__builtin_foo" to linux/string.h and "#undef foo" to lib/string.c.

bye, Roman
