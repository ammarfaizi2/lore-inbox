Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269156AbUIHOWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269156AbUIHOWo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269127AbUIHOV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:21:57 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:30422 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S269156AbUIHOTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:19:04 -0400
Date: Wed, 8 Sep 2004 07:18:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_CMDLINE broken on ppc
Message-ID: <20040908141857.GB26381@smtp.west.cox.net>
References: <20040908134028.GB15209@suse.de> <20040908135211.GA26381@smtp.west.cox.net> <20040908140323.GA15309@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908140323.GA15309@suse.de>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 04:03:23PM +0200, Olaf Hering wrote:
>  On Wed, Sep 08, Tom Rini wrote:
> 
> > On Wed, Sep 08, 2004 at 03:40:28PM +0200, Olaf Hering wrote:
> > 
> > > CONFIG_CMDLINE can not work on ppc.
> > > machine_init() copies the string to cmd_line, then platform_init() is
> > > called. It truncates the string to length zero.
> > 
> > This has come up before, actually.  What happens if CMDLINE isn't set,
> > and we don't terminate cmd_line here?  It's part of the BSS and is
> > zero'd out anyways?
> 
> strlcpy generates a null-terminated string, if size != 0. Looks like
> that line can go.

... but strlcpy might not be called if no one passes a commandline.
Hence, is this part of the bss and already zeroed ?  If yes, then just
remove the line.

> Or move it at the start of machine_init().

Or always define CMDLINE, ala the ADVANCED_OPTIONS || defaults, no #if's
that way :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
