Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbUCEO3e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 09:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbUCEO3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 09:29:33 -0500
Received: from [195.23.16.24] ([195.23.16.24]:43457 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262602AbUCEO2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 09:28:37 -0500
Message-ID: <40488E45.7070901@grupopie.com>
Date: Fri, 05 Mar 2004 14:27:17 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg KH <greg@kroah.com>, Andy Lutomirski <luto@myrealbox.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BUG] usblp_write spins forever after	an	error
References: <402FEAD4.8020602@myrealbox.com>	 <20040216035834.GA4089@kroah.com>  <4030DEC5.2060609@grupopie.com>	 <1078399532.4619.129.camel@hades.cambridge.redhat.com>	 <4047221E.9050500@grupopie.com> <1078479692.12176.32.camel@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

> On Thu, 2004-03-04 at 12:33 +0000, Paulo Marques wrote:
> 
>>Yes, unfortunately it did went into 2.6.4-rc1. However it is already corrected 
>>in 2.6.4-rc2. Luckily it didn't went into any "non-rc" official release.
>>
>>Please try 2.6.4-rc2, and check to see if the bug went away...
>>
> 
> Seems to work; thanks. Does this need backporting to 2.4 too?
> 


Unfortunately this isn't over yet.

I got suspicious about this bug fix, because I *did* test my patch before 
submitting it and the kernel that didn't work before, worked fine with my patch.

But now it seems that it is the other way around. After a few digging I found 
out the problem:

The application that I was testing with uses the usblp handle with non-blocking 
I/O .

So my patch does work for non-blocking I/O uses of the port, but wrecks the 
normal blocking mode.

I've already produced a version that works for both cases. I'll just clean it up 
a bit and submit it to 2.4 and 2.6 kernels.

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

