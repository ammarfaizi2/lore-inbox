Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315375AbSFXWCX>; Mon, 24 Jun 2002 18:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSFXWCW>; Mon, 24 Jun 2002 18:02:22 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:52753 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315370AbSFXWCU>;
	Mon, 24 Jun 2002 18:02:20 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc1 make modules_install: cp warning source file `foo.o' specified more than once 
In-reply-to: Your message of "24 Jun 2002 12:59:08 MST."
             <1024948749.2225.132.camel@shire.arnor.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Jun 2002 08:01:50 +1000
Message-ID: <10436.1024956110@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jun 2002 12:59:08 -0700, 
Torrey Hoffman <thoffman@arnor.net> wrote:
>During make modules_install I got dozens of these warnings,
>here is a short example.
>
>cp: warning: source file `ad1848.o' specified more than once

That warning does not appear for me, I guess that you are running a
bleeding edge version of fileutils.  Fix is easy (untested).

--- Rules.make	Tue Jun  4 13:32:52 2002
+++ Rules.make.new	Tue Jun 25 07:59:38 2002
@@ -176,7 +176,7 @@
 _modinst__: dummy
 ifneq "$(strip $(ALL_MOBJS))" ""
 	mkdir -p $(MODLIB)/kernel/$(MOD_DESTDIR)
-	cp $(ALL_MOBJS) $(MODLIB)/kernel/$(MOD_DESTDIR)
+	cp $(sort $(ALL_MOBJS)) $(MODLIB)/kernel/$(MOD_DESTDIR)
 endif
 
 .PHONY: modules_install

