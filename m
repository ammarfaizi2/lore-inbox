Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVAHD2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVAHD2q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 22:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVAHDQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 22:16:11 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:32198 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261795AbVAHDKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 22:10:22 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: inter_module_get and __symbol_get 
In-reply-to: Your message of "Thu, 06 Jan 2005 16:57:57 CDT."
             <41DDB465.8000705@didntduck.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Jan 2005 14:10:00 +1100
Message-ID: <8829.1105153800@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2005 16:57:57 -0500, 
Brian Gerst <bgerst@didntduck.org> wrote:
>Terence Ripperda wrote:
>> Hello,
>> 
>> we've noticed that in recent 2.6.10 kernels that the inter_module_
>> routines (such as inter_module_get) are marked deprecated. it appears
>> that the __symbol_ routines (such as __symbol_get) are intended as the
>> replacement routines.
>> 
>> unfortunately, __symbol_get is only exported as a GPL symbol (I see a
>> reference to a _gpl verion in module.h, but no definition). is this
>> intentional? will there be a non-gpled version of an equivalent
>> routine?
>> 
>> Thanks,
>> Terence
>
>I believe there is an AGP/DRM rewrite in progress that should eliminate 
>the need to use inter_module or symbol_get stuff.

inter_module_* and the replacement __symbol_* routines are designed to
solve a generic problem, they are not only there for AGP/DRM.  I am
against removing these functions just because AGP/DRM no longer require
the facility, other code can hit the same generic problem.

inter_module_* and __symbol_* solve these class of problems:

Module A can use module B if B is loaded, but A does not require module
B to do its work.  B is optional.

The kernel can use code in module C is C is loaded, but the base kernel
does not require module C.  C is optional.

The standard module loader already handles the "require" cases, via the
unresolved symbol list and modules.dep.  The module loader cannot
handle the "optional" cases, because only the consumer of the optional
resources knows what it needs and what to do if the optional resources
are not available.  The consumer uses inter_module_* or __symbol_* to
detect and lock down the optional facilities.

