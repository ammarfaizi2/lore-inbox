Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUBDNPZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 08:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUBDNPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 08:15:25 -0500
Received: from mout0.freenet.de ([194.97.50.131]:3035 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S261872AbUBDNPX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 08:15:23 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Dan McGrath <troubled@emaildesktop.com>
Subject: Re: iptables stopped logging to files, but shows in ring buffer
Date: Wed, 4 Feb 2004 14:14:58 +0100
User-Agent: KMail/1.6
References: <001801c3ead5$9d0d6420$0201a8c0@wksdan> <20040204122550.GE25175@obroa-skai.de.gnumonks.org>
In-Reply-To: <20040204122550.GE25175@obroa-skai.de.gnumonks.org>
Cc: Harald Welte <laforge@netfilter.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200402041415.14059.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 04 February 2004 13:25, you wrote:
> On Tue, Feb 03, 2004 at 11:16:07PM -0500, Dan McGrath wrote:
> > I remembered that iptables logs seem to show in dmesg command in the
> > past, and sure enough, they are all showing up there no problems, but not in
> > any files, including dmesg.log.
> 
> If they are in dmesg, but in no files, than this cannot be a kernel
> problem.  It has to be a userspace (klogd/syslogd) issue.
> 
> Thus, it is off-topic to lkml, and is not a problem of
> netfilter/iptables.

I had the same problem a while ago.
The cause was: I've a cron-job that cleans logfiles
via bash script. This bash script shuts down syslogd and restarts
it. After cleaning the logs, kernel-messages didn't reach userspace
anymore. The solution was to not only shut down syslogd but also
klogd.
So, try to restart klogd _and_ syslogd.

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAIPBgFGK1OIvVOP4RAolGAJ96DUqZh4daeKiDQc4YzV87FhlZ+wCfdnHY
WceebWbSfmTVfcdoEqXxF2g=
=0Y6M
-----END PGP SIGNATURE-----
