Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTEHUag (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 16:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbTEHUag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 16:30:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1934 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262111AbTEHUaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 16:30:35 -0400
Date: Thu, 08 May 2003 13:43:00 -0700 (PDT)
Message-Id: <20030508.134300.122085520.davem@redhat.com>
To: pavel@ucw.cz
Cc: hch@infradead.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030508203313.GA2787@elf.ucw.cz>
References: <20030507152856.GF412@elf.ucw.cz>
	<1052323484.9817.14.camel@rth.ninka.net>
	<20030508203313.GA2787@elf.ucw.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@ucw.cz>
   Date: Thu, 8 May 2003 22:33:14 +0200

   What about this one: redefine it to (*ioctl)( ...., unsigned *long*,
   unsinged long). That means we can add 
   
   #define IOCTL_COMPAT 0x1 0000 0000

Bzzt!  Doesn't work on 32-bit.  COMPAT does not mean 64-bit-->32-bit
translations, stop thinking about the compat layer in this way.

It is a generic environment translation system.

Eventually we can use it for things like IBCS2 and stuff like that.

Suggest something sane like defining a macro such as
"compat_task(tsk)" that can be tested by various bits of
code.
