Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWDJOpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWDJOpe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 10:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWDJOpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 10:45:34 -0400
Received: from terminus.zytor.com ([192.83.249.54]:8111 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751197AbWDJOpc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 10:45:32 -0400
Message-ID: <443A6F6E.7060304@zytor.com>
Date: Mon, 10 Apr 2006 07:45:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Sam Ravnborg <sam@ravnborg.org>, Herbert Xu <herbert@gondor.apana.org.au>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mm-commits@vger.kernel.org
Subject: Re: + git-klibc-mktemp-fix.patch added to -mm tree
References: <14836.1144654413@kao2.melbourne.sgi.com>
In-Reply-To: <14836.1144654413@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> "H. Peter Anvin" (on Sat, 08 Apr 2006 13:27:06 -0700) wrote:
>> Either which way; I have a better fix for the bison issue (this all has 
>> to do with the fact that make's handling of tools that output more than 
>> one file at a time is at the very best insane)
> 
> Hit the same problem back in the 2.5 kbuild days, and worked around it
> with some dummy dependency rules.  Like this one for bison/yacc.
> 
> side_effect(aicasm_gram.tab.h aicasm_gram.tab.c)
> 
> which expands to
> 
> $(objtree)/aicasm_gram.tab.h: $objtree/aicasm_gram.tab.c
> 	@/bin/true
> 
> That forces make to wait until aicasm_gram.tab.c is built before using
> aicasm_gram.tab.h, and allows the following code to depend on either
> aicasm_gram.tab.h or aicasm_gram.tab.c without any races.  The command
> should not get executed, but you still need a command to keep make
> happy.

A better way to do it for something like yacc/bison is to use a pattern 
rule.  Having two things on the LHS means different things for explicit 
and for pattern rules!

	-hpa
