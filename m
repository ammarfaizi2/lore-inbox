Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbULIDqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbULIDqh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 22:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbULIDqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 22:46:34 -0500
Received: from h66-38-154-67.gtcust.grouptelecom.net ([66.38.154.67]:50155
	"EHLO pbl.ca") by vger.kernel.org with ESMTP id S261450AbULIDqL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 22:46:11 -0500
Message-ID: <1102563893.41b7ca35988f3@webmail2>
Date: Wed,  8 Dec 2004 21:44:53 -0600
From: Aleksandar Milivojevic <amilivojevic@pbl.ca>
To: felix-linuxkernel@fefe.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: ipv6 getting more and more broken
References: <20041209024649.GA26553@codeblau.de>
In-Reply-To: <20041209024649.GA26553@codeblau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 24.79.220.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting felix-linuxkernel@fefe.de
Date: Thu, 9 Dec 2004 03:46:49 
> In 2.6.9, the machines don't even get a link-local address when bringing
> an interface up!  This is so utterly and completely broken, how can it
> be that nobody has noticed this yet?  I have compiled in ipv6
> statically, not as a module, but that should not matter, right?

He, he.  I was complaining because of the opposite (2.6.x automatically loading
ipv6 module and assigning link-local IPv6 addresses to all interfaces -- I don't
use IPv6, so I don't want to see those assigned).  I've been putting "alias
net-pf-10 off" in modprobe.conf, so I haven't noticed if default behaviour was
changed to what we had in 2.4.x.  Which would be good thing, IMHO.  The reality
is that most people use prepackaged kernels, all of them include ipv6 module,
and probably most of the users don't realize that IPv6 firewall on Linux is
separate thing from IPv4 firewall (possible scenario: you hack DMZ machine, than
from it hack into firewall exploiting non-existant IPv6 firewall rules (site
doesn't use IPv6, so admin "forgot" to put them in place), and than you have
open path to internal network).

Have you attempted to put something like this in modprobe.conf to reenable
automatic loading of ipv6 module:

alias net-pf-10 ipv6

This worked with 2.4.x kernels (as soon as any application attempts to use IPv6,
or even starts listening on IPv6, ipv6 module gets loaded).

> I should mention that "worked great in 2.6.7" may be too kind a
> statement as well.  Running both the listener and the announcer on the
> same machine yields this bizarre bahviour: the listener gets told the
> packet arrived on the lo device, not eth0 (via the scope_id), so the
> return tcp connection is going to a link-local ethernet address with
> scope_id for loopback and fails, of course.  But it does not fail in a
> straightforward manner but simply sits there and does not return (the
> connect() call, I mean).  That has been this way for ages and I complain
> about it every now and then but so far nobody was appalled enough by
> this obvious breakage to fix it.

Hm, some of the things from above would probobly need fixing, but some are
normal.  If connection is made to address assigned to local interface (for
example, to eth0), it will go through lo, not through eth0.  Which is kind of
logical.  This is how the things worked with IPv4 for long time.  I don't see
why IPv6 packets would be exception.

-- 
Aleksandar Milivojevic <amilivojevic@pbl.ca>    Pollard Banknote Limited
Systems Administrator                           1499 Buffalo Place
Tel: (204) 474-2323 ext 276                     Winnipeg, MB  R3T 1L7


