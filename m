Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTDPNmE (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 09:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbTDPNmD 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 09:42:03 -0400
Received: from mail.compaq.com ([161.114.1.205]:2321 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264372AbTDPNmC (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 09:42:02 -0400
Date: Wed, 16 Apr 2003 08:00:59 +0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: How to identify contents of /lib/modules/*
Message-ID: <20030416020059.GA27314@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, here's a problem I'm having, perhaps someone has some smart idea...

A certain major linux distribution distributes a number of binary 
kernels, errata kernels, which all report the exact same thing 
via "uname -r".  These kernels may differ by only a little
(only the .config file is different in some small way) or by 
a lot (binary drivers for one don't work (panic) on another).

I seem to be in the business of distributing binary drivers to customers,
like it or not.  Since there already exist multiple incompatible
errata kernels that all share the same uname -r and hence the same
directory for modules, and since all these errata kernels *might*
be found on a single machine in /boot.... (only one of which is likely
to be viable, since there is only one /lib/modules directory for
them all)...

The task for the binary driver distributor becomes to figure out which
of these multiple errata kernels found in /boot corresponds to the 
/lib/modules directory, so we can drop the binary driver that was
made for that errata kernel in there, and not a driver made for the
wrong kernel.

So far, the best idea I have come up with is to construct a database
of checksums of all the *.o files in the various /lib/modules directories
that come with the various errata kernels, then compare that database
against what is actually found in /lib/modules.  (note, the results will
likely never match _exactly_, since binary driver distributors like myself
can drop .o files in /lib/modules, and alos, this distribution doesn't use
the symbol name checksums, so identical *.o files appear occasionally in
/lib/modules for different errata kernels.)  Then count which errata kernel 
matches the most *.o files, and assume that must be the one (and probably
should have some minimum numver to match, lest the user have only kernels
we know nothing about)

This seems like a lot of contortions to go through and I'm wondering
if there's a simpler way to identify the contents of /lib/modules, 
aside from the 'uname -r' type string, and I just missed it.

Also note, I can't just figure out which is the _running_ kernel
(by checksumming /boot/vmlinuz, cross-checked against /etc/lilo.conf
or grub conf file, because in certain situations the running kernel
is only there to install another kernel.  And we want to provide
the option to install the driver for all the kernels on the system
that we can (reliably) find.)

Also, rpm -qf to try to id the RPM from which some /lib/modules file
or vmlinuz won't necessarily work, as rpm can report they belong to 
multiple RPMs in certain cases.

Thanks for any other ideas.

-- steve

