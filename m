Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbVJUQTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVJUQTX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 12:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbVJUQTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 12:19:23 -0400
Received: from THUNK.ORG ([69.25.196.29]:30876 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965017AbVJUQTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 12:19:22 -0400
Date: Fri, 21 Oct 2005 12:19:20 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Vincent W. Freeh" <vin@csc.ncsu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Understanding Linux addr space, malloc, and heap
Message-ID: <20051021161920.GA13574@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Vincent W. Freeh" <vin@csc.ncsu.edu>, linux-kernel@vger.kernel.org
References: <4358F0E3.6050405@csc.ncsu.edu> <1129903396.2786.19.camel@laptopd505.fenrus.org> <4359051C.2070401@csc.ncsu.edu> <1129908179.2786.23.camel@laptopd505.fenrus.org> <43590B23.2090101@csc.ncsu.edu> <C6F7B216-66B3-4848-9423-05AB4D826320@mac.com> <43591307.5050507@csc.ncsu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43591307.5050507@csc.ncsu.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2005 at 12:10:47PM -0400, Vincent W. Freeh wrote:
> First, thanks for all the help and attention.  I am learning much.
> 
> I think the focus of this discussion should be on mprotect.  I 
> understand that spec says it only works on mmap'd memory.  So does 
> malloc use mmap?  If not why does it work at all?

_Sometimes_ malloc() uses mmap, and _sometimes_ it doesn't (it will
use memory by adjust the brk pointer).  This can be adjusted via
various tuning parameters to malloc.  I suggest you read the info
documentation for glibc's malloc() and mallopt() calls.  (Note that
mallopt parameters are non-portable, and may not apply if you are
using another OS, another version of glibc, or if you have replaced
the malloc with another implementation --- as some application writers
might do.)

Bottom line is you must not count on the type of memory returned by
malloc().  It is given the freedom in the specifications to use
whatever free memory it deems most likely to provide better
application performance.  An application which is willing to be
malloc() specific can use various interfaces to tune various
malloc()'s behavior for performance reasons.

						- Ted
