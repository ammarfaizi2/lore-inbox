Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbTKEHOo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 02:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbTKEHOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 02:14:44 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:3550 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262747AbTKEHOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 02:14:43 -0500
Date: Wed, 5 Nov 2003 02:14:35 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Linus Torvalds <torvalds@osdl.org>, Paul Venezia <pvenezia@jpj.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: ext3 performance inconsistencies, 2.4/2.6
Message-ID: <20031105021435.W2097@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20031104212813.GC30612@ti19.telemetry-investments.com> <Pine.LNX.4.44.0311041335200.20373-100000@home.osdl.org> <20031104221904.GE30612@ti19.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031104221904.GE30612@ti19.telemetry-investments.com>; from brugolsky@telemetry-investments.com on Tue, Nov 04, 2003 at 05:19:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 05:19:04PM -0500, Bill Rugolsky Jr. wrote:
> On Fedora 0.95, Pentium M 1.6GHz, 2.4.22-1.2115.nptl, glibc-2.3.2-10, (NPTL 0.60),
> I get:
> 
> Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> NPTL           100M 13070 100 +++++ +++ 14141   4 13099 100 +++++ +++ +++++ +++
> LinuxThreads   100M 25957 100 +++++ +++ 20037   5 26777  99 +++++ +++ +++++ +++
> 
> Ugh, still there.

BTW, there are 3 different cases where locking might be different in glibc.
When -lpthread is not linked in, when -lpthread is linked in but
pthread_create hasn't been compiled yet and when first pthread_create has
been compiled already.

Could you post numbers for all these cases (ie. run the benchmark, then link
the benchmark against -lpthread as well and rerun it and last link it
against -lpthread and add:
static void * tf (void *a) { return NULL; }

...
pthread_t pt;
pthread_create (&pt, NULL, tf, 0);
pthread_join (pt, NULL);
...
to benchmark's main (in each case NPTL and LinuxThreads)?

	Jakub
