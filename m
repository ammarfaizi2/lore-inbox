Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbUB2Tc5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 14:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbUB2Tc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 14:32:57 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:26988 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262116AbUB2Tc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 14:32:56 -0500
Date: Sun, 29 Feb 2004 20:32:51 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Robbert Haarman <lkml@inglorion.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6 Build System and Binary Modules
Message-ID: <20040229193251.GA2181@mars.ravnborg.org>
Mail-Followup-To: Robbert Haarman <lkml@inglorion.net>,
	linux-kernel@vger.kernel.org
References: <20040229183143.GA8057@shire.sytes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040229183143.GA8057@shire.sytes.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29, 2004 at 07:31:43PM +0100, Robbert Haarman wrote:
> Hello list,
> 
> Excuse me for not finding this if it has been asked before. Please Cc any answers, as I am not subscribed to this list.
> 
> I am trying to port a driver for the Realtek 8180 wireless ehternet controller from 2.4 to 2.6. The module comes as a binary-only object file with some sources that can be adapted to fit the specific kernel. My problem is that I can't figure out how to get the 2.6 kernel to include the binary part (it's in a .o file). The new build system does a little too much magic - compiling the module from source to .ko without giving me a chance to sneak in the binary code. How do I get it to link in the .o file, without making it look for the like-named .c file?

There is no good nor documented way to do it today.
But you can use:

$(obj)/module.o: ld_flags += binary.o
Assuming you are building a module, and 'module' is the name of the
resulting module.

For built-in you shall use:
$(obj)/built-in.o: ld_flags += binary.o


	Sam
