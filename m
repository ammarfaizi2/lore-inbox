Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291545AbSBHKn0>; Fri, 8 Feb 2002 05:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291542AbSBHKnQ>; Fri, 8 Feb 2002 05:43:16 -0500
Received: from coruscant.franken.de ([193.174.159.226]:35978 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S291539AbSBHKm6>; Fri, 8 Feb 2002 05:42:58 -0500
Date: Fri, 8 Feb 2002 11:30:14 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org,
        hpa@zytor.com
Subject: Re: [SOLUTION] Re: Fw: 2.4.18-pre9: iptables screwed?
Message-ID: <20020208113014.Q26676@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org,
	hpa@zytor.com
In-Reply-To: <20020208.010839.112626203.davem@redhat.com> <20020208105548.P26676@sunbeam.de.gnumonks.org> <20020208101218.GD12130@come.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020208101218.GD12130@come.alcove-fr>; from stelian.pop@fr.alcove.com on Fri, Feb 08, 2002 at 11:12:18AM +0100
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Pungenday, the 28th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 11:12:18AM +0100, Stelian Pop wrote:

> > The code you are quoting is only defined if debugging is compiled into 
> > the iptables package. The default distribution of the iptables package
> > does _not_ ship with debugging enabled.
> 
> Right, upon further analysis the redhat RPM is overriding COPT_FLAGS
> and removes the -DNDEBUG from the compile line.

hm. bad coincidence :(

> > We always want to make sure that nobody needs to update the iptables
> > package during the 2.4.x stable kernel series. Because of this (sane)
> > policy, we are keeping back a whole bunch of changes.  We can't just
> > silently abandon backwards compatibility.
> 
> Hey, you keeped backwards compatibility _only_ for those compiling 
> the non debug version of the package. I believe this remains however
> a half-bug...

Well, it is a bug in the debugging code, yes.  We missed to updated the
debugging code when changing the mangle table.  The reason for this is
that not even the developers are using the debugging code.

But when I do compatibility checks / tests for something I want to submit to
the kernel, I use plain unmodified iptables sources - new and old.

And I really didn't expect anybody to run debugging code on production
systems, sorry.

I'm not going to pull this change back out of the kernel because
one (or more) distributors/vendors ship a compiled-with-debug iptables. 

I don't think this was by RedHat's intention. 

> Stelian.
> Stelian Pop <stelian.pop@fr.alcove.com>

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
