Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUBCDsn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 22:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUBCDsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 22:48:43 -0500
Received: from clix.aarnet.edu.au ([192.94.63.10]:49341 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP id S264542AbUBCDsl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 22:48:41 -0500
Subject: User-space notification of process end
From: Glen Turner <glen.turner@aarnet.edu.au>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Australian Academic and Research Network
Message-Id: <1075780082.6747.23.camel@andromache>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 03 Feb 2004 14:18:02 +1030
Content-Transfer-Encoding: 7bit
X-MDSA: Yes
X-Spam-Score: -100 USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am writing a application which needs to know fairly
promptly if a daemon has died.  I'd prefer not to
alter the daemon source code or to run the program
as a non-daemon child of a daemon watcher process.

I tried using fnctl(..., F_NOTIFY, ...) as
follows

  f = open("/proc/123", O_RDONLY);
  signal(SIGIO, handler);
  fcntl(f, F_NOTIFY, DN_DELETE | DN_RENAME);
  F_ZERO(&f_set);
  F_SET(f, &f_set);
  select(1, NULL, NULL, &f_set, NULL);

hoping I'd see the /proc/<processid>/* files being
removed at process end.

But procfs doesn't seem to support fnctl(.., F_NOTIFY, ...)
for parameters other than DN_ACCESS.  This doesn't seem
to be limited to my code (the dnotify program, which has
much better signal handling, has the same behavior).

Suggestions, particularly ones which don't require polling
for the existence of the watched process, are welcome.

uname -r says 2.4.22-1.2149.nptl, which is the latest
Fedora Core 1 kernel.  I'm willing to try 2.6 if that
supports F_NOTIFY on /proc.

Thanks,
Glen

-- 
Glen Turner         Tel: (08) 8303 3936 or +61 8 8303 3936 
Network Engineer          Email: glen.turner@aarnet.edu.au
Australian Academic & Research Network   www.aarnet.edu.au


