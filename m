Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289495AbSAJP3I>; Thu, 10 Jan 2002 10:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289496AbSAJP27>; Thu, 10 Jan 2002 10:28:59 -0500
Received: from mail.s.netic.de ([212.9.160.11]:44808 "EHLO mail.netic.de")
	by vger.kernel.org with ESMTP id <S289495AbSAJP2m>;
	Thu, 10 Jan 2002 10:28:42 -0500
To: ertr1013@student.uu.se
Cc: Dautrevaux@microprocess.com, pkoning@equallogic.com, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, mrs@windriver.com, dewar@gnat.com
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020110121845.91AD8F317E@nile.gnat.com>
	<20020110123711.GA745@student.uu.se>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Thu, 10 Jan 2002 16:27:29 +0100
In-Reply-To: <20020110123711.GA745@student.uu.se> (Erik Trulsson's message
 of "Thu, 10 Jan 2002 13:37:11 +0100")
Message-ID: <87bsg2usym.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Trulsson <ertr1013@student.uu.se> writes:

> The compiler is not free to do only one load there if v is declared
> volatile.
> The relevant part of the C standard would be the following paragraph:
>
> [6.7.3]
>        [#6] An object  that  has  volatile-qualified  type  may  be
>        modified in ways unknown to the implementation or have other
>        unknown side effects.  Therefore any expression referring to
>        such  an object shall be evaluated strictly according to the
>        rules of the abstract  machine,  as  described  in  5.1.2.3.
>        Furthermore,  at  every sequence point the value last stored
>        in the object  shall  agree  with  that  prescribed  by  the
>        abstract  machine, except as modified by the unknown factors
>        mentioned previously.105)  What constitutes an access to  an
>        object  that  has volatile-qualified type is implementation-
>        defined.

And 5.1.2.3 states:

       [#2]  Accessing  a  volatile  object,  modifying  an object,
       modifying a file, or calling a function  that  does  any  of
       those  operations are all side effects,11) which are changes
       in the state of the execution environment.  Evaluation of an
       expression  may  produce side effects.  At certain specified
       points in the execution sequence called sequence points, all
       side  effects  of previous evaluations shall be complete and
       no side effects of subsequent evaluations shall  have  taken
       place.   (A summary of the sequence points is given in annex
       C.)

So it seems to be obvious ;-) that the compiler must not remove
seemingly unnecessary references to volatile objects.
