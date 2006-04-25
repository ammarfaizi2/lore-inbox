Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWDYLug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWDYLug (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 07:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWDYLug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 07:50:36 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:21593 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750777AbWDYLuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 07:50:35 -0400
Message-ID: <444E0D07.8060309@tls.msk.ru>
Date: Tue, 25 Apr 2006 15:50:31 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: linux-kernel@vger.kernel.org
Subject: Re: __FILE__ gets expanded to absolute pathname
References: <200604251044.57373.vda@ilport.com.ua>
In-Reply-To: <200604251044.57373.vda@ilport.com.ua>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> Sometime ago I noticed that __FILE__ gets expanded into
> *absolute* pathname if one builds kernel in separate object directory.
> 
> I thought a bit about it but failed to arrive at any sensible
> solution.
> 
> Any thoughs?
> --
> vda
> 
> # strings vmlinux | grep /usr/src
> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/net/3c505.c
> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/arch/i386/kernel/time.c
....

As far as I remember, this happens when compiling with O=xxx only, ie,
only when specifying alternative object (or source) directory.  Normally
(when you compile in the source directory) they'll be like drivers/net/3c505.c,
arch/i386/kernel/time.c etc, ie, relative to the kernel top source dir.
It's because when you specify O= etc, complete source dir is passed from
makefiles, instead of relative one.

But it was long time since I switched to symlink-tree + compile instead of
compiling with O=, and things may had changed since that.

/mjt
