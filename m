Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVL3Wby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVL3Wby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVL3Wby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:31:54 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:53726 "EHLO
	taverner.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751133AbVL3Wbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:31:53 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] Fix user data corrupted by old value return of sysctl
Date: Fri, 30 Dec 2005 22:31:41 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <dp4cgd$lvq$1@taverner.CS.Berkeley.EDU>
References: <43B4F287.6080307@gmail.com>
Reply-To: daw-usenet@taverner.CS.Berkeley.EDU (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.CS.Berkeley.EDU 1135981901 22522 128.32.168.222 (30 Dec 2005 22:31:41 GMT)
X-Complaints-To: news@taverner.CS.Berkeley.EDU
NNTP-Posting-Date: Fri, 30 Dec 2005 22:31:41 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yi Yang  wrote:
>If the user reads a sysctl entry which is of string type
>  by sysctl syscall, this call probably corrupts the user data
>  right after the old value buffer, the issue lies in sysctl_string
>  seting 0 to oldval[len], len is the available buffer size
>  specified by the user, obviously, this will write to the first
>  byte of the user memory place immediate after the old value buffer
>, the correct way is that sysctl_string doesn't set 0, the user
>should do it by self in the program.

That's not just data corruption -- it's also a buffer overrun.
Granted, it's "only" a one-byte overrun, but I have seen one-byte
overruns be exploitable occasionally in the past.  So this sounds
to me like a potential security issue, too.
