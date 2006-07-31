Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWGaSsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWGaSsa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWGaSsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:48:30 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:3747 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030313AbWGaSs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:48:29 -0400
Date: Mon, 31 Jul 2006 20:48:06 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Matt Mackall <mpm@selenic.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86 built-in command line (resend)
In-Reply-To: <20060731171259.GH6908@waste.org>
Message-ID: <Pine.LNX.4.64.0607312043030.6762@scrub.home>
References: <20060731171259.GH6908@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 31 Jul 2006, Matt Mackall wrote:

> +config CMDLINE_BOOL
> +	bool "Default bootloader kernel arguments" if EMBEDDED

You can use a normal depends line here instead of the if.

> +config CMDLINE
> +	string "Initial kernel command string" if EMBEDDED
> +	depends on CMDLINE_BOOL
> +	default "root=/dev/hda1 ro"

This would cause CMDLINE always be set and the simple dependency on 
CMDLINE_BOOL should be enough, so that...

> +#ifdef CONFIG_CMDLINE_BOOL
> +	strlcpy(saved_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> +#endif

...you only have to test and use CONFIG_CMDLINE here.

bye, Roman
