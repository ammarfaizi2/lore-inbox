Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbWEaA4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWEaA4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 20:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWEaA4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 20:56:00 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:11422 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932547AbWEaAz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 20:55:59 -0400
Date: Tue, 30 May 2006 18:55:55 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: memcpy_toio on i386 using byte writes even when n%2==0
In-reply-to: <6idov-5Tc-7@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Message-id: <447CE99B.7070707@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6gUec-3mb-7@gated-at.bofh.it> <6gUec-3mb-5@gated-at.bofh.it>
 <6icVy-56r-9@gated-at.bofh.it> <6idov-5Tc-7@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> If byte writes are used, they should always be last for any
> odd byte. I think you found a bug in spite of the fact that
> whoever made the revision to memcpy probably thinks they
> did something 'cool'. This is an example of cute code causing
> problems. The classic example of a proper memcpy() that uses
> the ix86 built-in macros runs like this:
> 
>  		pushl	%esi		# Save precious registers
>  		pushl	%edi
>  		movl	COUNT(%esp),%ecx
>  		movl	SOURCE(%esp),%esi
>  		movl	DEST(%esp),%edi
>  		cld
>  		shrl	$1,%ecx		# Make WORDS, possibly set carry
>  		rep	movsw		# Copy the words
>  		adcl	%ecx,%ecx	# Any spare byte
>  		rep	movsb		# Copy any spare byte
>  		popl	%edi		# Restore precious registers
>  		popl	%esi
> 
> Note that there isn't any code for moving dwords because the
> chances of gaining anything are slim (alignment may hurt).

I'd say the chances of gaining something from executing half as many 
instructions on copying a large block of memory are very good indeed..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

