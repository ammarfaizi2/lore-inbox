Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWF0LnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWF0LnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWF0LnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:43:03 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:5854 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S932243AbWF0LnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:43:01 -0400
Subject: Re: [PATCH] Remove extra local_bh_disable/enable from arch
	do_softirq
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, mingo@elte.hu, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <17566.32236.368906.227113@cargo.ozlabs.ibm.com>
References: <17566.32236.368906.227113@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 27 Jun 2006 13:43:09 +0200
Message-Id: <1151408589.5390.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 22:13 +1000, Paul Mackerras wrote:
> At the moment, powerpc and s390 have their own versions of do_softirq
> which include local_bh_disable() and __local_bh_enable() calls.  They
> end up calling __do_softirq (in kernel/softirq.c) which also does
> local_bh_disable/enable.
> 
> Apparently the two levels of disable/enable trigger a warning from
> some validation code that Ingo is working on, and he would like to see
> the outer level removed.  But to do that, we have to move the
> account_system_vtime calls that are currently in the arch do_softirq()
> implementations for powerpc and s390 into the generic __do_softirq()
> (this is a no-op for other archs because account_system_vtime is
> defined to be an empty inline function on all other archs).  This
> patch does that.

Nod, Heiko stumbled over that one as well as he ported the lock
validator patch. Moving the account_system_vtime call is the correct
solution.
 
-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


