Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVBKT6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVBKT6O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 14:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVBKT5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 14:57:43 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:12973 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262324AbVBKT5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 14:57:24 -0500
Subject: Re: 2.6.11-rc3-mm2
From: Lee Revell <rlrevell@joe-job.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Chris Wright <chrisw@osdl.org>,
       "Jack O'Quin" <jack.oquin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <20050211194233.GL15058@waste.org>
References: <20050211082536.GF15058@waste.org>
	 <200502111749.j1BHn4pe021145@localhost.localdomain>
	 <20050211194233.GL15058@waste.org>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 14:57:21 -0500
Message-Id: <1108151842.20365.22.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 11:42 -0800, Matt Mackall wrote:
> On Fri, Feb 11, 2005 at 12:49:04PM -0500, Paul Davis wrote:
> > >RT-LSM introduces architectural problems in the form of bogus API. And
> > 
> > that may be true of LSM, but not RT-LSM in particular. RT-LSM doesn't
> > introduce *any* API whatsoever - it simply allows software to call
> > various existing APIs (mostly from POSIX) and have them not fail as
> > result of not being root and/or not running on a capabilities-enabled
> > kernel without the required caps.
> 
> The API is the parameters to modprobe or sysfs. 
> 

I think you are talking about the API for root to administer it vs. the
(lack of) API for apps to use the RT capabilities.  I think Paul's point
is that we can transparently replace it with something better (IMO the
RT rlimit is better) in the future, and the apps don't have to know
about it at all.  Comparing it to devfs/udev is bogus because those are
way, way more complicated.

> > >it's implemented as an LSM is meaningless if Redhat and SuSE ship it
> > >on by default.
> > 
> > We haven't encouraged anyone to ship anything with it on by default:
> > the idea is for the module to be present and usable, not turned on.
> 
> On as in turned on for build in the kernel config and shipped. But I
> expect people will eventually actually ship it _on_ with a group
> called 'rt' and possibly even put the primary user in there on install
> unless you start slapping some big fat warnings on it. (I just noticed
> the new Debian installer is putting the primary user in audio, cdrom,
> video, etc.)
> 

Sorry, if the distros are so dumb they need a big fat warning to know
that this is not a safe thing to enable by default, at least on anything
you would ever consider a multiuser system, then they get what they
deserve.  If they have half a brain they will use the setgid approach
that Ingo suggested, and only enable this for apps like JACK and
cdrecord that have been farily well audited and can be trusted to use
this feature (for example JACK has the internal watchdog to keep a bad
client from locking the system).  Really it only makes sense for a
distro to enable this if the user selects the "low latency desktop" or
"multimedia desktop" or whatever install option and makes clear that
this profile is NOT suitable for a multiuser system. 

Lee

