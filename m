Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTFDAHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTFDAHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:07:19 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:52751 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S261969AbTFDAHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:07:18 -0400
Date: Wed, 4 Jun 2003 02:20:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Witold Krecicki <adasi@kernel.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.70-bk-20030603] oldconfig always asking for machine type
 (x86)
In-Reply-To: <1054668864.12364.8.camel@samael.culm.net>
Message-ID: <Pine.LNX.4.44.0306040219250.12110-100000@serv>
References: <1054668864.12364.8.camel@samael.culm.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3 Jun 2003, Witold Krecicki wrote:

> Even if I'm doing this once after another, this a lil' bit complicates
> creating binary packages with kernel, as building it should not wait for
> any user input/interaction.

I think I found the problem, could you try the patch below?

bye, Roman

--- linux-2.5.70/scripts/kconfig/confdata.c	2003-05-28 22:47:05.000000000 +0200
+++ linux-2.5.70/scripts/kconfig/confdata.c	2003-06-04 02:13:38.000000000 +0200
@@ -243,7 +243,8 @@ int conf_read(const char *name)
 		prop = sym_get_choice_prop(sym);
 		sym->flags &= ~SYMBOL_NEW;
 		for (e = prop->expr; e; e = e->left.expr)
-			sym->flags |= e->right.sym->flags & SYMBOL_NEW;
+			if (e->right.sym->visible != no)
+				sym->flags |= e->right.sym->flags & SYMBOL_NEW;
 	}
 
 	sym_change_count = 1;

