Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271890AbTHMMTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272445AbTHMMTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:19:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43138 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271890AbTHMMTg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:19:36 -0400
Date: Wed, 13 Aug 2003 13:19:35 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Adrian Reber <adrian@lisas.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vsnprintf patch
Message-ID: <20030813121935.GC454@parcelfarce.linux.theplanet.co.uk>
References: <20030813115212.GA28066@lisas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813115212.GA28066@lisas.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 01:52:12PM +0200, Adrian Reber wrote:
> 
> When using the snprintf function from the kernel the length returned is
> not the length written:
> 
> len = snprintf(test,1,"BLA 1"); 
> 
> len is 5 although test is "B"
> 
> the patch below fixes the symptom, but I am not sure if this is the real
> solution for this problem.

For what problem?  In the example above, 5 is correct return value.

7.19.6.5  The snprintf function

Synopsis

#include <stdio.h>

int snprintf(char * restrict s, size_t n, const char * restrict format, ...);

Description

The snprintf function is equivalent to fprintf, except that the output is
written into an array (specified by argument s) rather than to a stream.
If n is zero, nothing is written, and s may be a null pointer.  Otherwise,
output characters beyond the n-1st are discarded rather than being written
to the array, and a null character is written at the end of the characters
actually written into the array.  If copying takes place between objects
that overlap, the behavior is undefined.

Returns

The snprintf function returns the number of characters that would have
been written had n been sufficiently large, not counting the terminating
null character, or a negative value if an encoding error occurred.  Thus,
the null-terminated output has been completely written if and only if
the returned value is nonnegative and less than n.
