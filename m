Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWAaJLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWAaJLB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 04:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWAaJLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 04:11:01 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:55499 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750719AbWAaJLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 04:11:00 -0500
Message-ID: <43DF3BB7.B423AC08@tv-sign.ru>
Date: Tue, 31 Jan 2006 13:28:07 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/3] pidhash: don't use zero pids
References: <43DDF323.4517C349@tv-sign.ru> <m1r76p5u7m.fsf@ebiederm.dsl.xmission.com> <43DEFFB7.6010404@sw.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kirill,

Kirill Korotaev wrote:
> 
> Hello Oleg,
> 
> I had quite the same comment, but had no time to check it.
> I can't understand what problem do you solve, or just making code
> cleaner (from your point of view)?

Please look at http://marc.theaimsgroup.com/?t=113851660700001

> For me it was quite natural that pid=0 is used by idle, and I'm very
> suspicuos about such changes.

This patch does not change idle's pid, it is still 0. It changes ->pgrp
and ->session only from 0 to 1. Currently kernel threads run with 0,0
unless they call daemonize() which does set_special_pids(1, 1).

Oleg.
