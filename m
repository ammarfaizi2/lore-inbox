Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266457AbRGCHzi>; Tue, 3 Jul 2001 03:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266470AbRGCHz2>; Tue, 3 Jul 2001 03:55:28 -0400
Received: from t2.redhat.com ([199.183.24.243]:48630 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S266457AbRGCHzS>; Tue, 3 Jul 2001 03:55:18 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dhowells@redhat.com (David Howells), jes@sunsite.dk (Jes Sorensen),
        dwmw2@redhat.com, linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions 
In-Reply-To: Your message of "Mon, 02 Jul 2001 17:20:26 BST."
             <E15H6R1-00066U-00@the-village.bc.nu> 
Date: Tue, 03 Jul 2001 08:55:16 +0100
Message-ID: <3911.994146916@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The question I think being ignored here is. Why not leave things as is. The
> multiple bus stuff is a port specific detail hidden behind readb() and
> friends.

This isn't so much for the case where the address generation is done by a
simple addition. That could be optimised away by the compiler with an entirely
inline function (as per David Woodhouse's suggestion).

It's far more important for non-x86 platforms which only have a single address
space and have to fold multiple external address spaces into it.

For example, one board I've got doesn't allow you to do a straight
memory-mapped I/O access to your PCI device directly, but have to reposition a
window in the CPU's memory space over part of the PCI memory space first, and
then hold a spinlock whilst you do it.

David
