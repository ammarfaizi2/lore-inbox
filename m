Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423365AbWF1PwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423365AbWF1PwG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423371AbWF1PwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:52:05 -0400
Received: from terminus.zytor.com ([192.83.249.54]:63891 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423372AbWF1PwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:52:02 -0400
Message-ID: <44A2A59C.5080903@zytor.com>
Date: Wed, 28 Jun 2006 08:51:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       klibc@zytor.com
Subject: Re: [klibc 04/31] alpha support for klibc
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <klibc.200606272217.04@tazenda.hos.anvin.org> <20060628154320.GA18511@twiddle.net>
In-Reply-To: <20060628154320.GA18511@twiddle.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson wrote:
> On Tue, Jun 27, 2006 at 10:17:04PM -0700, H. Peter Anvin wrote:
>> +# Special CFLAGS for the divide code
>> +DIVCFLAGS = $(KLIBCREQFLAGS) $(KLIBCARCHREQFLAGS) \
>> +	-O3 -fomit-frame-pointer -fcall-saved-1 -fcall-saved-2 \
>> +	-fcall-saved-3 -fcall-saved-4 -fcall-saved-5 -fcall-saved-6 \
>> +	-fcall-saved-7 -fcall-saved-8 -ffixed-15 -fcall-saved-16 \
>> +	-fcall-saved-17 -fcall-saved-18 -fcall-saved-19 -fcall-saved-20 \
>> +	-fcall-saved-21 -fcall-saved-22 -ffixed-23 -fcall-saved-24 \
>> +	-ffixed-25 -ffixed-27
> 
> These routines absolutely cannot be written in C.  The return value
> goes in a different register, which you cannot modify via compiler
> flags.  Please use the hand-coded assembly from linux/arch/alpha/lib/.
> 

Funny, we had this discussion a couple of years ago...

What the above does is generate a calling convention with the right 
number of (various types of) registers.  Then the Makefile swaps the 
registers that the compiler outputs.  It's a bit of a hack, but it's 
reliable and works.  The resulting code isn't as compact at divide.S, 
though.

However, I've tried to keep the code under the BSD license, mostly for 
the benefit of the standalone klibc version (static linkage being the 
norm, after all); so I don't want to crib kernel code unless the owner 
consents to relicensing.  I have cribbed some NetBSD code in some 
places, though.

	-hpa
