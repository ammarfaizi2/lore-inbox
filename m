Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbWD1Llg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbWD1Llg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 07:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWD1Llg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 07:41:36 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:57049 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S965145AbWD1Llf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 07:41:35 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Stefan Gast <mrsteven@gmx.de>
Newsgroups: linux.kernel
Subject: Shouldn't the ioctl KDSKBMODE only be usable by root?
Date: Fri, 28 Apr 2006 13:41:27 +0200
Organization: Tiscali Germany Usenet
Message-ID: <e2sv1d$26ed$1@ulysses.news.tiscali.de>
NNTP-Posting-Host: p85.212.144.54.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: ulysses.news.tiscali.de 1146224493 72141 85.212.144.54 (28 Apr 2006 11:41:33 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Fri, 28 Apr 2006 11:41:33 +0000 (UTC)
User-Agent: KNode/0.10.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm a bit confused about the fact that everyone who has access to a virtual
console can stop the keyboard from working by using the KDSKBMODE ioctl:

ioctl(fd_to_console_or_tty, KDSKBMODE, K_RAW);

This is a problem because console switching via alt+fx is no longer possible
when the keyboard is in raw mode.

Why is everyone permitted to change the keyboard mode? I guess it is because
of the unicode support, but couldn't a modified unicode_start script be
called by root while running some init script?

The loadkeys (KDSKBENT) and setkeycodes (KDSETKEYCODE) programs fail because
of permisson problems when they are called by a non-privileged user. I
think that's correct, but an unprivileged user should not be able to make
the system unusable by using KDSKBMODE.

Stefan
