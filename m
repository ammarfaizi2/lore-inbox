Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274988AbTHQBDc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 21:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274992AbTHQBDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 21:03:32 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:20241 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S274988AbTHQBDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 21:03:31 -0400
Date: Sun, 17 Aug 2003 03:03:36 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3: setuid32(8) returns EAGAIN (WTF?!)
Message-ID: <20030817010336.GA12079@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just changed from 2.5.75 to 2.6.0-test3 and suddenly my imap server
fails to start (it's dovecot).  It wrote to syslog:

Aug 17 02:58:02 hellhound dovecot: Dovecot starting up
Aug 17 02:58:03 hellhound imap-login: setuid(8) failed: Resource temporarily unavailable
Aug 17 02:58:03 hellhound dovecot: Login process died too early - shutting down

So I strace -f it, and sure enough, here is what happens:

[init, fork, tzfile...]
8094  chroot("/var/run/dovecot//login") = 0
8094  chdir("/")                        = 0
8094  setuid32(0x8)                     = -1 EAGAIN (Resource temporarily unavailable)

Now this does not appear to be a valid return value for setuid32, and
my understanding of POSIX and Susv3 is that dovecot is absolutely right
in barfing at this.

Why is this happening?  Please fix!

Felix

PS: Time for a brown paper bag bug-fix release, if you ask me.
