Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWC2CV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWC2CV2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 21:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWC2CV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 21:21:28 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:34091 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750777AbWC2CV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 21:21:27 -0500
Date: Tue, 28 Mar 2006 20:20:46 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: BUG in Linux 2.6.16/2.6.16.1 (compilation failure of third  party
 software)
In-reply-to: <5VvNw-3B1-3@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4429EEFE.60608@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5Vr7d-4VR-15@gated-at.bofh.it> <5Vvkv-2MB-27@gated-at.bofh.it>
 <5VvNw-3B1-3@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry Godefroy wrote:
> Oh, yeah ?... Really ?... Please, read the errors before drawing hasted conclusions...
> The errors occur after the mere #inclusion of Linux headers. Here is a simple "code"
> which will trigger the error:
> 
> #ifndef __KERNEL__
> #define __KERNEL__
> #endif
> 
> #include <linux/module.h>
> 
> int main() {
> 	return 0;
> }
> 
> And I don't see anything wrong in that code...

Sure there is, it's a userspace program that's including kernel headers 
for one thing.. Also what makefiles are being used to compile this? You 
can't just use any old makefile on a kernel module in 2.6 and expect it 
to work properly.

Given that the kernel doesn't produce such errors in its own 
compilation, that pretty much automatically makes it the problem of the 
3rd-party code.

>> Linux makes no effort to guarantee source or binary compatibility with
>> out of tree kernel modules, or userspace code that includes kernel
>> headers.
> 
> That's a pity... Non-regression should be guaranteed. The problem with Linux
> is that each new version brings a load of incompatibilities with third parties
> drivers (graphic cards, win/smart modems, wifi cards, etc, etc), most of which
> using proprietary code which sources are unavailable to the end user. The fact
> that Linux keeps breaking those drivers code is not going to encourage hardware
> vendors to make Linux drivers for their products. For example, ATI takes a
> couple of months to catchup with the kernel changes, and each time they release
> a new driver the next Linux release breaks it. :-(

This has been covered time and again. If drivers don't want to be broken 
by kernel changes, the best solution is to get them included in the 
kernel source tree where they will be kept up to date automatically. And 
there is very little interest in the community in helping binary drivers 
work any better, they're not something people want to encourage, for 
good reason.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

