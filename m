Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTFGQta (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 12:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTFGQta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 12:49:30 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:53259 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S263275AbTFGQt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 12:49:29 -0400
Date: Sat, 7 Jun 2003 19:02:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Aaron Lehmann <aaronl@vitelus.com>
cc: Andi Kleen <ak@muc.de>, <linux-kernel@vger.kernel.org>, <akpm@digeo.com>,
       <vojtech@suse.cz>
Subject: Re: [PATCH] Making keyboard/mouse drivers dependent on CONFIG_EMBEDDED
In-Reply-To: <20030607064507.GJ22716@vitelus.com>
Message-ID: <Pine.LNX.4.44.0306071811470.12110-100000@serv>
References: <20030607063424.GA12616@averell> <20030607064507.GJ22716@vitelus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 6 Jun 2003, Aaron Lehmann wrote:

> On Sat, Jun 07, 2003 at 08:34:24AM +0200, Andi Kleen wrote:
> > I finally got sick of seeing bug reports from people who did not enable
> > CONFIG_VT or forgot to enable the obscure options for the keyboard
> > driver. This is especially a big problem for people who do make oldconfig
> > with a 2.4 configuration, but seems to happen in general often.
> > I also included the PS/2 mouse driver. It is small enough and a useful
> > fallback on any PC.
> 
> Can't these just be made the default and have oldconfig default to the
> defaults (does it?). Seems silly to force people to jump through hoops
> if they don't want to compile in something (i.e. they use a USB
> mouse).

Defaults cannot override the user values from .config and in most 2.4 
.configs CONFIG_INPUT is disabled, so that you cannot change CONFIG_VT 
with 'make oldconfig', as it depends now on CONFIG_INPUT.
To override the old CONFIG_INPUT value you either have to disable the 
input prompt somehow or you have to rename the symbol and change 
CONFIG_INPUT into a derived symbol, e.g.:

config INPUT2
	tristate "Input devices (needed for keyboard, mouse, ...)"
	default y

config INPUT
	def_tristate INPUT2

bye, Roman

