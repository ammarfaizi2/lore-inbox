Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267206AbTBXQGd>; Mon, 24 Feb 2003 11:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTBXQGd>; Mon, 24 Feb 2003 11:06:33 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:51165 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S267206AbTBXQGc>; Mon, 24 Feb 2003 11:06:32 -0500
Date: Mon, 24 Feb 2003 17:16:27 +0100
From: Stelian Pop <stelian@popies.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: modutils: FATAL: Error running install...
Message-ID: <20030224171627.B29439@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the latest 2.5-bk (and module-init-tools), my logs
are polluted with lines like:
	FATAL: Error running install command for block_major_2
triggered with
	# cat /dev/fd0
where the corresponding line in modprobe.conf is:
	install block-major-2 /bin/true

The problem is reproductible with any 'install' command in
modprobe.conf.

Looking at modprobe source, it fails on the system() call. The
fork()/exec() part works corectly (/bin/true get executed),
but wait4() fails with -ECHILD.

Running 'modprobe block-major-2' from the console works as 
expected.

I believe this is once again related to the exec_usermodehelper()
routines...

Stelian.
-- 
Stelian Pop <stelian@popies.net>
