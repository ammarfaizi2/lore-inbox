Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161055AbWJRPzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbWJRPzM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161210AbWJRPzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:55:11 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:29330
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1161055AbWJRPzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:55:09 -0400
From: Rob Landley <rob@landley.net>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] kbuild: make*config usage doc.
Date: Wed, 18 Oct 2006 11:55:29 -0400
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, zippel@linux-m68k.org,
       sam@ravnborg.org
References: <20061017223257.c646f616.randy.dunlap@oracle.com>
In-Reply-To: <20061017223257.c646f616.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610181155.30587.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 October 2006 1:32 am, Randy Dunlap wrote:
> Is this useful for anyone?

It's quite nice.

> Is anything happening with mini.config or a replacement for it?

Sorry, didn't know anybody else was interested.

I'm working on a patch to make the actual C code (probably 
scripts/kconfig/confdata.c:conf_write()) to spit out a miniconfig without the 
nasty shell script that takes forever to run.  That's the big missing piece, 
the rest I already submitted two different patches to the list for.  (Well, I 
should also tweak the makefile dependencies a bit to automatically regenerate 
a missing or older .config from a mini.config if it exists, but that's a 
later patch.)

I also owe Andrew Morton a better explanation of miniconfig.  When I bumped 
into him at OLS he asked for a better explanation, but ever since I got back 
real life has pushed this off the back burner and into the refrigerator...

I'll try to scrape up some time this week to work on this.

(Oh, as long as Sam's cc'd: my todo item for this says "start from the klibc 
code", but klibc hasn't got the menuconfig infrastructure.  I assume that 
discussion was just about Kbuild and not menuconfig?  I'm still interested in 
using Kbuild for toybox, did you do any more work on this or is kbuild 1.4 
still the best starting point?)

> +KCONFIG_ALLCONFIG
> +--------------------------------------------------
> +(partially based on lkml email from/by Rob Landley, re: miniconfig)
> +--------------------------------------------------
> +The allyesconfig/allmodconfig/allnoconfig/randconfig variants can
> +also use the environment variable KCONFIG_ALLCONFIG as a flag or a
> +filename that contains config symbols that the user requires to be
> +set to a specific value.  If KCONFIG_ALLCONFIG is used without a
> +filename, "make *config" checks for a file named
> +"all{yes/mod/no/random}.config" (corresponding to the *config command
> +that was used) for symbol values that are to be forced.  If this file
> +is not found, it checks for a file named "all.config" to contain forced
> +values.
> +
> +This enables you to create "miniature" config (miniconfig) or custom
> +config files containing just the config symbols that you are interested
> +in.  Then the kernel config system generates the full .config file,
> +including dependencies of your miniconfig file, based on the miniconfig
> +file.

I'd keep just that bit, and then refer to the miniconfig documentation when it 
goes in.  Right now it doesn't tell you how to make a miniconfig, and the 
miniconfig patch adds an easier UI for using them anyway.

Lemme go poke at that now...

Rob
-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
