Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWGTAN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWGTAN1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 20:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWGTAN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 20:13:26 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:58257 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964883AbWGTAN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 20:13:26 -0400
Message-ID: <44BECAA2.6010402@garzik.org>
Date: Wed, 19 Jul 2006 20:13:22 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: ricknu-0@student.ltu.se
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se> <44BE9E78.3010409@garzik.org> <1153351042.44bebd82356a4@portal.student.luth.se>
In-Reply-To: <1153351042.44bebd82356a4@portal.student.luth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ricknu-0@student.ltu.se wrote:
> Citerar Jeff Garzik <jeff@garzik.org>:
>> Also, you don't want to force 'unsigned char' on code, because often 
>> code prefers a machine integer to something smaller than a machine integer.

> But isn't a bit smaller than a byte? Sorry, do not understand what you mean.

For all processors, it is generally preferred to have integer operations 
performed on a "machine integer."  A machine integer is the natural data 
type of the processor.  If it's a 32-bit processor, the natural data 
type for the ALU is a 32-bit int.  If it's a 64-bit processor, the 
natural data type for the ALU is a 64-bit int.  [though, for some 64-bit 
processors, a 32-bit int may be best for the situation anyway]

As such, the compiler and/or CPU must do more work, if an operation such 
as a bit test is performed on a data type other than a machine int.

Consider for example ARM or Alpha architectures, which may not have 
instructions 8-bit unsigned char integers.  The integers have to be 
_converted_ to a machine integer, before the operation is performed.

It is for this reason that you often see boolean implemented as 'int' 
rather than 'unsigned char'.  'int' is much more "natural", when you 
consider all the architectures Linux must support.

The best solution is to typedef 'bool' to the compiler's internal 
boolean data type, and then update code to use 'bool'.  Then all these 
issues magically go away, because you never have to care what the 
compiler's underlying boolean data type is.

	Jeff




