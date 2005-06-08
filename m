Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVFHD42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVFHD42 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 23:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVFHD42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 23:56:28 -0400
Received: from magic.adaptec.com ([216.52.22.17]:45025 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262094AbVFHD4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 23:56:25 -0400
Date: Wed, 8 Jun 2005 09:38:05 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
To: Peter Staubach <staubach@redhat.com>
cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>,
       <linux-kernel@vger.kernel.org>,
       <linux-arm-kernel@lists.arm.linux.org.uk>
Subject: Re: Zeroed pages returned for heap
In-Reply-To: <42A5C3D2.9010209@redhat.com>
Message-ID: <Pine.LNX.4.44.0506080934440.4569-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 08 Jun 2005 03:55:59.0499 (UTC) FILETIME=[FB1F15B0:01C56BDD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2005, Peter Staubach wrote:

> Nagendra Singh Tomar wrote:
> 
> >Hi all,
> >	The short version first.
> >Is it OK for an application (a C library implementing malloc/calloc is 
> >also an application) to assume that the pages returned by the OS for heap 
> >allocation (either directly thru brk() or thru mmap(MAP_ANONYMOUS)) will 
> >be zero filled. 
> >
> 
> An application which makes assumptions about the contents of newly allocated
> memory would seem to be making very dangerous assumptions.

Thats what glibc does. Ulrich confirmed that. I would say thats not a bad 
optimization on glibc's part as it does not really make sense to zero out 
a memory again in user space if we know for sure that new heap memory that 
kernel hands over to us will be zeroed. I'm not sure though whether this 
is a documented kernel ABI.

> 
> Ignoring that, would it not be considered to be a security violation to hand
> pieces of memory to applications without erasing the old contents of the 
> pages?

I understand that for a desktop/server running Linux but not for an 
embedded box where all the applications that run on the box is controlled 
by you.

Thanx,
Tomar


-- You have moved the mouse. Windows must be restarted for the 
   changes to take effect.

