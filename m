Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWDYHU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWDYHU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 03:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWDYHU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 03:20:29 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:36357 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751363AbWDYHU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 03:20:28 -0400
Message-ID: <444DCDB8.4070807@argo.co.il>
Date: Tue, 25 Apr 2006 10:20:24 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>	 <1145911546.1635.54.camel@localhost.localdomain>	 <444D3D32.1010104@argo.co.il> <1145915918.1635.64.camel@localhost.localdomain>
In-Reply-To: <1145915918.1635.64.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 07:20:26.0951 (UTC) FILETIME=[B9B17570:01C66838]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2006-04-25 at 00:03 +0300, Avi Kivity wrote:
>   
>> Alan Cox wrote:
>> I think it's easy to show that the equivalent C++ code would be shorter, 
>> faster, and safer.
>>     
>
> Mathematically the answer is "no you couldn't". You might be able to
> argue that a fortran implementation would be faster but not a C++ one.
>   
Maybe not mathematically, but I can try to hand-wave my way through.

By using exceptions, you free the normal return paths from having to 
check for errors. The exception paths can be kept in a dedicated 
section, avoiding cache pollution. The total code (and data) size 
increases, but the non-exception paths size decreases significantly and 
becomes faster.

Using C++ objects instead of C objects allows you to avoid void 
pointers, which are difficult for the compiler to optimize due to aliasing.
> And for strings C++ strings are suprisingly inefficient and need a lot
> of memory allocations, which can fail and are not handled well without C
> ++ exceptions and other joyous language features you don't want in a
> kernel. C with 'safe' string handling is similar - look at glib.
>
> We have to make tradeoffs and the kernel tradeoffs have been to keep C
> type fast string handling but to provide helpers in the hope people will
> actually use them to avoid making mistakes.
>   
You might keep C strings (or something similar) for the vfs paths and 
use C++ strings for non performance critical code.

-- 
error compiling committee.c: too many arguments to function

