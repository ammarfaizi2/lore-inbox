Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbUJ3XSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbUJ3XSD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUJ3XQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:16:16 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:14605 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261387AbUJ3XOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 19:14:17 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Tim Hockin <thockin@hockin.org>
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
Date: Sun, 31 Oct 2004 02:13:37 +0300
User-Agent: KMail/1.5.4
Cc: Lee Revell <rlrevell@joe-job.com>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua> <20041030222720.GA22753@hockin.org>
In-Reply-To: <20041030222720.GA22753@hockin.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 October 2004 01:27, Tim Hockin wrote:
> On Sun, Oct 31, 2004 at 01:11:07AM +0300, Denis Vlasenko wrote:
> > I am not a code genius, but want to help.
> > 
> > Hmm probably some bloat-detection tools would be helpful,
> > like "show me source_lines/object_size ratios of fonctions in
> > this ELF object file". Those with low ratio are suspects of
> > excessive inlining etc.
> 
> The problem with apps of this sort is the multiple layers of abstraction.
> 
> Xlib, GLib, GTK, GNOME, Pango, XML, etc.

I think it makes sense to start from lower layers first:

Kernel team is reasonably aware of the bloat danger.

glibc is worse, but thanks to heroic actions of Eric Andersen
we have mostly feature complete uclibc, 4 times (!)
smaller than glibc.

Xlib, GLib.... - didn't look into them apart from cases
when they do not build or in bug hunting sessions.
Quick data point: glib-1.2.10 is 1/2 of uclibc in size.
glib-2.2.2 is 2 times uclibc. x4 growth :(

> No one wants to duplicate effort (rightly so).  Each of these libs tries
> to do EVERY POSSIBLE thing.  They all end up bloated.  Then you have to
> link them all in.  You end up bloated.  Then it is very easy to rely on
> those libs for EVERYTHING, rather thank actually thinking.
> 
> So you end up with the mindset of, for example, "if it's text it's XML".
> You have to parse everything as XML, when simple parsers would be tons
> faster and simpler and smaller.
> 
> Bloat is cause by feature creep at every layer, not just the app.

I actually tried to convince maintainers of one package
that their code is needlessly complex. I did send patches
to remedy that a bit while fixing real bugs. Rejected.
Bugs were planned to be fixed by adding more code.
I've lost all hope on that case.

I guess this is a reason why bloat problem tend to be solved
by rewrite from scratch. I could name quite a few cases:

glibc -> dietlibc,uclibc
coreutils -> busybox
named -> djbdns
inetd -> daemontools+ucspi-tcp
sendmail -> qmail
syslogd -> socklog (http://smarden.org/socklog/)

It's sort of frightening that someone will need to
rewrite Xlib or, say, OpenOffice :(
--
vda

