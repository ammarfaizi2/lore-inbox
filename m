Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTFZQw6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 12:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTFZQw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 12:52:58 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:42834 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262123AbTFZQw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 12:52:57 -0400
Date: Thu, 26 Jun 2003 10:07:17 -0700
From: Andrew Morton <akpm@digeo.com>
To: Hiroshi Inoue <inoueh@uranus.dti.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Repeatable kernel crash in tty_io.c (2.5.73 & 2.4.21)
Message-Id: <20030626100717.4607e60b.akpm@digeo.com>
In-Reply-To: <20030627001520.5237.INOUEH@uranus.dti.ne.jp>
References: <20030627001520.5237.INOUEH@uranus.dti.ne.jp>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jun 2003 17:07:10.0479 (UTC) FILETIME=[618009F0:01C33C05]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiroshi Inoue <inoueh@uranus.dti.ne.jp> wrote:
>
> Hi, 
> 
> I found that kernel 2.5.73 (and also 2.4.21) crashed 
> in drivers/char/tty_io.c at situation described below.
> 
> 1. login to tty2 (not tty1)
> 2. start kon (Kanji cONsole emulator, console which support
>    Japanese characters)
> 3. exit kon
> 4. logout
> 
> This crash is repeatable.
> I use Redhat 9 on ThinkPad T20.

whee, it dies most gruesomely.

However I fear that your fix may not be addressing the real source of the
problem.  Why do we get to running release_mem() against a tty which isn't
on the list in the first place?  Any ideas?

