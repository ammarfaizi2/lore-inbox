Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbVICE3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbVICE3A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 00:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbVICE3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 00:29:00 -0400
Received: from codepoet.org ([166.70.99.138]:41123 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1161127AbVICE27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 00:28:59 -0400
Date: Fri, 2 Sep 2005 22:28:59 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Message-ID: <20050903042859.GA30101@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfapgu$dln$1@terminus.zytor.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Sep 03, 2005 at 12:07:58AM +0000, H. Peter Anvin wrote:
> Followup to:  <20050902235833.GA28238@codepoet.org>
> By author:    Erik Andersen <andersen@codepoet.org>
> In newsgroup: linux.dev.kernel
> > 
> > <uClibc maintainer hat on>
> > That would be wonderful.
> > </off>
> > 
> > It would be especially nice if everything targeting user space
> > were to use only all the nice standard ISO C99 types as defined
> > in include/stdint.h such as uint32_t and friends...
> > 
> 
> Absolutely not.  This would be a POSIX namespace violation; they
> *must* use double-underscore types.

I assume you are worried about the stuff under asm that ends up
being included by nearly every header file in the world.  Of
course asm must use double-underscore types.  But the thing is,
the vast majority of the kernel headers live under
linux/include/linux/ and do not use double-underscore types, they
use kernel specific, non-underscored types such as s8, u32, etc.
My copy of IEEE 1003.1 and my copy of ISO/IEC 9899:1999 both fail
to prohibit using the shiny new ISO C99 type for the various
#include <linux/*> header files, which is what I was suggesting.

The world would be so much nicer a place if user space were free
to #include linux/* header files rather than keeping a
per-project private copy of all kernel structs of interest.  And
where these kernel headers would #include stdint.h and define
their stucts in terms of ISO C99 types.  I see nothing at all in
the standards preventing such a change,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
