Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUECLn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUECLn0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 07:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUECLn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 07:43:26 -0400
Received: from firewall.conet.cz ([213.175.54.250]:14799 "EHLO conet.cz")
	by vger.kernel.org with ESMTP id S261606AbUECLnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 07:43:24 -0400
Date: Mon, 3 May 2004 13:43:16 +0200
From: Libor Vanek <libor@conet.cz>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reading from file in module fails
Message-ID: <20040503114316.GA22732@Loki>
References: <20040503105041.GA12023@Loki> <20040503113500.GB31513@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503113500.GB31513@harddisk-recovery.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I need to copy files (yes - I know that kernel shouldn't do this but
> > I REALLY need).
> 
> This is ugly, but it should do the trick:
> 
> int rv;
> char *argv[4] = {"/bin/cp", "/tmp/foo", "/tmp/bar", NULL};
> char *envp[3] = {"HOME=/", "PATH=/sbin:/bin:/usr/sbin:/usr/bin", NULL};
> 
> rv = call_usermodehelper(argv[0], argv, envp, 1);
> 
> if(rv < 0) {
> 	/* error handling */
> }
> 
> Called from kernel, done in userspace. And if you want to access an SQL
> database from kernel tomorrow, it's just a matter of changing the
> usermode helper.
> 
> (BTW, if you need to copy files from kernel, it's usually a sign of bad
> design)

Geez - that's REALLY ugly :-) But for testing I can use it.

It's not bad design - what I'm doing is writing snapshots for VFS as my diploma thesis. And I need to create copy of file before it's changed (copy-on-write). There is no other way how to do it in kernel-space (and user-space solutions like using LUFS are really slow)

Thx,
Libor


