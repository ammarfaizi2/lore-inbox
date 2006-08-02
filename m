Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWHBHPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWHBHPn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWHBHPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:15:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48792 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751303AbWHBHPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:15:42 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 9/33] i386 boot: Add serial output support to the decompressor
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<200608020510.07569.ak@suse.de>
	<m1odv3vhaz.fsf@ebiederm.dsl.xmission.com>
	<200608020744.40888.ak@suse.de>
Date: Wed, 02 Aug 2006 01:14:08 -0600
In-Reply-To: <200608020744.40888.ak@suse.de> (Andi Kleen's message of "Wed, 2
	Aug 2006 07:44:40 +0200")
Message-ID: <m1hd0vtxrz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>  
>> The function pointers in the console structure are also a problem.
>> static struct console simnow_console = {
>> 	.name =		"simnow",
>> 	.write =	simnow_write,
>> 	.flags =	CON_PRINTBUFFER,
>> 	.index =	-1,
>> };
>
> Yes just patch them at runtime.

I guess that can work.  It's a bit of a pain though.

>> Ideally the code would be setup so you can compile out consoles
>> the user finds uninteresting.
>
> Seems overkill for early_printk

At least compiling completely out probably isn't.
I have had too many times where the size of a bzImage was an important
factor on a project.
  
>> It is annoying to have to call strlen on all of the strings
>> you want to print..
>
> What strlen? 

The strlen that is needed to convert putstr(char *s) into the
write method for the early_printk helpers.

Eric
