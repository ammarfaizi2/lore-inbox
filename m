Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278307AbRJMOs3>; Sat, 13 Oct 2001 10:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278312AbRJMOsT>; Sat, 13 Oct 2001 10:48:19 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:31112 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278307AbRJMOsM>; Sat, 13 Oct 2001 10:48:12 -0400
From: "Paul E. McKenney" <pmckenne@us.ibm.com>
Message-Id: <200110131448.f9DEmVR07852@eng4.beaverton.ibm.com>
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Sat, 13 Oct 2001 07:48:30 -0700 (PDT)
Cc: mckenney@eng4.beaverton.ibm.com (Paul E. McKenney),
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20011012141419.4ea534b5.rusty@rustcorp.com.au> from "Rusty Russell" at Oct 12, 2001 01:14:19 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Here are two patches.  The wmbdd patch has been modified to use
>> the lighter-weight SPARC instruction, as suggested by Dave Miller.
>> The rmbdd patch defines an rmbdd() primitive that is defined to be
>> rmb() on Alpha and a nop on other architectures.  I believe this
>> rmbdd() primitive is what Richard is looking for.
>
>Surely we don't need both?  If rmbdd exists, any code needing wmbdd
>is terminally broken?

One or the other.  And at this point, it looks like rmbdd() (or
read_cache_depends()) is the mechanism of choice, given wmbdd()'s
performance on Alpha.

						Thanx, Paul
