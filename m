Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVBUEyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVBUEyg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 23:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVBUEyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 23:54:36 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:35591 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261850AbVBUEye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 23:54:34 -0500
Date: Mon, 21 Feb 2005 12:57:22 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>
Subject: Re: [autofs] automount does not close file descriptors at start
In-Reply-To: <20050216125350.GA6031@uio.no>
Message-ID: <Pine.LNX.4.58.0502211244540.9892@wombat.indigo.net.au>
References: <20050216125350.GA6031@uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-102.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2005, Steinar H. Gunderson wrote:

> Hi,
> 
> My latest autofs package for Debian (4.1.3+4.1.4beta2-1) had problems
> installing, freezing after install; I've worked around this now
> (4.1.3+4.1.4beta2-2 is on its way up to the archive), but I've been told this
> is really a bug in automount. What I've been told is along the lines of:
> 
> "Any daemon going into the background should close all file descriptors from
> zero up to MAXFDS minus the ones it actually wants to have open."
> 
> In other words, one should probably have a for loop of sorts in
> become_daemon().

Steinar, I'm still wondering where this came from?

This is the first time I've heard this and the first time I wrote a Unix
daemon was fifteen years ago.

As far as I'm concerned redirecting stdin, stdout and stderr to the null 
device, then closing it and setting the process to a be the group leader 
(as autofs does) should be all that's needed to daemonize a process.

So are we saying that we don't trust the kernel to reliably duplicate the 
state of file handles when we fork?

If that's the case then the kernel is badly broken and needs fixing, not 
autofs!

Ian

