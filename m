Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbWIEPEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbWIEPEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbWIEPEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:04:24 -0400
Received: from aun.it.uu.se ([130.238.12.36]:20955 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S965081AbWIEPEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:04:23 -0400
Date: Tue, 5 Sep 2006 17:04:10 +0200 (MEST)
Message-Id: <200609051504.k85F4AKi028355@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: akpm@osdl.org, amirkin@sw.ru, dev@sw.ru, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] fail kernel compilation in case of unresolved symbols
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev writes:
 > At stage 2 modpost utility is used to check modules.
 > In case of unresolved symbols modpost only prints warning.
 > 
 > IMHO it is a good idea to fail compilation process in case of
 > unresolved symbols, since usually such errors are left unnoticed,
 > but kernel modules are broken.

Total disagree. A big warning is appropriate, but failure
is unnecessary and harmful.

Consider a big modular config, which has loads of modules
I'll never need or use. Even if $random_module has an
unresolved symbol, the kernel+modules will still work with
a fairly high degree of probability, allowing me to test
other things even though $random_module is (temporarily)
broken.

Your suggestion would either force me to reconfigure to
avoid the broken module (allowing me to forget about it),
or it would prevent me from testing that kernel at all
until I or someone else fixed the $random_module breakage.
Either way, testing suffers.
