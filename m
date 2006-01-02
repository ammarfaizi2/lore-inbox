Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWABSOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWABSOH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 13:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWABSOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 13:14:07 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:21514 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750845AbWABSOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 13:14:06 -0500
Date: Mon, 2 Jan 2006 19:13:55 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Dag-Erling Sm?rgrav <des@linpro.no>
Subject: Re: [PATCH] Avoid namespace pollution in <asm/param.h>
Message-ID: <20060102181355.GA16324@mars.ravnborg.org>
References: <200601021702.k02H2mLh015729@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601021702.k02H2mLh015729@hera.kernel.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 09:02:48AM -0800, Linux Kernel Mailing List wrote:
> tree f0d89e7d946a7ed9b57bb29e93bae4ce25d2cbc2
> parent f12f4d90308a22396ac87f6c3a7b2620589614c3
> author Dag-Erling Sm?rgrav <des@linpro.no> Mon, 02 Jan 2006 15:57:06 +0100
> committer Linus Torvalds <torvalds@g5.osdl.org> Tue, 03 Jan 2006 00:38:38 -0800
> 
> [PATCH] Avoid namespace pollution in <asm/param.h>
> 
> In commit 3D59121003721a8fad11ee72e646fd9d3076b5679c, the x86 and x86-64
> <asm/param.h> was changed to include <linux/config.h> for the
> configurable timer frequency.

config.h is always implicit included using -include option to gcc,
so the
> --- a/include/asm-i386/param.h
> +++ b/include/asm-i386/param.h
> @@ -1,9 +1,8 @@
> -#include <linux/config.h>

is redundant and the correct patch would be to get rid of it.

Same goes for:
> --- a/include/asm-x86_64/param.h
> +++ b/include/asm-x86_64/param.h
> @@ -1,9 +1,8 @@
> -#include <linux/config.h>

	Sam
