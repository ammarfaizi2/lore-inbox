Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265988AbUA2D6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 22:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUA2D6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 22:58:42 -0500
Received: from post.tau.ac.il ([132.66.16.11]:28907 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S265988AbUA2D6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 22:58:37 -0500
Date: Thu, 29 Jan 2004 05:56:54 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Bart Samwel <bart@samwel.tk>
Subject: [patch] backport commit=NNN mount option for reiserfs to 2.4
Message-ID: <20040129035654.GA4052@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	Bart Samwel <bart@samwel.tk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.3; VDF: 6.23.0.51; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I backported the commit=NNN mount option for reiserfs to 2.4 (the patch
is against 2.4.25-pre7).
This mount option allows to set the journal maximum age so that
reiserfs would play nicely with laptop-mode.
I did change the settings a bit so that setting commit=0 sets the
journals maximum age to the default value so that the value can be
switched between the default and a longer one when laptop-mode is
activated (since if I am not mistaken the current value can't be
extracted in user mode unless the reiserfs proc entry option is
compiled in and thus this can't be done at the script level).
This did take a bit of work since reiserfs stores this value on disk in
the journal header which isn't kept in memory later. Thus the value
needs to either be reread from disk when resetting to the default value
or stored in memory with the current value.
Each has its problems. I went with the first option since there seems
to be disk activity anyway during remount, and this is non-intrusive
on the current structures.
This is instead of the current implementation that ext3 uses for
laptop-mode (there is no such implementation for reiserfs in 2.4),
which after looking at the code may be a bit less intrusive but is more
of a hack (and it does tramp over the existing commit=NNN mount option
in ext3 BTW).
Any comments are welcome.

--fdj2RfSjLxBAspz7
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="reiserfs-commit_max_age-mount_option-2.4.25.diff.bz2"
Content-Transfer-Encoding: base64

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

--fdj2RfSjLxBAspz7--
