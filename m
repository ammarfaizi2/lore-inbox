Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267725AbUJHFDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267725AbUJHFDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 01:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUJHFDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 01:03:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42169 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267725AbUJHFDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 01:03:53 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc -align options .config-settable 
In-reply-to: Your message of "Fri, 01 Oct 2004 15:17:51 MST."
             <20041001151751.3917d9d5.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Oct 2004 15:03:19 +1000
Message-ID: <4439.1097211799@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2004 15:17:51 -0700, 
Andrew Morton <akpm@osdl.org> wrote:
>Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
>>
>> With all alignment options set to 1 (minimum alignment),
>> I've got 5% smaller vmlinux compared to one built with
>> default code alignment.
>> 
>
>Sam, can you process this one?
>
>> 
>>  
>> +GCC_VERSION	= $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
>
>It bugs me that we're evaluating the same thing down in arch/i386/Makefile.
> Perhaps we should evaluate GCC_VERSION once only, as some top-level kbuild
>thing.  So everyone can assume that it's present and correct?

Using '=' is wrong here, it will evaluate the complete expression every
time GCC_VERSION is tested.  It should be ':='.  The only time '='
should be used in a Makefile is when delayed evaluation is really
required, e.g. for strings that are the target of $(call).

