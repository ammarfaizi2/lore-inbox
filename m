Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUCBXhL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUCBXhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:37:11 -0500
Received: from alt.aurema.com ([203.217.18.57]:10145 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261790AbUCBXg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:36:57 -0500
Message-ID: <40451A92.5040105@aurema.com>
Date: Wed, 03 Mar 2004 10:36:50 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Lutomirski <luto@myrealbox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <fa.jgj0bdi.b3u6qk@ifi.uio.no> <404297D1.5010301@myrealbox.com>
In-Reply-To: <404297D1.5010301@myrealbox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski wrote:
> <snip>
> Ignoring limts, this should be just an exercise in keeping track of 
> shares and eliminating the 1/420 limit in precision.  It would take some 
> thought to figure out what nice should do.
 > <snip>

I take it from this comment that you would like to see a larger range of 
shares made available?

The current range (1 to 420) was chosen to allow easy mapping between 
niceness and shares and so that minimum shares was roughly the same 
times smaller than the default as the maximum was bigger (i.e. twenty 
times).  One of the restrictions on the number of shares is the dynamic 
range of the representation of real numbers that we use for our 
calculations.  We use fixed denominator rational numbers with a 
denominator of 2 to the power of 27.  This value was chosen because the 
maximum (real number) value that we have to be able to cope with in our 
calculations is 19 and we are limited to using 32 bits because we need 
to do a divide and 64 bit division is not supported in the kernel on all 
hardwares (in particular, the IA32 kernels do not support 64 bit 
division).  The other factors that have to be taken into consideration 
are the half life and the value of HZ (which varies widely depending on 
the system).

Anyway, I will look at the numbers and see if it's possible to squeeze a 
larger range of shares in (although it may mean tighter restrictions on 
half life on some systems).

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

