Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVAZXKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVAZXKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVAZXKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:10:24 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:51843 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S262426AbVAZRGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:06:00 -0500
Date: Wed, 26 Jan 2005 18:05:56 +0100
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: linux-os <linux-os@analogic.com>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
Message-ID: <20050126170556.GF23182@speedy.student.utwente.nl>
Mail-Followup-To: linux-os <linux-os@analogic.com>,
	Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	James Antill <james.antill@redhat.com>,
	Bryn Reeves <breeves@redhat.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 11:38:15AM -0500, linux-os wrote:
> On Wed, 26 Jan 2005, Rik van Riel wrote:
> 
> >With some programs the 2.6 kernel can end up allocating memory
> >at address zero, for a non-MAP_FIXED mmap call!  This causes
> >problems with some programs and is generally rude to do. This
> >simple patch fixes the problem in my tests.
> 
> Does this mean that we can't mmap the screen regen buffer at
> 0x000b8000 anymore?

If you would have looked inside mmap.c, you would have seen that his check
is executed *after* trying for a specific address if it was given. Mmapping
0x000b8000 should still work. I don't know if this patch was very clean (it
probably isn't) but what it's supposed to do is only fail if no specific
address has been given to it.

> How do I look at the real-mode interrupt table starting at
> offset 0? You know that the return value of mmap is to be
> checked for MAP_FAILED, not for NULL, don't you?
> 
> What 'C' standard do you refer to? Seg-faults on null pointers
> have nothing to do with the 'C' standard and everything to
> do with the platform.

Oh come on. Every normal program checks whether a variable has been allocated
or not by comparing it to NULL. I have no knowledge of the internals of glibc
though, and wouldn't know whether this should be handled inside the kernel or
if having it checked in glibc and userspace programs that use mmap directly
should be enough, but AFAIK every C coder assumes that NULL pointers point to
nothing.

    Sytse
