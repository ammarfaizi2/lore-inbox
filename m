Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSLUPxU>; Sat, 21 Dec 2002 10:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbSLUPxU>; Sat, 21 Dec 2002 10:53:20 -0500
Received: from mnh-1-28.mv.com ([207.22.10.60]:32004 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S261599AbSLUPxU>;
	Sat, 21 Dec 2002 10:53:20 -0500
Message-Id: <200212211605.LAA01502@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: John Reiser <jreiser@BitWagon.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Julian Seward <jseward@acm.org>
Subject: Re: Valgrind meets UML 
In-Reply-To: Your message of "20 Dec 2002 23:32:21 PST."
             <1040455941.1841.123.camel@ixodes.goop.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 21 Dec 2002 11:05:25 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeremy@goop.org said:
> The main problem will be that newly allocated memory will still be
> considered initialized by its previous owner.  Also, if UML allocates
> memory using mmap, all memory will be considered to be initialized.

What I was doing was having kfree and free_pages set the freed object to
noaccess.  Presumably, that tells valgrind to consider the memory 
uninitialized.

Presumably, that will also cause errors from inside the allocator if it
touches that memory at all before it's allocated again.

				Jeff

