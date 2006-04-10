Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWDJHeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWDJHeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 03:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWDJHeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 03:34:19 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60123 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750724AbWDJHeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 03:34:18 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Sam Ravnborg <sam@ravnborg.org>, Herbert Xu <herbert@gondor.apana.org.au>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mm-commits@vger.kernel.org
Subject: Re: + git-klibc-mktemp-fix.patch added to -mm tree 
In-reply-to: Your message of "Sat, 08 Apr 2006 13:27:06 MST."
             <44381C9A.3050502@zytor.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Apr 2006 17:33:33 +1000
Message-ID: <14836.1144654413@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" (on Sat, 08 Apr 2006 13:27:06 -0700) wrote:
>Either which way; I have a better fix for the bison issue (this all has 
>to do with the fact that make's handling of tools that output more than 
>one file at a time is at the very best insane)

Hit the same problem back in the 2.5 kbuild days, and worked around it
with some dummy dependency rules.  Like this one for bison/yacc.

side_effect(aicasm_gram.tab.h aicasm_gram.tab.c)

which expands to

$(objtree)/aicasm_gram.tab.h: $objtree/aicasm_gram.tab.c
	@/bin/true

That forces make to wait until aicasm_gram.tab.c is built before using
aicasm_gram.tab.h, and allows the following code to depend on either
aicasm_gram.tab.h or aicasm_gram.tab.c without any races.  The command
should not get executed, but you still need a command to keep make
happy.

