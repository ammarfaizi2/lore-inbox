Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281552AbRKUAxO>; Tue, 20 Nov 2001 19:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281080AbRKUAw5>; Tue, 20 Nov 2001 19:52:57 -0500
Received: from rj.sgi.com ([204.94.215.100]:1259 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S281552AbRKUAwm>;
	Tue, 20 Nov 2001 19:52:42 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: marcel@mesa.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: make modules_install fails with latest fileutils 
In-Reply-To: Your message of "Tue, 20 Nov 2001 19:38:20 BST."
             <20011120193820.A14068@joshua.mesa.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 21 Nov 2001 11:52:26 +1100
Message-ID: <1128.1006303946@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001 19:38:20 +0100, 
"Marcel J.E. Mol" <marcel@mesa.nl> wrote:
>Just had some problems doing a modules_install with
>fileutils-1.1.1-1 (redhat rawhide). The cp command
>in there gives a non-zero return value when it is asked
>to copy the same file in the argument list:
>
>--- Rules.make.org	Tue Nov 20 19:36:16 2001
>+++ Rules.make	Mon Nov 19 23:48:03 2001
>@@ -173,7 +173,7 @@
> _modinst__: dummy
> ifneq "$(strip $(ALL_MOBJS))" ""
> 	mkdir -p $(MODLIB)/kernel/$(MOD_DESTDIR)
>-	cp -f $(ALL_MOBJS) $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET)
>+	-cp -f $(ALL_MOBJS) $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET)
> endif

(1) Complain to the fileutils maintainer for introducing incompatible
    behaviour.
(2) The correct workaround is
     cp -f $(sort $(ALL_MOBJS)) $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET)

