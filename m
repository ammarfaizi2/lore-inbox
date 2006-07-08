Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWGHGYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWGHGYH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 02:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWGHGYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 02:24:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64211 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751299AbWGHGYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 02:24:05 -0400
Date: Sat, 8 Jul 2006 02:23:45 -0400
From: Dave Jones <davej@redhat.com>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk
Subject: Re: Suspend to RAM regression tracked down
Message-ID: <20060708062345.GB3356@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	cpufreq@lists.linux.org.uk
References: <1151837268.5358.10.camel@idefix.homelinux.org> <44A80B20.1090702@goop.org> <1152271537.5163.4.camel@idefix.homelinux.org> <20060707162152.GB3223@redhat.com> <1152312530.14453.16.camel@idefix.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1152312530.14453.16.camel@idefix.homelinux.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 08:48:49AM +1000, Jean-Marc Valin wrote:
 > Le vendredi 07 juillet 2006 à 12:21 -0400, Dave Jones a écrit :
 > > On Fri, Jul 07, 2006 at 09:25:37PM +1000, Jean-Marc Valin wrote:
 > >  > > There was a race in ondemand and conservative which made them lock up on 
 > >  > > resume (possibly only on SMP systems though).  There's a patch for that 
 > >  > > in current -mm, but I suspect there's another problem (still haven't had 
 > >  > > any time to track it down).
 > >  > 
 > >  > OK, I tried the patch with 2.6.17 and it didn't work. My laptop failed
 > >  > to resume on the first try, so it must be something else. Could someone
 > >  > actually have a look at the changes in 2.6.12-rc5-git6 (which happen to
 > >  > be cpufreq-related)? I spend months pinpointing the problem to that
 > >  > version (it's takes several days to reproduce). I'd appreciate if
 > >  > someone could at least have a look at what changed there and maybe fix
 > >  > it.
 > > 
 > > Can you show /proc/cpuinfo for the affected system ?
 > > If it's 15/3/4 or 15/4/1, that would explain why this kernel,
 > > as this was when support for those models got introduced to
 > > speedstep-centrino.
 > 
 > Not sure what's the 15/..., but here's the content:

it was the family, of which yours is 6, so this isn't it.
which means it must be ..

 > > If it's not that, there is a pretty large delta in the ondemand
 > > governor in this update, but I don't see anything blindlingly
 > > obvious from looking over it.
 > 
 > Well, is there some way of doing a bisection over these changes? As far
 > as I know, the problem probably affects all Dell D600 owners, probably
 > others.

If you're prepared to play around with 'git bisect' a little, it shouldn't
take that many iterations, as you've already narrowed it down quite a lot.

$ git bisect start drivers/cpufreq/cpufreq_ondemand.c
$ git bisect bad
$ git bisect good v2.6.12-rc5

should get you most of the way there.

http://www.kernel.org/pub/software/scm/git/docs/git-bisect.html
has more info.

		Dave

-- 
http://www.codemonkey.org.uk
