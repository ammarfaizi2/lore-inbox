Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274922AbTGaX3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274923AbTGaX3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:29:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:49026 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274922AbTGaX3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:29:02 -0400
Date: Thu, 31 Jul 2003 16:17:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, rml@tech9.net
Subject: Re: [PATCH] protect migration/%d etc from sched_setaffinity
Message-Id: <20030731161703.210470ea.akpm@osdl.org>
In-Reply-To: <20030731231154.GB7852@rudolph.ccur.com>
References: <20030731224604.GA24887@tsunami.ccur.com>
	<20030731154740.4e21a6e2.akpm@osdl.org>
	<20030731231154.GB7852@rudolph.ccur.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> wrote:
>
> I'd like to be able to write shell scrips that operate on the set of
> /proc/[0-9]* without having to know which of the ever-changing list
> of processes need to be avoided and which not.

Like this?

#!/bin/sh

#
# can_set_affinity pid
#
can_set_affinity()
{
	if [ "$(cat /proc/$1/maps)" != "" ]
	then
		return 0
	fi
	if head -1 /proc/$1/status | egrep "events|migration"
	then
		return 1
	else
		return 0
	fi
}

if can_set_affinity $1
then
	echo can set affinity of pid $1
else
	echo cannot set affinity of pid $1
fi


