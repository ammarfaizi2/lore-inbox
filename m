Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbSAEUCU>; Sat, 5 Jan 2002 15:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281504AbSAEUCK>; Sat, 5 Jan 2002 15:02:10 -0500
Received: from mail.s.netic.de ([212.9.160.11]:47889 "EHLO mail.netic.de")
	by vger.kernel.org with ESMTP id <S280975AbSAEUCC>;
	Sat, 5 Jan 2002 15:02:02 -0500
To: jkl@miacid.net
Cc: "Joseph S. Myers" <jsm28@cam.ac.uk>, dewar@gnat.com,
        Dautrevaux@microprocess.com, paulus@samba.org,
        Franz.Sirl-kernel@lauterbach.com, benh@kernel.crashing.org,
        gcc@gcc.gnu.org, jtv@xs4all.nl, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, minyard@acm.org, rth@redhat.com,
        trini@kernel.crashing.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <Pine.BSI.4.10.10201051111100.8542-100000@hevanet.com>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Sat, 05 Jan 2002 21:01:11 +0100
In-Reply-To: <Pine.BSI.4.10.10201051111100.8542-100000@hevanet.com>
 (jkl@miacid.net's message of "Sat, 5 Jan 2002 11:25:26 -0800 (PST)")
Message-ID: <87ofk88t4o.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jkl@miacid.net writes:

> An arbitrary integer may be converted to a pointer.  
>    ^^^^^^^^^

This rule exists so that implementations are not forced to issue a
diagnostic for (char *)1.

> 	I interpret this to mean that one MAY use integer arithmatic to
> do move a pointer outside the bounds of an array.  Specifically, as soon
> as I've cast the pointer to an integer, the compiler has an obligation to
> forget any assumptions it makes about that pointer.  This is what casts
> from pointer to integer are for!  when i say (int)p I'm saying that I
> understand the address structure of the machine and I want to manipulate
> the address directly.

According to the standard, you say that you want to cast p to type
int.  You cannot manipulate machine addresses in C because C is
defined as a high-level language, without backdoors to such low-level
concepts as machine addresses.

The fact that quite a few implementations traditionally provide
such backdoors in some cases does not mean that the C language is a
low-level language, or that all implementations (even future ones)
have to provide these backdoors.

> 	If the satandard has changed so this is no longer possible, there
> NEEDS to be some other way in the new standard to express the same
> concept, or large application domains where C is currently in use will
> stop working.  

I don't think there are fundamental and conceptual changes in C99 in
this area.  Even with previous C reversions, you should have read the
compiler manual carefully before doing address arithmetic.
