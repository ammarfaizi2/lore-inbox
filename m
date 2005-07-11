Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVGKLDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVGKLDu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 07:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVGKLDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 07:03:50 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:9941 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S261622AbVGKLDt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 07:03:49 -0400
Message-ID: <42D253B5.20101@aitel.hist.no>
Date: Mon, 11 Jul 2005 13:10:45 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Swap partition vs swap file
References: <20050710014559.GA15844@animx.eu.org> <E1DrRLL-00017G-00@calista.eckenfels.6bone.ka-ip.net> <20050710125438.GA17784@animx.eu.org>
In-Reply-To: <20050710125438.GA17784@animx.eu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:

>Bernd Eckenfels wrote:
>  
>
>>In article <20050710014559.GA15844@animx.eu.org> you wrote:
>>    
>>
>>>You misunderstood entirely what I said.
>>>      
>>>
>>There is no portable/documented way to grow a file without having the file
>>system null its content. However why is that a problem, you dont create
>>those files very often. Besides it is better for the OS to be able to asume
>>that a page with zeros in it is equal to the page on fresh swap.
>>    
>>
You don't need to zero out swapfiles. You can fill them with anything,
even /dev/urandom.  Zero-filling may be faster though.  A swapfile
is not zero the second time you use it - then it contains leftovers
from last time.

>
>So are you saying that if I create a swap partition it's best to use dd to
>zero it out before mkswap?  If no, then why would a file be different?  I
>know there's no documented way to create a file of given size without
>writing content.  I saw windows grow a pagefile several meg in less than a
>second so I'm sure that it doesn't zero out the space first.
>  
>
Linux doesn't grow swapfiles at all.  It uses what's there at mkswap time.
You can make new ones of course - manually.

>As far as portable, we're talking about linux, portability is not an issue
>in this case.  I myself don't use swap files (or partitions), however, there
>was a project I recall that would dynamically add/remove swap as needed. 
>Creating a file of 20-50mb quickly would have been beneficial.
>  
>
You can create 50M quickly - even if it actually have to be written.  If
you can't, don't use that device for swap. 

Ability to allocate some blocks without actually writing to them is nice 
for this
purpose, but current linux filesystems doesn't have an api for doing that.
The necessary changes would touch all existing writeable filesystems, and
that is a lot of work for very little gain.  As they say, you don't 
create swapfiles
all that often.  The time saved on swapfile creation might take a long 
time to
make up for the time spent on making, auditing and supporting those
changes.

Helge Hafting




