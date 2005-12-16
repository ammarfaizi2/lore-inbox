Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVLPBOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVLPBOD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVLPBOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:14:01 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:39851 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751234AbVLPBOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:14:00 -0500
Subject: Re: [PATCH 0/3] *at syscalls: Intro
From: Nicholas Miell <nmiell@comcast.net>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
In-Reply-To: <200512152249.jBFMnXAA016747@devserv.devel.redhat.com>
References: <200512152249.jBFMnXAA016747@devserv.devel.redhat.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 17:13:52 -0800
Message-Id: <1134695632.2785.12.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 17:49 -0500, Ulrich Drepper wrote:
> Here is a series of patches which introduce in total 11 new system calls
> which take a file descriptor/filename pair instead of a single file name.
> These functions, openat etc, have been discussed on numerous occasions.
> They are needed to implement race-free filesystem traversal, they are
> necessary to implement a virtual per-thread current working directory
> (think multi-threaded backup software), etc.
> 

Actually, that last part is false (or maybe just misleading). You can
create threads without CLONE_FS to get a per-thread cwd/chroot/umask, no
"virtual" required.

Don't take this as an objection to implementation of the *at() syscalls
in Linux, though; rather, look at is as a request for the addition of
int pthread_attr_setfssharing_np(pthread_attr_t *attr, int share) and
int pthread_attr_getfssharing_np(pthread_attr_t *attr) to glibc.

-- 
Nicholas Miell <nmiell@comcast.net>

