Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbUKVMlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUKVMlN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 07:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbUKVMlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 07:41:13 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:33981 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262035AbUKVMlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 07:41:08 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: var args in kernel?
References: <20041109211107.GB5892@stusta.de>
	<1100037358.1519.6.camel@lb.loomes.de>
	<20041110082407.GA23090@bytesex>
	<1100085569.1591.6.camel@lb.loomes.de>
	<20041118165853.GA22216@bytesex>
	<419E689A.5000704@backtobasicsmgmt.com>
	<20041122094312.GC29305@bytesex>
	<20041122101646.GP10340@devserv.devel.redhat.com>
	<20041122102933.GG29305@bytesex>
	<Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr>
	<20041122113328.GQ10340@devserv.devel.redhat.com>
	<Pine.LNX.4.53.0411221235410.29615@yvahk01.tjqt.qr>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I haven't been married in over six years, but we had sexual
 counseling
 every day from Oral Roberts!!
Date: Mon, 22 Nov 2004 13:41:07 +0100
In-Reply-To: <Pine.LNX.4.53.0411221235410.29615@yvahk01.tjqt.qr> (Jan
 Engelhardt's message of "Mon, 22 Nov 2004 12:39:54 +0100 (MET)")
Message-ID: <je3bz2ys2k.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>> In theory, you can't. But the way how GCC (and probably other compilers)
>>> implement it, you can. Because "ap" is just a pointer (which fits into a
>>> register, if I may add). As such, you can copy it, pass it multiple times, use
>>> it multiple times, and whatever you like.
>>
>>That's exactly the wrong assumption.
>>On some Linux architectures you can, on others you can't.
>>Architectures where va_list is a char or void pointer include e.g.:
>>i386, sparc*, ppc64, ia64
>>Architectures where va_list is something different, usually struct { ... } va_list[1];
>>or something similar:
>>x86_64, ppc32, alpha, s390, s390x
>
> Yeah I originally had that in mind but did not write it out ;)
> What would the struct look like? Because if the following was true, then you
> could also use a pointer:

You left out an important detail:

> int my_printf(const char *fmt, struct { some ints, some char's, whatever } arg)

int my_printf(const char *fmt, struct { some ints, some char's, whatever } arg[1])

which the same as

int my_printf(const char *fmt, struct { some ints, some char's, whatever } *arg)

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
