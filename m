Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVI2F2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVI2F2O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 01:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVI2F2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 01:28:14 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:51215 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S1750759AbVI2F2O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 01:28:14 -0400
Subject: RE: Registering for multiple SIGIO within a process
From: Ray Lee <ray-lk@madrabbit.org>
To: "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>
Cc: "Bhattacharjee, Satadal" <Satadal.Bhattacharjee@engenio.com>,
       linux-kernel@vger.kernel.org,
       "Patro, Sumant" <Sumant.Patro@engenio.com>,
       "Ram, Hari" <hari.ram@engenio.com>,
       "Mukker, Atul" <Atul.Mukker@engenio.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57060CD1F1@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E57060CD1F1@exa-atlanta>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Wed, 28 Sep 2005 22:28:08 -0700
Message-Id: <1127971689.25462.67.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 00:09 -0400, Bagalkote, Sreenivas wrote:
> select() is not asynchronous to the app (like a signal handler is).

(Way off topic now, but...)

Correct. Asynchronous to the app is rarely what an app author wants,
though (at least this app author). Asynchronous is the unix version of
throwing an exception in OO languages, which is fine for something
that's exceptional. As for something that one *expects* as a matter of
course (a broken pipe or SIGXFSZ upon a write(), for example), having a
signal arrive out of line from normal processing is a pain, and
needlessly complicates code.

Further, if you took a poll of random self-proclaimed Unix/C hackers, I
bet fewer than 1 in 10 could actually tell you what functions are *safe*
to call inside the handler. (Probably less than half even realize
there's a problem. Better, I bet a large percentage of them don't even
understand the case that they can be introducing race conditions with
signal handlers.)

The common, safe, approach taken by those who do realize that there's an
issue is to just collect the signals as they arrive, and merely perform
a write to transfer it into the main select loop (which, seemingly, most
programs have). The main select() loop then deals with the signals as
events rather than exceptions.

As I mentioned up top, this is straying far off course, and into my
personal software practices. As I'm just some random guy, I'd suggest
ignoring me :-).

For the matter mentioned at top of the email thread, forking a couple
separate processes communicating back to the parent should take care of
the issue of wanting to register for the same signal twice under two
different contexts.

Ray

