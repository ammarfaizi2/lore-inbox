Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTJXP5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 11:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTJXP5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 11:57:14 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51211 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262323AbTJXP5L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 11:57:11 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
Date: 24 Oct 2003 15:47:04 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bnbhho$3o3$1@gatekeeper.tmr.com>
References: <20031014143047.GA6332@ncsu.edu> <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl>
X-Trace: gatekeeper.tmr.com 1067010424 3843 192.168.12.62 (24 Oct 2003 15:47:04 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl>,
Maciej Zenczykowski  <maze@cela.pl> wrote:

| On one hand I agree with you - OTOH: why not run an older version of the
| kernel? Are kernel versions 2.2 or even 2.0 really not sufficient for such
| a situation?  It should be noted that newer kernels are adding a whole lot
| of drivers which aren't much use with old hardware anyway and only a
| little actual non-driver related stuff (sure it's an oversimplification,
| but...).  Just like you don't expect to run the latest
| games/X/mozilla/kde/gnome on old hardware perhaps you shouldn't run the
| latest kernel... perhaps you should...
| 
| Sure I would really like to be able to compile a 2.6 for my 
| firewall (486DX33+40MB-2MB badram) - but is this the way to go?

The problem is that you can make a much better firewall with iptables,
so going to at least 2.4.xx is very desirable. The 2.4->2.6 change is
the first one in a long time which didn't rewrite the network code in a
major way, such as ipfwadm -> ipchains -> iptables. I don't see the
IPsec and crypto in-kernel as a big gain, freeswan was a patch and in
kernel or in a shared library is similar in memory use.

Clearly the in-kernel is faster.

| As for making the kernel smaller - perhaps a solution would be to code all 
| strings as error codes and return ERROR#42345 or something instead of the 
| full messages - there seem to be quite a lot of them.  I don't mean to 
| suggest this solution for all compilations but perhaps a switch to remove 
| strings and replace them with ints and then a seperately generated file of 
| errnum->string. I'd expect that between 10-15% of the uncompressed kernel 
| is currently pure text.

This really needs to be done as part of i18n, where a format is replaced
by an int which is an index into the local format string table. This is
very hard to do right, since the strings all need to be unique, implying
a registration. Note: please don't read "needs to be done" without the
i18n part, I'm saying that if it were to be done it should be done to
allow for i18n string tables, not that this is a critical feature!
| 
| Perhaps int->string conversion could be done by a loadable module or a 
| userspace program?

I would say tes and no, respectively.

| Of course part of the problem is that by designing the kernel for high mem 
| situations we're using more memory hogging algorithms.  It's a simple 
| matter of features vs mem footprint.

There are three (at least) driving forces:
1 - nifty new features, hopefully can be configurable
2 - algorithms needed to run on large hardware. I think in some cases
    this could be done by defining small-mem vs. big-mem macros, but it
    takes a bit of work and requires regular testing of both paths.
3 - speed vs. memory. This is sort of a subcase of (2), where only the
    very smallest machines would feel a pinch. That is, they are
    generally useful, rather than intended to support derver and cluster
    class hardware.

So (1) can be configurable if people are willing, (2) would require
implementation of an alternate code, and (3) is probably part of the
cost of a new kernel.

If people feel strongly 2.7 could start to go to mudules and/or having a
set of definitions optimized for various configurations. Before you say
that can't be done, consider that we now support a bunch of totally
unlike hardware, so it's certainly possible.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
