Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbTIMCEy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 22:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbTIMCEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 22:04:54 -0400
Received: from mail.webmaster.com ([216.152.64.131]:59368 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261988AbTIMCEx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 22:04:53 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Iker" <iker@computer.org>, <linux-kernel@vger.kernel.org>
Subject: RE: self piping and context switching
Date: Fri, 12 Sep 2003 19:04:50 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKCECHGIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <039401c37995$0f30cbd0$3203a8c0@duke>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Assume a thread is monitoring a set of fd's which include both ends of
> a pipe (using poll, for example). If the thread writes to the pipe (in
> order to notify itself for whatever reason) is it reasonable to expect
> that it will be able to return to its poll loop and get the event
> without a context switch? (provided it quickly returns to the poll
> loop).

	It's reasonable to expect that this will be the most common case and the
one to optimize. It is unreasonable to fail if this doesn't happen, since
it's not guaranteed to happen. Note that if by "without a context switch"
you really mean without another thread getting a chance to run, then it is
totally unreasonable. On SMP systems and with hyper-threading, threads can
run concurrently.

	DS


