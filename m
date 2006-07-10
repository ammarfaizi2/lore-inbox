Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbWGJWFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWGJWFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965254AbWGJWFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:05:07 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:32193 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965059AbWGJWFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:05:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uEc6v+RiaEURIWZ+7iSV0JMBy14RGyoidvDAk6hLIROff70Lp8Tqmcy4D8Vid5crr2HbKNdoc14xxSUP3GTAaZcmSUDe/MynDb/Uw5dYuGZpcFx39oSlkEzGkEtGvzU/359kxggE+kc6cFKgB+9MoHEIQK8RGxn0ft6TvkjwFYk=
Message-ID: <e1e1d5f40607101505peb27581n729bcb14842d2956@mail.gmail.com>
Date: Mon, 10 Jul 2006 18:05:05 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: Automatic Kernel Bug Report
Cc: "Pavel Machek" <pavel@ucw.cz>, "Adrian Bunk" <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200607101759.k6AHxbda012403@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com>
	 <20060709125805.GF13938@stusta.de>
	 <e1e1d5f40607091146s2f8e6431v33923f38c6d10539@mail.gmail.com>
	 <20060709191107.GN13938@stusta.de>
	 <e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com>
	 <200607092019.k69KJt66005527@turing-police.cc.vt.edu>
	 <e1e1d5f40607091327y3db1cbdco89ebdb04cda60ce0@mail.gmail.com>
	 <20060710081131.GA2251@elf.ucw.cz>
	 <e1e1d5f40607101040u3baf0da7r43d5538700b02e2@mail.gmail.com>
	 <200607101759.k6AHxbda012403@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Mon, 10 Jul 2006 12:40:07 CDT, Daniel Bonekeeper said:
>
> > real bugs. If so, they get reported here on LKML. Since we can expect,
> > maybe, dozens of thousands of reports per week, wouldn't be hard to
> > distinct between real bugs, etc (if we use frequency as a marker).
>
> Actually, at that level, it *is* hard to distinguish.  I'm sure the RedHat
> people have a *very* good idea of exactly how much PEBKAC cruft their bugzilla
> gathers - and that's from users clued enough to bugzilla.

I believe that people on distros are already very busy solving
problems with the whole distro (thousands of programs, libraries,
etc). They have their kernel guys, they hack their own kernels, etc,
and they are very distro-specific. This tool I intend to be a generic
solution, kernel-only thing. Hopefully we could get distros to
incorporate these reports to their kernels (or point the kernel report
system to them and mirror the reports to our central server). I'm a
little concerned about receiving reports from distro-modded kernels,
since they may not be easily debugged. Anyways, the system will take
account of the fact that the kernel is or isn't a vanilla, and we can
filter that easily, so there's no problem on that.


> It might be interesting to use it to measure how many machines crap out because
> of stray single-bit errors due to insufficient ECC on the hardware.

That's a good example. Another example: a little while ago
(http://lkml.org/lkml/2006/7/1/70) Daniel Drake from Gentoo was
reporting a problem where page_mapcount(page) was getting negative. As
it turned out, it was related with a nVidia proprietary driver that
the machine was running. With the system, we just needed to search for
"Eeek! page_mapcount(page) went negative! (-1)" on kernels 2.6.16.19
(maybe too generic), and he would see that lots of people reporting
that has, between other things, nVidia drivers running. It's already a
clue on where to start looking for. The same applies for lots of other
stuff.

The main difference here, is that the system isn't passive as a
bugzilla. The system could gather information about those bug reports
and start working on them, finding relations and pointing out
relations between the bug, the hardware and the kernel configuration.

> You can't use "a sudden upsurge" in reports as a good regression test, because
> the vast majority of boxes are running distro kernels.  RHEL 4.0 just shipped a
> 2.6.9-34 kernel.  Ubuntu is on a 2.6.15.
>

I agree with you on that. In this case, we can consider just vanilla
users (or RedHat people can do this comparison between their released
kernels, even though the focus of this system isn't distros, but
vanilla kernels). Another thing to point out is that Slackware users,
for example, run on vanilla kernels (even though slackware 10.2 is
shipping with 2.6.13, people usually update to the latest one). But
really, unless people use -mm kernels or release candidates, surges
can't really be used to detect regressions. But this tool would still
be useful to detect regressions after they are on the wild for a while
(for example, people with the latest stable 2.6.17.4 are getting
problems with via_sata that they weren't getting before with the same
hardware (here we can discuss how to detect, if possible, if it's a
regression or a new bug)).

> And the people who are using kernel.org kernels aren't actually upgrading all
> *that* fast either.  You'll get better info by looking at the lkml postings
> that say '2.6.mumble regressed my foobar' - that will likely trigger before any
> statistical tendency in bug reports gets noticed.

Agreed.

> (Visit the bugzilla.mozilla.org, and note that neither 'most frequently
> reported' nor 'reported today' give you a really good grasp on *current*
> issues....)

I don't think that I understand that correctly, but the way I see, if
bugs don't get fixed, they are still "current issues". Everything
depends on the complexity of the statistical engine that the system
will use. If it detects that people are reporting Oopses frequently on
sata_via and a 2.6.10 kernel, but with newer kernels the bug isn't
reported, it will disconsider this issue (even though it continues on
the database, so regressions can be detected).

Daniel

-- 
What this world needs is a good five-dollar plasma weapon.
