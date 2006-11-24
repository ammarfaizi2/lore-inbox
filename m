Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934989AbWKXRYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934989AbWKXRYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 12:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934992AbWKXRYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 12:24:32 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:58130 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S934989AbWKXRYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 12:24:31 -0500
Message-ID: <45672AC8.2010303@shadowen.org>
Date: Fri, 24 Nov 2006 17:24:24 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>,
       Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi_limit_regions triggers link failure when CONFIG_EFI
 is not defined
References: <20061123021703.8550e37e.akpm@osdl.org> <35d909969a9b883d8ee15ee1df497fd9@pinky> <200611241805.45621.ak@suse.de>
In-Reply-To: <200611241805.45621.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Friday 24 November 2006 17:59, Andy Whitcroft wrote:
>> The following patch is needed to get 2.6.19-rc6-mm1 to compile with
>> CONFIG_EFI disabled.  This is the 'shortest' fix.  However, it does
>> appear that there is some overlap with EFI implmentation partly
>> being in e820.c and partly in efi.c.  It might make sense to move
>> everything efi related over to efi.c.
> 
> It compiles here. And the ifdef status hasn't changed at all.

Right, when it was in the function directly the optimiser seems to have
lopped it off nice and early and got rid of the link failure.

> Ah maybe your compiler failed to inline the function so the compiler
> couldn't optimize it away. What compiler were you using? Does it
> go away if you add a "inline" to efi_limit_regions()?

Compiler is as below:

    gcc version 3.3.4 (Debian 1:3.3.4-3)

Yes, making efi_limit_regions() inline also seems to work.  Can we
guarentee it will be inlined though?  I had the feeling that inline was
advisory and if it does not inline then we will get the link failures.

-apw
