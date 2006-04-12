Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWDLNXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWDLNXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 09:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWDLNXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 09:23:30 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:53700 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751131AbWDLNXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 09:23:30 -0400
Date: Wed, 12 Apr 2006 15:23:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/19] kconfig: move .kernelrelease
In-Reply-To: <20060410130214.70760ae3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604121443370.32445@scrub.home>
References: <Pine.LNX.4.64.0604091728560.23148@scrub.home>
 <20060410015727.69b5c1f6.akpm@osdl.org> <20060410104250.GA24160@mars.ravnborg.org>
 <20060410025851.641022a0.akpm@osdl.org> <Pine.LNX.4.64.0604101523031.32445@scrub.home>
 <20060410130214.70760ae3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Apr 2006, Andrew Morton wrote:

> >  The patch below should speed this up.
> 
> It went from 5 seconds down to 4 seconds.

It shouldn't do much besides printing the file content.
An strace -ftt might help to find what it's wasting it time with.

> > You know that you have to update 
> >  this file explicitly?
> 
> That depends on what "explicitly" means.   `make oldconfig' updates it.

I had to change this, it's now "make prepare".
Putting it at the end of *config was an unfortunate choice, as it was 
updated independent of whether the config step left a valid config or not 
and with the fixed dependencies it even may have triggered a unexpected 
call to silentoldconfig (e.g. just by quitting xconfig/menuconfig).

bye, Roman
