Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbUK2SuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUK2SuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 13:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbUK2SuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 13:50:09 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:64976 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261497AbUK2SuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:50:05 -0500
Date: Mon, 29 Nov 2004 11:50:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@Osdl.ORG>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow compiling i386 with an x86-64 compiler
Message-ID: <20041129185004.GF22325@smtp.west.cox.net>
References: <41A4B52D.2030402@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A4B52D.2030402@zytor.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 08:22:05AM -0800, H. Peter Anvin wrote:

> This patch adds -m32 if gcc supports it, thus making it easier to 
> compile the i386 architecture with an x86-64 compiler.
> 
> Note that it adds the option to CC, since it also affects assembly code 
> and linking.  The extra level of indirection is because $(call 
> cc-option) itself uses $(CC), so just doing CC += ... would cause $(CC) 
> to be recursively defined.

Just so 'bi-arch' arches look the same, I'd like to suggest (and stolen
from ppc32) something like:
HAS_BIARCH      := $(call cc-option-yn, -m32)
ifeq ($(HAS_BIARCH),y)
CC := $(CC) -m32
endif

Up near the top...

-- 
Tom Rini
http://gate.crashing.org/~trini/
