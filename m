Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbVAUTBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVAUTBL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 14:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVAUTBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 14:01:11 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:54793 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S262464AbVAUTBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 14:01:10 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: seccomp for 2.6.11-rc1-bk8
Date: Fri, 21 Jan 2005 18:59:20 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <csrje8$bsn$1@abraham.cs.berkeley.edu>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu> <20050121093902.O469@build.pdx.osdl.net>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1106333960 12183 128.32.168.222 (21 Jan 2005 18:59:20 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Fri, 21 Jan 2005 18:59:20 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright  wrote:
>Only difference is in number of context switches, and number of running
>processes (and perhaps ease of determining policy for which syscalls
>are allowed).  Although it's not really seccomp, it's just restricted
>syscalls...

There is a simple tweak to ptrace which fixes that: one could add an
API to specify a set of syscalls that ptrace should not trap on.  To get
seccomp-like semantics, the user program could specify {read,write}, but
if the user program ever wants to change its policy, it could change that
set.  Solaris /proc (which is what is used for tracing) has this feature.
I coded up such an extension to ptrace semantics a long time ago, and
it seemed to work fine for me, though of course I am not a ptrace expert.

I don't know whether ptrace + this tweak is a better idea than seccomp.
It is just another option out there that achieves similar functionality.
