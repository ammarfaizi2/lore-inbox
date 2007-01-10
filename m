Return-Path: <linux-kernel-owner+w=401wt.eu-S964806AbXAJIgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbXAJIgP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 03:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbXAJIgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 03:36:15 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:11049
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964806AbXAJIgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 03:36:14 -0500
Message-Id: <45A4B3E3.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 10 Jan 2007 08:37:39 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>
Cc: "Steven M. Christey" <coley@mitre.org>, "Adrian Bunk" <bunk@stusta.de>,
       <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [discuss] [2.6 patch] x86_64: re-add a newline to
	RESTORE_CONTEXT
References: <20070109025516.GC25007@stusta.de>
 <200701091201.21146.ak@suse.de> <20070109140424.5f96de69.akpm@osdl.org>
In-Reply-To: <20070109140424.5f96de69.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andrew Morton <akpm@osdl.org> 09.01.07 23:04 >>>
>On Tue, 9 Jan 2007 12:01:21 +0100
>Andi Kleen <ak@suse.de> wrote:
>
>> On Tuesday 09 January 2007 03:55, Adrian Bunk wrote:
>> > RESTORE_CONTEXT lost a newline in 
>> > commit 658fdbef66e5e9be79b457edc2cbbb3add840aa9:
>> > http://www.mail-archive.com/kgdb-bugreport@lists.sourceforge.net/msg00559.html 
>> 
>> I don't think we should add such changes for external patchkits.
>> 
>> In general kgdb shouldn't add any patches at all. If the existing 
>> hooks are not enough they should submit their changes needed so
>> that it can just work.
>> 
>
>But the patch is a bugfix.  Without it, you cannot do
>
>	RESTORE_CONTEXT	\
>	.globl ...	\

Their use was broken in the first place - they shouldn't have made
assumptions about the contents of the macro, by writing this like

	RESTORE_CONTEXT "\n\t"	\
	".globl ..."	\

if they really need to make use of the macro. This is similar to
requirements of other (assembly) macros that normally also
don't have a line terminator and hence require the users to
add appropriate line termination after the macro name (and
eventual arguments).

I would even go as far as asking for removing the \n\t on SAVE_CONTEXT
and the left \t on RESTORE_CONTEXT.

Jan
