Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262938AbVBCFIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbVBCFIT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 00:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVBCFHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 00:07:38 -0500
Received: from smtpout.mac.com ([17.250.248.83]:39647 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262280AbVBCFHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 00:07:18 -0500
In-Reply-To: <4201A3B4.2040605@austin.rr.com>
References: <4201A3B4.2040605@austin.rr.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7426AED2-75A1-11D9-9D77-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Please open sysfs symbols to proprietary modules
Date: Thu, 3 Feb 2005 00:07:08 -0500
To: "Jonathan A. George" <jageorge@austin.rr.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 02, 2005, at 23:08, Jonathan A. George wrote:
> As an observation:
>
> The Linux kernel appears to contain the GPL copyright notice.  This
> appears to explicitly releases the right to alter anything in a copy
> written work which shares that copyright notice.  Therefore,  all
> exported symbols would appear to carry equal weight; thus making the
> GPL_ prefix a notation of dubious value.

The EXPORT_SYMBOL_GPL is a license statement to binary module developers
that they are not allowed to use the code in question (by the author).
Changing those is logically similar to changing the license header in
a GPL licensed file from "Licensed under the GNU GPL v2 only" to
"Licensed under the BSD license found here: http://somewhere/".  It
just plain isn't legal to change those without the agreement of all
contributors.

> Furthermore, it seems as if that the copyright might allow changing
> the GPL_ prefix notation to anything including
> BSD_HOOK_FOR_PORTING_DRIVERS_TO_THE_LINUX_KERNEL_ instead.

You could legally change it as long as you document that the symbol
"EXPORT_SYMBOL_BSD_HOOK_FOR_PORTING_DRIVERS_TO_THE_LINUX_KERNEL"
really means that it's licensed under the GPL despite the confusing
name, although even then you are at risk of the author calling foul.
It also doesn't change the licensing restrictions on the symbols.

> It would seem just as surprising if the U.S. courts were to stop
> considering history of enforcement in copyright law as it would if
> they were to start considering in cases of patent law.

One other thing, it technically _isn't_ legal to link any kind of
binary module with the Linux kernel.  The GPL actually indicates
that "linking" *DOES* make a derivative work.  However, Linus and
basically all of the contributors have agreed that the current
"EXPORT_SYMBOL" functions are ok for use by non-GPL modules, but
they refuse to have hooks specifically there for closed-source
modules, and usually require that most new innovative interfaces
are "EXPORT_SYMBOL_GPL"ed instead.

> A paranoid approach it to develop your driver targeted at FreeBSD,
> and then develop a glue layer abstraction for porting to other OS's.
> Then you simply might GPL your glue layer code as a module using
> any symbols you want for your GPL copy written code per the
> observations earlier in this email.

The one major stumbling block is that any code that imports symbols
that are exported via "EXPORT_SYMBOL_GPL" can only legally _export_
symbols using the same, for the reason I stated above.

> In this way you will have created a work with no intrinsic
> dependencies on the Linux kernel which avoids presenting your work
> as an obvious target for those who prefer to spend their time
> looking for targets. :-)

If it's a non-GPL module it _cannot_ legally use EXPORT_SYMBOL_GPLed
symbols, either directly or indirectly, under any circumstances.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


