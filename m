Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263105AbUC2S7q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUC2S7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:59:46 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:59013
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263105AbUC2S7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:59:45 -0500
Message-ID: <406871FC.1070700@redhat.com>
Date: Mon, 29 Mar 2004 10:59:08 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040328
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: "linux-kern >> Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: For the almost 4-year anniversary: O_CLOEXEC again
References: <40677D1B.9060801@redhat.com> <20040329131819.GF4984@mail.shareable.org>
In-Reply-To: <20040329131819.GF4984@mail.shareable.org>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

> Since O_CLOEXEC is non-portable, why not implement the per-thread
> switch?
> 
> Signal handlers that call open() will have to be aware of it, but
> that's ok: an application will only set the switch if it knows what
> that implies.

It's not OK since library functions can install signal handlers and they
need not be aware of everything the application does.

Any globally visible change in the behavior can have negative effects.

Yes, there are other calls but open() is far more critical since it is
now promoted not only to an interface to actually do work.  We are
supported to read kernel and system informatino from /proc which
requires open().

And no, oen() is not the only signal-safe function.  If you don't have
the POSIX specs handy, look at a recent signal(2) man page which lists
the signal-safe functions.  accept(), socket() are on the list among others.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
