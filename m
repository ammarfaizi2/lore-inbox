Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWHBE7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWHBE7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 00:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWHBE7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 00:59:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4042 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751177AbWHBE7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 00:59:36 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 9/33] i386 boot: Add serial output support to the decompressor
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<p73zmeoz2l4.fsf@verdi.suse.de>
	<m1r6zzx41y.fsf@ebiederm.dsl.xmission.com>
	<200608020507.50590.ak@suse.de>
Date: Tue, 01 Aug 2006 22:57:54 -0600
In-Reply-To: <200608020507.50590.ak@suse.de> (Andi Kleen's message of "Wed, 2
	Aug 2006 05:07:50 +0200")
Message-ID: <m1slkfvinh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> > Actually the best way to reuse would be to first do 64bit uncompressor
>> > and linker directly, but short of that #includes would be fine too.
>> 
>> > Would be better to just pull in lib/string.c
>> 
>> Maybe.  Size is fairly important 
>
> Why is size important here?

For the same reason that we compress the kernel. ;)

This is the one chunk of code that we don't compress so every extra
byte makes our executable bigger.  Now I think the code size is
actually in the 32k - 64k range so as long as it is a minor change
it doesn't really matter.

The big pain with using lib/string.c and
arch/x86_64/kernel/early_printk.c is that it is significant change
in how the code of misc.c is constructed.  Which means some
serious reevaluation of all kinds of things need to be considered.
Making it a lot of work :)

One of the practical dangers is that we make it more likely
we can kill the boot by messing up the shared code.

I'm not certain what to think when even including normal
kernel headers causes problems.  It certainly makes me leery
of including normal kernel code.  But it might simplify some
of the problems too.

Whichever way I go scrutinizing that possibility carefully is
a lot of work.

Eric
