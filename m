Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVACWVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVACWVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVACWOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:14:51 -0500
Received: from alog0111.analogic.com ([208.224.220.126]:16512 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261890AbVACWKW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:10:22 -0500
Date: Mon, 3 Jan 2005 17:03:24 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [3/8] kill gen_init_cpio.c printk() of size_t warning
In-Reply-To: <41D9BC07.8070209@zytor.com>
Message-ID: <Pine.LNX.4.61.0501031657530.15108@chaos.analogic.com>
References: <20050103172013.GA29332@holomorphy.com> <41D9881B.4020000@pobox.com>
 <20050103180915.GK29332@holomorphy.com> <Pine.LNX.4.61.0501031329030.13385@chaos.analogic.com>
 <crccas$la0$1@terminus.zytor.com> <20050103213627.GS29332@holomorphy.com>
 <41D9BC07.8070209@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, H. Peter Anvin wrote:

> William Lee Irwin III wrote:
>> 
>> On Mon, Jan 03, 2005 at 09:09:48PM +0000, H. Peter Anvin wrote:
>> 
>>> Dear Wrongbot,
>>> Bullshit.  Signed is promoted to unsigned.
>> 
>> I'm not sure who you're responding to here, but gcc emitted an actual
>> warning and I was only attempting to carry out the minimal effort
>> necessary to silence it. I'm not really interested in creating or
>> being involved with controversy, just silencing the core build in the
>> least invasive and so on way possible, leaving deeper drivers/ issues
>> to the resolution of the true underlying problems.
>> 
>> I don't have anything to do with the code excerpt above; I merely
>> followed the style of the other unsigned integer coercions in the file.
>> 
>
> I was not responding to you, your stuff is perfectly sane.
>
> The claim from the Wrongbot was that "foo + 1" is bad when foo is a size_t. 
> This is utter bullshit, since that's EXACTLY equivalent to:
>
> 	foo + (size_t)1
>
> ... because of promotion rules.
>
> 	-hpa
> -

I made no such claim. I claimed that the posted fix was wrong:

>
> Index: mm1-2.6.10/usr/gen_init_cpio.c
> ===================================================================
> --- mm1-2.6.10.orig/usr/gen_init_cpio.c	2005-01-03 06:45:53.000000000 -0800
> +++ mm1-2.6.10/usr/gen_init_cpio.c	2005-01-03 09:42:18.000000000 -0800
> @@ -112,7 +112,7 @@
> 		(long) gid,		/* gid */
> 		1,			/* nlink */
> 		(long) mtime,		/* mtime */
> -		strlen(target) + 1,	/* filesize */
> +		(unsigned)strlen(target) + 1,/* filesize */
> 		3,			/* major */
> 		1,			/* minor */
> 		0,			/* rmajor */
> -


This is wrong because strlen() already returns a size_t (unsigned).
This "fix" only served to quiet the compiler which was warning
about the conversion. It is a "conversion", not a "promotion".
The simple fix to quiet this conversion warning is to use 1U
as previously shown.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
