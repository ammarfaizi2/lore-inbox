Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVAHWRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVAHWRx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVAHWOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:14:53 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:56235 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261938AbVAHWOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:14:20 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <87mzvkxxck.fsf@sulphur.joq.us>
References: <200501071620.j07GKrIa018718@localhost.localdomain>
	 <1105132348.20278.88.camel@krustophenia.net>
	 <20050107134941.11cecbfc.akpm@osdl.org>
	 <20050107221059.GA17392@infradead.org>
	 <20050107142920.K2357@build.pdx.osdl.net>  <87mzvkxxck.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Sat, 08 Jan 2005 17:14:02 -0500
Message-Id: <1105222442.24592.126.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-08 at 00:12 -0600, Jack O'Quin wrote:
> I find it hard to understand why some of you think PAM is an adequate
> solution.  As currently deployed, it is poorly documented and nearly
> impossible for non-experts to administer securely.  On my Debian woody
> system, when I login from the console I get one fairly sensible set of
> ulimit values, but from gdm I get a much more permissive set (with
> ulimited mlocking, BTW).  Apparently, this is because the `gdm' PAM
> config includes `session required pam_limits.so' but the system comes
> with an empty /etc/security/limits.conf.  I'm just guessing about that
> because I can't find any decent documentation for any of this crap.

Eh, PAM is a perfectly fine solution.  Documentation is lacking, but
it's easy to find examples.  On my system /etc/security/limits.conf has
this sample config, commented out:

#<domain>      <type>  <item>         <value>
#

#*               soft    core            0
#*               hard    rss             10000
#@student        hard    nproc           20
#@faculty        soft    nproc           20
#@faculty        hard    nproc           50
#ftp             hard    nproc           0

So add your audio users (or cdrecord users, or whoever) to group
realtime and add:

realtime	hard	memlock	100000
realtime	soft	prio	100

Problem solved.

Lee


