Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267286AbSLKTPP>; Wed, 11 Dec 2002 14:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267288AbSLKTPO>; Wed, 11 Dec 2002 14:15:14 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:38410
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267286AbSLKTOK>; Wed, 11 Dec 2002 14:14:10 -0500
Subject: Re: Destroying processes
From: Robert Love <rml@tech9.net>
To: Justin Hibbits <jrh29@po.cwru.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021211190132.GF147@lothlorien.cwru.edu>
References: <20021211190132.GF147@lothlorien.cwru.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1039634515.833.57.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 14:21:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 14:01, Justin Hibbits wrote:

> Is there a system call that would destroy a process?  Sometimes I end up with
> zombie processes, other times I end up with a process attaching to a device
> driver, and hanging, so I want to be able to completely destroy the
> process...image, file handle, driver hooks, everything.  If there isn't one,
> and noone wants to do it, I'll gladly do it (may take a few weeks tho).  I just
> don't wanna do what someone else has already done.

Cases where kill -9 fail to work are cases where it is supposed to fail.

You cannot kill zombies, that would break POSIX compliance when the
parent's called wait.  If you task's parents are not properly calling
wait() that is an application bug.  If the parent exits, the children
should be reparented to init and init will reap them via wait().

You also cannot kill tasks that are sleeping (D in ps/top).  They may
hold a semaphore or otherwise be in the middle of a critical section. 
Killing them would be bad bad bad.

	Robert Love

