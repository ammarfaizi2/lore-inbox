Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbREYSiO>; Fri, 25 May 2001 14:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbREYSiE>; Fri, 25 May 2001 14:38:04 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:57867 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S261502AbREYSht>; Fri, 25 May 2001 14:37:49 -0400
Date: Fri, 25 May 2001 11:37:48 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Jonathan Lundell <jlundell@pobox.com>
cc: Andi Kleen <ak@suse.de>, Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        Keith Owens <kaos@ocs.com.au>, Andreas Dilger <adilger@turbolinux.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
In-Reply-To: <p05100308b73439980162@[207.213.214.37]>
Message-ID: <Pine.LNX.4.33.0105251130040.17081-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001, Jonathan Lundell wrote:

> At 8:45 AM -0700 2001-05-25, dean gaudet wrote:
> >i think it really depends on how you use current -- here's an alternative
> >usage which can fold the extra addition into the structure offset
> >calculations, and moves the task struct to the top of the stack.
> >
> >not that this really solves anything, 'cause a stack underflow will just
> >trash something else rather than the task struct :)
>
> It would open the door for putting a guard page (which only occupies
> virtual space, after all) below the stack. I have no idea whether
> that's practical, given other constraints, but it's a potential
> benefit of having the stack at the bottom rather than the top of a
> page.

somewhere else in the thread someone indicated this was a hard thing to
do.

also you don't need the task struct at the top to do this -- you just
allocate 16k instead of 8k, put the task struct on page 0 of the
allocation, unmap page 1, and put the stack frame on pages 2 and 3.
(you'd probably have to do a 16k allocation regardless to get the guard
page.)

-dean

