Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261405AbSJQP4R>; Thu, 17 Oct 2002 11:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbSJQP4Q>; Thu, 17 Oct 2002 11:56:16 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:37286 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261405AbSJQP4Q>; Thu, 17 Oct 2002 11:56:16 -0400
Date: Thu, 17 Oct 2002 11:02:14 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Module loader preparation
In-Reply-To: <20021017034634.8D6462C0EB@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0210171057210.6301-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002, Rusty Russell wrote:

> This patch fixes a couple of places using the old "I can just call my
> function init_module() and it will be called at module init" and a
> couple of modules without module_init() declarations.
> 
> These uses are obsolete with the in-kernel module loader, because the
> module_init() is where we put the module name in the ".modulename"
> section (we could have a "no_init_func()" thing, but it's fairly rare
> and hardly intuitive).

Converting things to module_init() is certainly a good thing, but having 
to provide fake init functions for modules which don't need them doesn't 
look so nice.

Did you consider just generating the info you need unconditionally in 
include/linux/module.h and then removing duplicates for multi-part modules 
using ld's link-once (I didn't try that yet, but it seems doable and would 
also remove duplicated .modinfo.kernel_version strings and the like)

--Kai


