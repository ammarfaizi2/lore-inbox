Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVCHFSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVCHFSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVCHFSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:18:20 -0500
Received: from mail.joq.us ([67.65.12.105]:49320 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261374AbVCHFSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:18:14 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       paul@linuxaudiosystems.com, mpm@selenic.com,
       cfriesen@nortelnetworks.com, chrisw@osdl.org, rlrevell@joe-job.com,
       arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050112185258.GG2940@waste.org>
	<200501122116.j0CLGK3K022477@localhost.localdomain>
	<20050307195020.510a1ceb.akpm@osdl.org>
	<20050308035503.GA31704@infradead.org>
	<20050307201646.512a2471.akpm@osdl.org>
	<20050308042242.GA15356@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Mon, 07 Mar 2005 23:19:55 -0600
In-Reply-To: <20050308042242.GA15356@elte.hu> (Ingo Molnar's message of
 "Tue, 8 Mar 2005 05:22:42 +0100")
Message-ID: <87r7iqsohw.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> * Andrew Morton <akpm@osdl.org> wrote:
>
>> Still.  It seems to be what we deserve if all that fancy stuff we have
>> cannot address this very simple and very real-world problem.

Ingo Molnar <mingo@elte.hu> writes:
> please describe this "very simple and very real-world problem" in simple
> terms. Lets make sure "problem" and "solution" didnt become detached.

Linux audio users need to run large, complex low-latency desktop audio
applications without granting them full root privileges.  These
applications require reliable SCHED_FIFO (or equivalent) scheduling,
and the ability to lock process images into memory.  We need to be
able to drop and reacquire these privileges from time to time.  We
strongly prefer using the POSIX realtime interfaces.

For desktop musicians this needs to be simple to administer, yet still
reasonably secure.  Denial of service attacks are not a serious threat
in our environment, but we really don't want people turning our
systems into open spam relays or creating hidden setuid root shells.

Ours is *not* a timesharing multiuser environment.  Multiple users may
access these systems, but only one at a time.  Many musicians have a
Mac or Windows background, systems which grant realtime privileges to
all tasks indiscriminantly.  The realtime LSM allows us to grant
similar privileges while maintaining better control over who gets
them, a significant improvement over our competition.

AFAICT, video and probably some other desktop multimedia applications
have similar needs, but others should speak for them.  I do know that
audio is highly sensitive to realtime performance glitches.

We believe that this LSM meets our needs, because hundreds of us have
used it successfully for over a year.  This is the last missing piece
that allows us to reap the benefits of the excellent kernel latency
improvements Ingo, Andrew and others have made over the last several
years.
-- 
  joq
