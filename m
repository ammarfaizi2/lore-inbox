Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132535AbRDWW7M>; Mon, 23 Apr 2001 18:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132536AbRDWW67>; Mon, 23 Apr 2001 18:58:59 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:16913 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132511AbRDWW5V>;
	Mon, 23 Apr 2001 18:57:21 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] MOD_INC/MOD_DEC: useful to check for correct usage? 
In-Reply-To: Your message of "Wed, 04 Apr 2001 18:25:08 PDT."
             <200104050125.SAA21252@csl.Stanford.EDU> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Apr 2001 08:57:14 +1000
Message-ID: <12667.988066634@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2001 18:25:08 -0700 (PDT), 
Dawson Engler <engler@csl.Stanford.EDU> wrote:
>in the old days you couldn't call a sleeping function in a module
>before doing a MOD_INC or after doing a MOD_DEC.  Then some safety nets
>were added that made these obsolete (in some number of places).  I was
>told that people had decided to potentially get rid of all safety
>nets.  Is this true?  Is it worthwhile to have a checker for these two
>rules?

I expect to reintroduce the MOD_{INC,DEC} rules in 2.5.  Al Viro's
patches to bump the module use count in the caller work up to a point
but they are not a complete fix.  You cannot bump the module use count
from an interrupt, which causes problem for netfilter (ask Rusty for
details).

A module can have multiple associated areas including the code segment,
the exception table and arch specific data like the IA64 unwind lists.
Al Viro's fix does not cover all of these areas, Alan Cox added a
spinlock for the exception table but nothing covers the arch specific
data.  Adding more spinlocks is not the answer, it penalizes the
mainline code to guard against an unusual event (module unload).


