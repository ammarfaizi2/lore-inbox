Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272520AbTHMMnt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272540AbTHMMnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:43:49 -0400
Received: from pop.gmx.net ([213.165.64.20]:647 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272520AbTHMMnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:43:42 -0400
Message-Id: <5.2.1.1.2.20030813144306.0198a058@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Wed, 13 Aug 2003 14:47:42 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: WINE + Galciv + 2.6.0-test3-mm1-O15
Cc: gaxt <gaxt@rogers.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200308131334.54598.kernel@kolivas.org>
References: <5.2.1.1.2.20030812193758.0197b9c0@pop.gmx.net>
 <3F38FCBA.1000008@rogers.com>
 <5.2.1.1.2.20030812193758.0197b9c0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_29676046==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_29676046==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 01:34 PM 8/13/2003 +1000, Con Kolivas wrote:
>On Wed, 13 Aug 2003 04:24, Mike Galbraith wrote:
> > At 12:40 AM 8/13/2003 +1000, Con Kolivas wrote:
> > >On Wed, 13 Aug 2003 00:42, gaxt wrote:
> > > > Photoshop 6 (yes, legal owned version) in wine is flawless (as it was
> > > > with 2.6.0-test3)
> > > >
> > > > Galciv plays videos quite smoothly but as soon as I run it it will
> > > > freeze the cursor for 12-15 seconds every half-minute or so even within
> > > > the game itself which is turn-based strategy without a lot of whizbang
> > > > stuff. In the past, the videos would stutter but the game would not
> > > > suffer from more than short pauses now and then.
> > >
> > >Yes, herein lies one of those mysteries that still eludes me but I have
> > > been investigating it. I can now reproduce in other applications what
> > > appears to be the problem - Two cpu hogs, X and evolution for example are
> > > running and evolution is making X the cpu hog. The problem is that X gets
> > > demoted whereas evolution doesn't. Strangely, dropping evolution to nice
> > > +1 or making X -1 seems to change which one gets demoted, and X is now
> > > much smoother. I assume the same thing is happening here between wine and
> > > wineserver, which is why you've seen reversal of priorities in your
> > > previous posts. See if renicing one of them +1 helps for the time being.
> > > I will continue investigating to find out why the heck this happens and
> > > try and fix it.
> > >
> > >Con
> > >
> > >P.S. I've cc'ed MG because he has seen the scheduler do other forms of
> > >trickery and may have thoughts on why this happens.
> >
> > That sounds suspiciously similar to my scenario, but mine requires a third
> > element to trigger.
> >
> > <scritch scritch scritch>
> >
> > What about this?  In both your senario and mine, X is running low on cash
> > while doing work at the request of a client right?  Charge for it.  If X is
> > lower on cash than the guy he's working for, pick the client's pocket...
> > take the remainder of your slice from his sleep_avg for your trouble.  If
> > you're not in_interrupt(), nothing's free.  Similar to Robinhood, but you
> > take from the rich, and keep it :)  He's probably going straight to the
> > bank after he wakes you anyway, so he likely won't even miss it.  Instead
> > of backboost of overflow, which can cause nasty problems, you could try
> > backtheft.
>
>Not a bad idea at all. The working for someone else thing is killing me. Now,
>how to implement...

I had to back up and regroup a bit because of backboost sanity problems 
(wish I could pull those dang fangs, backboost is wonderful otherwise), but 
the attached cured my inversion problem.

         -Mike 
--=====================_29676046==_
Content-Type: application/octet-stream; name="xx.diff";
 x-mac-type="42494E41"; x-mac-creator="5843454C"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="xx.diff"

LS0tIGxpbnV4LTIuNi4wLXRlc3QxLkc4L2tlcm5lbC9zY2hlZC5jLm9yZwlXZWQgQXVnIDEzIDA5
OjE5OjEzIDIwMDMKKysrIGxpbnV4LTIuNi4wLXRlc3QxLkc4L2tlcm5lbC9zY2hlZC5jCVdlZCBB
dWcgMTMgMTQ6NDE6NDIgMjAwMwpAQCAtMzU4LDYgKzM1OCw4IEBACiAKIAlpZiAoc2xlZXBfdGlt
ZSA+IDApIHsKIAkJdW5zaWduZWQgbG9uZyBsb25nIHNsZWVwX2F2ZzsKKwkJdW5zaWduZWQgbG9u
ZyBydW5fdGltZSA9IG5vdyAtIGN1cnJlbnQtPnRpbWVzdGFtcDsKKwkJdW5zaWduZWQgaW50IHNs
aWNlID0gMTAwMDAwMCAqIGN1cnJlbnQtPnRpbWVfc2xpY2U7CiAKIAkJLyoKIAkJICogVGhpcyBj
b2RlIGdpdmVzIGEgYm9udXMgdG8gaW50ZXJhY3RpdmUgdGFza3MuCkBAIC0zODEsNiArMzgzLDIy
IEBACiAJCQlwLT5zbGVlcF9hdmcgPSBzbGVlcF9hdmc7CiAJCQlwLT5wcmlvID0gZWZmZWN0aXZl
X3ByaW8ocCk7CiAJCX0KKwkJLyoKKwkJICogSWYgdGhlIGF3YWtlbmVkIHRhc2sgaGFzIGJlZW4g
YXNsZWVwIGZvciBsb25nZXIgdGhhbiB0aGUKKwkJICogd2FrZXIgaGFzIGhhZCB0aGUgQ1BVIHBs
dXMgcm91bmQtcm9iaW4gdGltZSwgYW5kIGl0IGlzCisJCSAqIGdvaW5nIHRvIHByZWVtcHQsIHRo
ZXJlIGlzIGEgZ29vZCBjaGFuY2UgdGhhdCB0aGUgd2FrZXIKKwkJICogaXMgbm90IGdldHRpbmcg
ZW5vdWdoIENQVSB0byBzZXJ2aWNlIHRoZSBhd2FrZW5lZCB0YXNrIGluCisJCSAqIGEgdGltZWx5
IG1hbm5lciwgYW5kIHRoYXQgdGhpcyBpcyB0aGUgY2F1c2Ugb2YgdGhlIHByZWVtcHQuCisJCSAq
IFRha2Ugc29tZSBvZiB0aGUgcmVzdWx0aW5nIHNsZWVwX3RpbWUgZnJvbSB0aGUgYXdha2VuZWQK
KwkJICogdGFzaywgYW5kIGdpdmUgaXQgdG8gdGhlIHdha2VyLgorCQkgKi8KKwkJaWYgKCFpbl9p
bnRlcnJ1cHQoKSAmJiBwLT5tbSAmJiBjdXJyZW50LT5tbSAmJiBzbGVlcF9hdmcgPgorCQkJCWN1
cnJlbnQtPnNsZWVwX2F2ZyArIHNsaWNlICYmIHNsZWVwX3RpbWUgPiBydW5fdGltZSArCisJCQkJ
KDEwMDAwMDAgKiB0aGlzX3JxKCktPm5yX3J1bm5pbmcgKiBUSU1FU0xJQ0VfR1JBTlVMQVJJVFkp
ICYmCisJCQkJVEFTS19QUkVFTVBUU19DVVJSKHAsIHRhc2tfcnEoY3VycmVudCkpKSB7CisJCQlj
dXJyZW50LT5zbGVlcF9hdmcgKz0gc2xpY2U7CisJCQlzbGVlcF9hdmcgLT0gc2xpY2U7CisJCX0K
IAl9CiB9CiAKQEAgLTE0MTQsNiArMTQzMiw3IEBACiAJCW5leHQtPnRpbWVzdGFtcCA9IG5vdzsK
IAkJcnEtPm5yX3N3aXRjaGVzKys7CiAJCXJxLT5jdXJyID0gbmV4dDsKKwkJbmV4dC0+dGltZXN0
YW1wID0gbm93OwogCiAJCXByZXBhcmVfYXJjaF9zd2l0Y2gocnEsIG5leHQpOwogCQlwcmV2ID0g
Y29udGV4dF9zd2l0Y2gocnEsIHByZXYsIG5leHQpOwo=
--=====================_29676046==_--

