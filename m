Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbVLVG0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVLVG0T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 01:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVLVG0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 01:26:19 -0500
Received: from mverd138.asia.info.net ([61.14.31.138]:51286 "EHLO
	kao2.melbourne.sgi.com") by vger.kernel.org with ESMTP
	id S932437AbVLVG0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 01:26:18 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Matthew Wilcox <matthew@wil.cx>
cc: Mark Maule <maule@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 3/4] per-platform IA64_{FIRST,LAST}_DEVICE_VECTOR definitions 
In-reply-to: Your message of "Wed, 21 Dec 2005 12:32:20 PDT."
             <20051221193220.GF2361@parisc-linux.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 Dec 2005 17:26:12 +1100
Message-ID: <8995.1135232772@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2005 12:32:20 -0700, 
Matthew Wilcox <matthew@wil.cx> wrote:
>On Wed, Dec 21, 2005 at 01:18:43PM -0600, Mark Maule wrote:
>> Ok.  Was just following the lead of this:
>> 
>> static struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };
>> 
>> So arrays are always init'd to zero?
>
>Static variables without an initialiser go to the bss section and get
>initialised to 0 by the loader.  So the initialisation above is
>redundant on all machines which use a bitpattern of zeros to represent
>the NULL pointer.  Which is all machines Linux runs on.

Semi off topic nit pick.  C99 standard, section 6.7.8, note 10.

"... If an object that has static storage duration is not initialized
explicitly, then:

— if it has pointer type, it is initialized to a null pointer;
— if it has arithmetic type, it is initialized to (positive or
  unsigned) zero;
— if it is an aggregate, every member is initialized (recursively)
  according to these rules;
— if it is a union, the ﬁrst named member is initialized
  (recursively) according to these rules."

On the off chance that Linux is ever implemented on a machine that does
not use zeroes for a NULL pointer, it would be the compiler's job to
correctly initialise a pointer or array of pointers.

