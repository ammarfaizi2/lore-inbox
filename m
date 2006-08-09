Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWHIBbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWHIBbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWHIBbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:31:04 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:18650 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030398AbWHIBbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:31:03 -0400
Subject: Re: [PATCH] CONFIG_RELOCATABLE modpost fix
From: Magnus Damm <magnus@valinux.co.jp>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       ebiederm@xmission.com
In-Reply-To: <20060808183954.GA8300@mars.ravnborg.org>
References: <20060808083307.391.45887.sendpatchset@cherry.local>
	 <20060808183954.GA8300@mars.ravnborg.org>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 10:32:36 +0900
Message-Id: <1155087156.4341.66.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again Sam,

On Tue, 2006-08-08 at 20:39 +0200, Sam Ravnborg wrote:
> On Tue, Aug 08, 2006 at 05:32:11PM +0900, Magnus Damm wrote:
> > CONFIG_RELOCATABLE modpost fix
> > 
> > Run modpost on vmlinux regardless of CONFIG_MODULES.
> Below is my take on this one.
> - Dropped -rR since this is default now
> - Dropped subdir- assignment in scripts/Makefile since it is redundant
> - Always pass vmlinux ti modpost so we have full updated info
> - Print out number of modules being mod posted to distingush from
>   vmlinux one
> - use vmlinux as target name to enable nicer quiet command print

Your patch seems to work as expected if I add a return 0 at the end of
modpost.c:secref_whitelist(). I like how you printed out the number of
modules being processed. I have one minor comment about your patch:

Modpost seems to get run twice on vmlinux if the kernel is built with
"make all". I think it would be best to run modpost on vmlinux only when
vmlinux is built - never when modules are processed.

Thanks,

/ magnus


