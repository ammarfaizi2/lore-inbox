Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263049AbRFJCOQ>; Sat, 9 Jun 2001 22:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263118AbRFJCOG>; Sat, 9 Jun 2001 22:14:06 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:15492 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S263049AbRFJCNt>;
	Sat, 9 Jun 2001 22:13:49 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200106100213.TAA18780@csl.Stanford.EDU>
Subject: Re: [CHECKER] security rules?  (and 2.4.5-ac4 security bug)
To: tytso@mit.edu (Theodore Tso)
Date: Sat, 9 Jun 2001 19:13:36 -0700 (PDT)
Cc: hlein@progressive-comp.com (Hank Leininger), linux-kernel@vger.kernel.org,
        alan@redhat.com
In-Reply-To: <20010609140718.A2570@think.thunk.org> from "Theodore Tso" at Jun 09, 2001 02:07:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Indeed; the bug in the uuid_strategy which you pointed out in the
> random driver wasn't caused by the fact that we were using a
> user-specified length (since the length was being capped to a maximum
> value of 16).  The security bug was that the test was done on a signed
> value, and copy_to_user() takes an unsigned value.
> 
> So your checker found a real bug, but it wasn't the one that the
> checker thought it was.  :-)

No, it was the bug the checker thought it was: a signed integer from
user space that had only been upper-bound checked.  If the value had
been unsigned, or had been checked in a range lower_bound < x <
upper_bound there woulnd't have been a message.

But I certainly concede that the message could be more informative.

Dawson
