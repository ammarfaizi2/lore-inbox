Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752128AbWJNKmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbWJNKmP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 06:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbWJNKmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 06:42:15 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:62185 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1752128AbWJNKmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 06:42:14 -0400
Date: Sat, 14 Oct 2006 12:41:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Stephane Eranian <eranian@hpl.hp.com>
Subject: Re: [PATCH] rename net_random to random32
Message-ID: <20061014104154.GA26210@uranus.ravnborg.org>
References: <200610111900.k9BJ01M4021853@hera.kernel.org> <452D4491.30806@garzik.org> <20061011122938.7e81f4bc@freekitty> <20061012000749.be62f2e0.akpm@osdl.org> <20061012102638.7381269a@freekitty> <20061013181922.GB721@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061013181922.GB721@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> EXPORT_SYMBOL's in lib-y are latent bugs (IMHO kbuild should error
> on them):

In practice module will not load becasue it cannot resolve symbol - right?

That aside we should not export symbols from lib-y. But I have not any good
idea how to catch this during build time unles doing some ugly grep magic.

One thing that could be done would be to check for a specific section
(__ksymtab_strings) in the .o file only for lib-y .o files.

The check could be something like:
objdump -h <file.o> | grep __ksymtab_strings

If grep give error code '0' then we exported a symbol.
I may try to cook up later this weekend.

        Sam

