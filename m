Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWDHMHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWDHMHS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 08:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWDHMHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 08:07:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57021 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751327AbWDHMHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 08:07:17 -0400
Date: Sat, 8 Apr 2006 14:08:16 +0200
From: Petr Baudis <pasky@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Dumpable tasks and ownership of /proc/*/fd
Message-ID: <20060408120815.GB16588@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I would like to ask why is /proc/*/fd owned by root when the task is
not dumpable - what security concern does it address? It would seem more
reasonable to me if the /proc/*/fd owner would be simply always the real
uid of the process.

  The issue is that now all tasks calling setuid() from root to non-root
during their lifetime will not be able to access their /proc/self/fd.
This is troublesome because the fstatat() and other *at() routines are
emulated by accessing /proc/self/fd/*/path and that will break with
setuid()ing programs, leading to various weird consequences (e.g. with
the latest glibc, nftw() does not work with setuid()ing programs and
furthermore causes the LSB testsuite to fail because of this, etc.).

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
