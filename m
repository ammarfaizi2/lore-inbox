Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbVAVHkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVAVHkB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 02:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVAVHkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 02:40:00 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:27255 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262678AbVAVHj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 02:39:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qOcPWBbe8VTSV4oiolglx+pqIJSUECaxVT6z4JdlxbQyV8vReC2fn7aQZoFxCHmS7DDHJqqGFRBtFFTb7pNV5B+Yxb0NlVgTQr51QC/I2hT1BxV3nBUtsF5KP3Iij/pYOWoF29pP+DM5uurDalynw8plSDqMVW5/F3ik8gKR0U0=
Message-ID: <a36005b50501212339405ca4a7@mail.gmail.com>
Date: Fri, 21 Jan 2005 23:39:55 -0800
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: Pollable Semaphores
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050121230504.T469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050121212212.GA453910@firefly.engr.sgi.com>
	 <521xceqx90.fsf@topspin.com>
	 <Pine.SGI.4.61.0501211647100.7393@kzerza.americas.sgi.com>
	 <a36005b5050121194377026f39@mail.gmail.com>
	 <20050121215203.S469@build.pdx.osdl.net>
	 <20050121230504.T469@build.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005 23:05:04 -0800, Chris Wright <chrisw@osdl.org> wrote:
> Yeah, here it is.  I refreshed it against a current kernel.  It passes my
> same old test, where I select on /proc/<pid>/status fd in exceptfds.

Looks certainly attractive to me.  Nice small patch.  How quickly
after the death of the process is proc_pid_flush() called?

If this could go in and the futex stuff is handled, there is "only"
async I/O to handle.  After that we could finally create a uniform
event mechanism at userlevel which binds all these events (I/O,
process/thread termination, sync primitives) together.  Maybe support
for legacy sync primitives (SysV semaphores, msg queues) is needed as
well, don't know yet.  Note that I assume that polling of POSIX
mqueues works as it did the last time I tried it.
