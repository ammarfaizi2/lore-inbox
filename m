Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVBHTmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVBHTmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 14:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVBHTmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 14:42:39 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:37453 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261645AbVBHTmi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 14:42:38 -0500
Date: Tue, 8 Feb 2005 20:42:43 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ARM undefined symbols.  Again.
Message-ID: <20050208194243.GA8505@mars.ravnborg.org>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050124154326.A5541@flint.arm.linux.org.uk> <20050131161753.GA15674@mars.ravnborg.org> <20050207114359.A32277@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207114359.A32277@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 11:43:59AM +0000, Russell King wrote:
> 
> Maybe we need an architecture hook or something for post-processing
> vmlinux?
Makes sense.
For now arm can provide an arm specific cmd_vmlinux__ like um does.

The ?= used in Makefile snippet below allows an ARCH to override the
definition of quiet_cmd_vmlinux__ and cmd_vmlinux__



quiet_cmd_vmlinux__ ?= LD      $@
      cmd_vmlinux__ ?= $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) -o $@ \
      -T $(vmlinux-lds) $(vmlinux-init)                          \
      --start-group $(vmlinux-main) --end-group                  \
      $(filter-out $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) FORCE ,$^)


	Sam
