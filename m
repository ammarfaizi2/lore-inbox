Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbWGTDqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWGTDqU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 23:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWGTDqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 23:46:20 -0400
Received: from bay0-omc2-s19.bay0.hotmail.com ([65.54.246.155]:19541 "EHLO
	bay0-omc2-s19.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S932557AbWGTDqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 23:46:19 -0400
Message-ID: <BAY104-DAV11BD5C0159C7CD7BA10CA3ED610@phx.gbl>
X-Originating-IP: [220.245.180.132]
X-Originating-Email: [getshorty_@hotmail.com]
From: "Shorty Porty" <getshorty_@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Cc: <ricknu-0@student.ltu.se>
Subject: RE: [RFC][PATCH] A generic boolean
Date: Thu, 20 Jul 2006 13:53:27 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcarqWdyq8pNTZ49S+ymT+PfaersQgABnOeA
In-Reply-To: <Pine.LNX.4.58.0607192003030.20069@shell3.speakeasy.net>
X-OriginalArrivalTime: 20 Jul 2006 03:46:18.0909 (UTC) FILETIME=[0F3054D0:01C6ABAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone showed code like

  _Bool foo = 42;

and if we were to make the compiler warn about it that would mean we are
basically trying to change/manipulate the standard (I'm guessing). It's
probably not in the standard because it's such a moot point. However if we
were to use

  if(foo)
  {
    ...
  }

we'd see it was true. That's because 
  FALSE == 0
and
  TRUE == !FALSE (i.e. any value that isn't 0)

from the compiler's standpoint. Function that return 'true' for an integer
type (as opposed to a C++ standard-type bool) should be tested like

  if(SomeFunction())

or
  if(!SomeFunction())

instead of testing for equality

  if(SomeFunction() == TRUE)
of
  if(SomeFunction() == FALSE)

as the former (IMO) is as readable, if not more readable as the latter, and
it's likely to get optimised better. That and someone might give true AND
return a status by returning neither 0 or 1, in which case 

  if(... == TRUE)

would fail, as TRUE == 1.

And just as a note, you really should read the documentation (at least once)
for any function you use, and therefore know if it returns {FALSE, TRUE, ...
, TRUE} or {OK, ERR1, ERR2, ..., ERRn}

> > If this is the case, then wouldn't "long" be preferable to "int"?

Meh, it's all the same. I don't think 3 wasted CPU cycles is going to worry
anyone too much. Hell, sometimes int IS long, though I might be wrong there.


P.S. First post! Hello everybody.
