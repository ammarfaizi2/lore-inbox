Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbTLDXwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 18:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbTLDXwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 18:52:10 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53678
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263742AbTLDXwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 18:52:07 -0500
Date: Fri, 5 Dec 2003 00:52:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Guillermo Menguez Alvarez <gmenguez@usuarios.retecal.es>
Cc: Maciej Zenczykowski <maze@cela.pl>, linux-kernel@vger.kernel.org
Subject: Re: oom killer in 2.4.23
Message-ID: <20031204235224.GB22517@dualathlon.random>
References: <15498.1070554340@www7.gmx.net> <Pine.LNX.4.44.0312041801560.26684-100000@gaia.cela.pl> <20031204182016.5da319d5.gmenguez@usuarios.retecal.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204182016.5da319d5.gmenguez@usuarios.retecal.es>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 06:20:16PM +0100, Guillermo Menguez Alvarez wrote:
> > Yes, and as a side question, couldn't oom killer be made into a config
> > option?
> 
> As I see in the ChangeLog:
> 
> aa VM merge: page reclaiming logic changes: Kills oom killer
> 
> OOM Killer has been removed due to AA VM changes, so maybe it can't be
> cleanly enabled again.

it can be re-enabled without too much pain if you can accept the desktop
behaviour of 2.4.22 and previous not suitable for servers.

the oom killer had deadlocks and it was relaying on very inaccurate
accounting, so it had a number of corner cases were it was killing tasks
by mistakes (it's fooled by shm/mlock/noswap etc..), read also the bugreports
for 2.4.22 with tasks being killed because there was no swap in the box
(or just try to run your machine w/o swap, swap is not a must, it's a
wish).  Fixing those in 2.4 sounds too complicated, and now it's too
late to even hope to make a proper oom killer for 2.4.

For the record 2.2 was capable of checking iopl to defer a few times the
killing of the X server, that wasn't forward ported to 2.4. For 2.6 we
can do something better than all the past oom killers at least. 2.6 gets
fooled by mlock too btw, ranom kill tasks etc.. so it's not much better
than 2.4.22 was in oom killing respect.
