Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVGaIlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVGaIlv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 04:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVGaIlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 04:41:51 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:62847 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261612AbVGaIlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 04:41:50 -0400
Date: Sun, 31 Jul 2005 10:44:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Michael Krufky <mkrufky@m1k.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [HOWTO] set extra_cflags to indicate compilation against -mm kernels
Message-ID: <20050731084406.GA8588@mars.ravnborg.org>
References: <42EBF131.60507@m1k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EBF131.60507@m1k.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 05:29:21PM -0400, Michael Krufky wrote:
> With the addition of topdir-mm.patch into the -mm tree (since 
> 2.6.13-rc3-mm2), it is now possible for Makefile to detect whether a cvs 
> subtree is being built against -mm or not...  -mm kernels now have a .mm 
> file in the top level directory.
> 
> inside Makefile:
> 
> mm-kernel := $(TOPDIR)/.mm
> ifneq ($(mm-kernel),)
> MM_KERNEL_CFLAGS	:= -DMM_KERNEL=$(shell cat $(mm-kernel) 2> /dev/null)
> ifneq ($(MM_KERNEL_CFLAGS),-DMM_KERNEL=)
> EXTRA_CFLAGS		+= $(MM_KERNEL_CFLAGS)
> endif
> endif

Hi Michael.
The content of the .mm file seems to be insignificant - '1'. The important
issue is that the file is present.
Also please do not use $(TOPDIR) - it is deprecated.

The following is enough:
EXTRA_CFLAGS += $(if $(wildcard $(srctree)/.mm), -DMM_KERNEL)

If the file exist in the root of the kernel src tree MM_KERNEL will be
added to EXTRA_CFLAGS.

	Sam
