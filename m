Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbSLCCds>; Mon, 2 Dec 2002 21:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265974AbSLCCds>; Mon, 2 Dec 2002 21:33:48 -0500
Received: from 209.0.102.129.sm.libritas.com ([209.0.102.129]:20085 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S265960AbSLCCdr> convert rfc822-to-8bit;
	Mon, 2 Dec 2002 21:33:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dragan Stancevic <visitor@xalien.org>
To: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] LSM fix for stupid "empty" functions
Date: Mon, 2 Dec 2002 18:37:52 -0800
User-Agent: KMail/1.4.3
References: <20021201083056.GJ679@kroah.com> <20021201172156.A17028@infradead.org> <20021201182644.GD8829@kroah.com>
In-Reply-To: <20021201182644.GD8829@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212021837.52312.visitor@xalien.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 December 2002 10:26, Greg KH wrote:
> On Sun, Dec 01, 2002 at 05:21:56PM +0000, Christoph Hellwig wrote:
> > On Sun, Dec 01, 2002 at 10:12:27AM -0800, Greg KH wrote:
> > > Does the kernel work if data structures are in ROM?  I would think that
> > > lots of variables in the kernel would have this problem :)
> >
> > The nommu ports support .text in rom.
>
> But doesn't initialized variables live in .bss?  So we should be ok,
> right?

Greg-

not that I am trying to be a PITA but where did you get the information that 
initialized variables live in .bss?

Initialized variables live in .data, the .bss (Block Started by Symbol) is 
reserved for non-initialized variables.

Look:
visitor@satelite:~> cat a.c
int first_var;
int second_var = 5;
visitor@satelite:~> gcc -S a.c
visitor@satelite:~> cat a.s
        .file   "a.c"
.globl second_var
        .data
        .align 4
        .type   second_var,@object
        .size   second_var,4
second_var:
        .long   5
        .comm   first_var,4,4
        .ident  "GCC: (GNU) 3.2"
visitor@satelite:~>

-- 
Peace can only come as a natural consequence
of universal enlightenment. -Dr. Nikola Tesla
