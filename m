Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266763AbUF3RU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266763AbUF3RU5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266762AbUF3RUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:20:21 -0400
Received: from vsat-148-63-57-162.c001.g4.mrt.starband.net ([148.63.57.162]:26338
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S266781AbUF3RLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:11:53 -0400
Message-ID: <40E2F33C.90106@redhat.com>
Date: Wed, 30 Jun 2004 10:07:08 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040627
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Davis <paul@linuxaudiosystems.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK
References: <200406301612.i5UGCdiw010913@localhost.localdomain>
In-Reply-To: <200406301612.i5UGCdiw010913@localhost.localdomain>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Davis wrote:

> this has me thinking. one of the major changes with NPTL is that all
> threads share the same PID. so how in the world do we ever set the
> scheduling policy of a single thread (as opposed to something
> identified by a pid_t) to SCHED_FIFO?

If you have to ask this question than it's no wonder you get erratic
behavior.  It means you haven't looked at the pthread interface at all.

Define a pthread_attr_t with the appropriate setting (with
pthread_attr_setschedparam etc) and create the thread (and use
pthread_attr_setinheritsched correctly).  Alternatively use
pthread_setschedparam on already running threads.

And use a recent enough nptl version.   Very early versions didn't have
any of the scheduler handling implemented.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
