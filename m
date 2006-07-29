Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWG2O0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWG2O0x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 10:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWG2O0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 10:26:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:48061 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932145AbWG2O0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 10:26:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=RUo6Y8EenkfUkkhlhuaGFmOxqM5L9n7DSW9mcDoz/rx4+L6D0VWCEtC7CXSO/IkPiiZH1tvRcuJr5SjC/58Rr8qUhhWv9/nWXcvxbzLx9fQtaQ+wtHFCnlMZrBg2FbW4NmMDMmp1THtLQc41wIPg3qSRV5jcAKBg3V+tsMxvjpk=
Date: Sat, 29 Jul 2006 18:26:48 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc2-git7 build error with CONFIG_STACK_UNWIND enabled
Message-ID: <20060729142648.GH6843@martell.zuzino.mipt.ru>
References: <9a8748490607290641r51085a69vbea4192136f64e7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490607290641r51085a69vbea4192136f64e7c@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 03:41:46PM +0200, Jesper Juhl wrote:
> With 2.6.18-rc2-git7 I get the following build error if I have
> CONFIG_STACK_UNWIND enabled :
> 
>  CC      arch/i386/kernel/traps.o
> arch/i386/kernel/traps.c: In function `show_trace_log_lvl':
> arch/i386/kernel/traps.c:193: error: invalid type argument of `->'
> arch/i386/kernel/traps.c:196: error: invalid type argument of `->'
> arch/i386/kernel/traps.c:197: error: invalid type argument of `->'

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -190,11 +190,11 @@ static void show_trace_log_lvl(struct ta
 		if (unw_ret > 0 && !arch_unw_user_mode(&info)) {
 #ifdef CONFIG_STACK_UNWIND
 			print_symbol("DWARF2 unwinder stuck at %s\n",
-				     UNW_PC(info.regs));
+				     UNW_PC(&info));
 			if (call_trace == 1) {
 				printk("Leftover inexact backtrace:\n");
-				if (UNW_SP(info.regs))
-					stack = (void *)UNW_SP(info.regs);
+				if (UNW_SP(&info))
+					stack = (void *)UNW_SP(&info);
 			} else if (call_trace > 1)
 				return;
 			else

