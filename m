Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTDOPOA (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 11:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbTDOPOA 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 11:14:00 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:13264 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261664AbTDOPN6 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 11:13:58 -0400
Date: Tue, 15 Apr 2003 17:25:46 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Quick way to get preprocessor output???
Message-ID: <20030415152546.GC7721@wohnheim.fh-wedel.de>
References: <3E9C226E.6090102@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E9C226E.6090102@techsource.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 April 2003 11:17:02 -0400, Timothy Miller wrote:
> 
> This is in regard to the kernel message compression I'm working on.

Something tells me that fun patches are going to show up.

> I'm starting work on the code parser for the kernel, and I find that a 
> lot of the printk format strings have macros in them.  Is there a quick 
> and easy way to get preprocessor (.i) output from all kernel source files?
> 
> I'm sure I won't understand enough to hack all Makefiles, but in case I 
> have to, what would be the best way of going about it?  I know about 
> using -E, but I don't want to take an excessive amount of time on this.

Try the patch below or something similar. This was done by memory,
without testing, for 2.5. The equivalent for 2.4 would be even
simpler.

Actually, this should not work yet, the real trick would be to
generate the .o files from .c *and* the .i, so the linker stage will
find correct .o files and keep running.

In case you want to do allyesconfig, you will several hours fixing
compile problems. The resulting .config after doing all that is on my
system, you can have it if you want it.

> Of course, to actually implement the text compression, all Makefiles 
> will have to change anyhow to pipe preprocessor output through a program 
> whose output is then run through the compiler.

Not all Makefiles, just one. :)

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong

--- linux-2.5.67/scripts/Makefile.build~pp_output	2003-04-07 19:32:25.000000000 +0200
+++ linux-2.5.67/scripts/Makefile.build	2003-04-15 17:12:32.000000000 +0200
@@ -157,7 +157,7 @@
 	$(call if_changed_dep,cc_i_c)
 
 quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
-cmd_cc_o_c       = $(CC) $(c_flags) -c -o $@ $<
+cmd_cc_o_c       = $(CC) $(c_flags) -C -E $< > $<.i
 
 # Built-in and composite module parts
 
