Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVEPXPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVEPXPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 19:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVEPXPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 19:15:45 -0400
Received: from waste.org ([216.27.176.166]:15825 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261985AbVEPXPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 19:15:13 -0400
Date: Mon, 16 May 2005 16:15:08 -0700
From: Matt Mackall <mpm@selenic.com>
To: YhLu <YhLu@tyan.com>
Cc: linux-tiny@selenic.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: serial console
Message-ID: <20050516231508.GD5914@waste.org>
References: <3174569B9743D511922F00A0C943142309F80D9F@TYANWEB> <20050516205731.GA5914@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050516205731.GA5914@waste.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2005 at 01:57:31PM -0700, Matt Mackall wrote:
> On Mon, May 16, 2005 at 02:16:55PM -0700, YhLu wrote:
> > it says
> > 
> > drivers/built-in.o(.init.text+0x1b68): In function
> > `serial8250_start_console':
> > : undefined reference to `add_preferred_console'
> > 
> > add_preferred_console is defined in printk.c
> 
> Ahh. Turn CONFIG_PRINTK back on and it should work. This is broken in
> mainline too, I need to find time to fix it.

This should fix it (against 2.6.12-rc4, should apply cleanly to the
last -tiny release as well):

Fix compile bug with serial console and printk disabled.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: l-p/kernel/printk.c
===================================================================
--- l-p.orig/kernel/printk.c	2005-05-16 15:13:51.000000000 -0700
+++ l-p/kernel/printk.c	2005-05-16 15:29:56.000000000 -0700
@@ -665,6 +665,11 @@ asmlinkage long sys_syslog(int type, cha
 	return 0;
 }
 
+int __init add_preferred_console(char *name, int idx, char *options)
+{
+	return 0;
+}
+
 int do_syslog(int type, char __user * buf, int len) { return 0; }
 static void call_console_drivers(unsigned long start, unsigned long end) {}
 



-- 
Mathematics is the supreme nostalgia of our time.
