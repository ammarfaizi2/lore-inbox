Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVAZXUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVAZXUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVAZXTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:19:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12729 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262455AbVAZR5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:57:55 -0500
Subject: Re: don't let mmap allocate down to zero
From: Bryn Reeves <breeves@redhat.com>
Reply-To: breeves@redhat.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-os@analogic.com, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Antill <james.antill@redhat.com>
In-Reply-To: <41F7D4B0.7070401@nortelnetworks.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>
	 <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
	 <41F7D4B0.7070401@nortelnetworks.com>
Content-Type: text/plain
Organization: Red Hat GLS
Message-Id: <1106762261.10384.30.camel@breeves.surrey.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 26 Jan 2005 17:57:42 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 17:34, Chris Friesen wrote: 
> linux-os wrote:
> 
> > Does this mean that we can't mmap the screen regen buffer at
> > 0x000b8000 anymore?
> > 
> > How do I look at the real-mode interrupt table starting at
> > offset 0? You know that the return value of mmap is to be
> > checked for MAP_FAILED, not for NULL, don't you?
> 
> Can't you still map those physical addresses to other virtual addresses?
> 

I think that's the case. The 0 address as refered to here is only for
the user virtual address space. 

> > What 'C' standard do you refer to? Seg-faults on null pointers
> > have nothing to do with the 'C' standard and everything to
> > do with the platform.
> 
> I believe the ISO/IEC 9899:1999 C Standard explicitly states that 
> dereferencing a null pointer with the unary * operator results in 
> undefined behavior.

Exactly. Undefined. VAX/UNIX allowed assignment to null pointers. BUT
it's now such a commonly held assumption that a null pointer is not
valid that things will break if this is changed. Doesn't glibc malloc
use mmap for small allocations? From the man page:

RETURN VALUE
  For calloc() and malloc(), the value returned is a pointer to the
  allocated  memory,  which  is suitably aligned for any kind of
  variable, or NULL if the request fails.

This could get pretty confusing if NULL was a valid address...

Cheers,

Bryn.

The DBX manual contrasts this behaviour on different systems:
http://acs.ucsd.edu/info/dbx.debug.php


