Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbVCaA6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVCaA6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 19:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVCaA6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 19:58:35 -0500
Received: from smtpout.mac.com ([17.250.248.83]:52690 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262677AbVCaA6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 19:58:23 -0500
In-Reply-To: <20050330233825.GS17420@devserv.devel.redhat.com>
References: <200503300125.j2U1PFQ9005082@laptop11.inf.utfsm.cl> <OofSaT76.1112169183.7124470.khali@localhost> <d2er4p$qp$1@sea.gmane.org> <424AFA98.9080402@grupopie.com> <aae129062f1e3992c8ec025d5f239be9@mac.com> <20050330233825.GS17420@devserv.devel.redhat.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e8fc51864bab0a24b04af9867d748f5f@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Paulo Marques <pmarques@grupopie.com>, akpm@osdl.org,
       Shankar Unni <shankarunni@netscape.net>, linux-kernel@vger.kernel.org,
       bunk@stusta.de, khali@linux-fr.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Not a GCC bug (was Re: Big GCC bug!!! [Was: Re: Do not misuse Coverity please])
Date: Wed, 30 Mar 2005 19:58:01 -0500
To: Jakub Jelinek <jakub@redhat.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 30, 2005, at 18:38, Jakub Jelinek wrote:
> This testcase violates ISO C99 6.3.2.3:
> If a null pointer constant is converted to a pointer type, the 
> resulting
> pointer, called a null pointer, is guaranteed to compare unequal to a
> pointer to any object or function.

Except that the result of dereferencing a null pointer is implementation
defined according to the C99 standard.  My implementation allows me to 
mmap
stuff at NULL, and therefore its compiler should be able to handle that
case.  I would have no problem with either the standard or 
implementation
if it either properly handled the case or didn't allow it in the first
place.

On another note, I've discovered the flag 
"-fno-delete-null-pointer-checks",
which should probably be included in the kernel makefiles to disable 
that
optimization for the kernel.  (Ok, yes, I apologize, this isn't really 
a GCC
bug, the behavior is documented, although it can be quite confusing.  I
suspect it may bite some platform-specific code someday.  It also 
muddies
the waters somewhat with respect to the original note (and the effects 
on
the generated code):

> int x = my_struct->the_x;
> if (!my_struct) return;

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


