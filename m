Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261472AbTCTO3t>; Thu, 20 Mar 2003 09:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261484AbTCTO3t>; Thu, 20 Mar 2003 09:29:49 -0500
Received: from mailrelay1.lanl.gov ([128.165.4.101]:41654 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S261472AbTCTO3p>; Thu, 20 Mar 2003 09:29:45 -0500
Subject: Re: 2.5.65-mm2
From: Steven Cole <elenstev@mesatop.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <200303192327.45883.tomlins@cam.org>
References: <20030319012115.466970fd.akpm@digeo.com>
	<20030319163337.602160d8.akpm@digeo.com>
	<1048117516.1602.6.camel@spc1.esa.lanl.gov> 
	<200303192327.45883.tomlins@cam.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 20 Mar 2003 07:36:12 -0700
Message-Id: <1048170972.4302.119.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-19 at 21:27, Ed Tomlinson wrote:
> On March 19, 2003 06:45 pm, Steven P. Cole wrote:
> > On Wed, 2003-03-19 at 17:33, Andrew Morton wrote:
> > > "Steven P. Cole" <elenstev@mesatop.com> wrote:
> > > > > Summary: using ext3, the simple window shake and scrollbar wiggle
> > > > > tests were much improved, but really using Evolution left much to be
> > > > > desired.
> > > >
> > > > Replying to myself for a followup,
> > > >
> > > > I repeated the tests with 2.5.65-mm2 elevator=deadline and the
> > > > situation was similar to elevator=as.  Running dbench on ext3, the
> > > > response to desktop switches and window wiggles was improved over
> > > > running dbench on reiserfs, but typing in Evolution was subject to long
> > > > delays with dbench clients greater than 16.
> > >
> > > OK, final question before I get off my butt and find a way to reproduce
> > > this:
> > >
> > > Does reverting
> > >
> > > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.65/2.5.65-mm2/broken-ou
> > >t/sched-2.5.64-D3.patch
> > >
> > > help?
> >
> > Sorry, didn't have much time for a lot of testing, but no miracles
> > occurred.  With 5 minutes of testing 2.5.65-mm2 and dbench 24 on ext3
> > and that patch reverted (first hunk had to be manually fixed), I don't
> > see any improvement.  Still the same long long delays in trying to use
> > Evolution.
> 
> Steven,
> 
> Do things improve with the patch below applied?  You have to backout the 
> schedule-tuneables patch before appling it.
> 
> Ed Tomlinson

[patch snipped]

I tried that patch, and the bad behavior with the Evolution "Compose a
Message" window remains.  With a load of dbench 12, I had stalls of many
seconds before I could type something.  Also, here is an additional
symptom.  If I move the Evolution "Compose" window around rapidly, it
leaves a smear of itself on the screen under itself.  With all -mm2
variants, this smear stays for an intolerably long time (tens of
seconds) while that window does not record keyboard strokes.  2.5.65-bk
on the other hand exhibits much more benign behavior.  Under similar
load, the smear disappears in a few seconds and the window starts
responding to keyboard events.  I just now rebooted 2.5-bk to verify,
and it is still responsive at dbench client loads which would make
Evolution unusable with 2.5.65-mm2.  Mozilla, on the other hand, still
works OK under load with -mm2.  This was all with dbench running on
ext3.

I won't be able to do any more testing for several hours, so have fun!

Steven

