Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129295AbQKQUwN>; Fri, 17 Nov 2000 15:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129302AbQKQUwE>; Fri, 17 Nov 2000 15:52:04 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:58836 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S129295AbQKQUvw>; Fri, 17 Nov 2000 15:51:52 -0500
From: David Lang <david.lang@digitalinsight.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 17 Nov 2000 13:06:36 -0800 (PST)
Subject: 2.2.17 poor performace with many processes
Message-ID: <Pine.LNX.4.21.0011171241260.20733-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

Last night I attempted to install a firewall system that runs over a
thousand processes (useing the TIS FWTK proxies). I upped the NR_TASKS to
4090 to allow them all to run.

the way the particular proxies work is to have a listener for each port
that forks off a copy of itself to handle the connection.

one issue that I was seeing however is that under a light load (~30-50
simultanious connections, ~20-30 new connections/sec) vmstat was showing
~10% user, 40%system CPU utilization.

at teh time it was useing ~80MB of ram. each proxy logs to syslog, while I
had syslog configured to write to a local file system time went up by
~10%. configuring syslog to write out a serial port makes it so running
syslog or not makes no noticable difference in the sup utilization

unfortunantly the system is no longer in production, approx 2 hours after
I went home this morning it hit the max FD limit (I had bumped it up to
16K) at ~100 connections/sec and we had to pull it out as nobody was
available to do diagnostics.

hardware is AMD thunderbird 950MHz, 512MB PC133 ram, 7200rpm ATA/66 drive

is this something that 2.4 should improve? or are there other tuning
paramaters I need to fiddle with?

David Lang

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.2

iQEVAwUBOhWd3z7msCGEppcbAQGsQwf6A2AAnSDwtUlftuaHuIaLleu6VKEDVwwI
X2cWQfavGQFebLC01KzL9tTyEJwLHaKAhNsoKvOy7FwPFIVaOPafXlSR33tJokAD
VC/899S39MTuD1huNP7sdjVfdovqmz7KaIXxqasymiUFlB7woFsxHhfjV0T6VKi4
jkJRJCPJ7yilli2DqOllES6MBC+tMqfiZ9mnMmaiRKcbZSHEMLI/eFM06kgjzBTI
EDT0XNgj575Xa0SUC9JmOS9csxwTodfXCnfiqHwgqEAt/qGyfEZUgI1xID6HHTqH
QfNt4mejDGhsJ3uFd6sYxN/Z/DrtoQLeYU8uYB/yfH7XZA31SGJYVQ==
=qrrI
-----END PGP SIGNATURE-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
