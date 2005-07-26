Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVGZDLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVGZDLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 23:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVGZDLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 23:11:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12446 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261559AbVGZDLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 23:11:37 -0400
Date: Mon, 25 Jul 2005 20:10:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [swsusp] encrypt suspend data for easy wiping
Message-Id: <20050725201036.2205cac3.akpm@osdl.org>
In-Reply-To: <42DA7B12.7030307@domdv.de>
References: <20050703213519.GA6750@elf.ucw.cz>
	<20050706020251.2ba175cc.akpm@osdl.org>
	<42DA7B12.7030307@domdv.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz <ast@domdv.de> wrote:
>
> the attached patches are acked by Pavel and signed off by me

OK, well I queued this up, without a changelog.  Because you didn't send
one.  Please do so.  As it adds a new feature, quite a bit of info is
relevant.

It should include a description of what the patch tries to do, and how it
does it.  It should include a description of any known shortcomings.  If
any user configuration is needed then that should be placed somewhere under
Documentation/

Take a look at how other people document their feature additions and you'll
get the idea.

Please don't send multiple patches per email.  In this case I did the
handwork and put both diffs into the same patch.

Personally, I don't like this:

+config SWSUSP_ENCRYPT
+	bool "Encrypt suspend image"
+	depends on SOFTWARE_SUSPEND && CRYPTO=y && (CRYPTO_AES=y || CRYPTO_AES_586=y || CRYPTO_AES_X86_64=y)

This requires the user to hunt around in config until all the right options
are enabled to permit SWSUSP_ENCRYPT to appear in config.  That can be
quite frustrating and is very poor UI.

For a top-level feature such as this it is much better to always offer the
feature to the user and to then use `select' to turn on all the
infrastructure bits which the user will need.  Make the computer do the
work rather than the user.

Yes, it might be a bit tricky in this case because you have a dependency on
one of the AES encryption types, but it would be good if you can come up
with something which doesn't force the user into a game of hide-and-seek.
