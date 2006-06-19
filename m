Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWFSKZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWFSKZV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 06:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWFSKZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 06:25:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27567 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932350AbWFSKZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 06:25:20 -0400
Date: Mon, 19 Jun 2006 03:24:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, jes@sgi.com, lse-tech@lists.sourceforge.net,
       sekharan@us.ibm.com, stern@rowland.harvard.edu, jtk@us.ibm.com,
       balbir@in.ibm.com, nagar@watson.ibm.com
Subject: Re: [PATCH 00/11] Task watchers:  Introduction
Message-Id: <20060619032453.2c19e32c.akpm@osdl.org>
In-Reply-To: <1150242721.21787.138.camel@stark>
References: <1150242721.21787.138.camel@stark>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006 16:52:01 -0700
Matt Helsley <matthltc@us.ibm.com> wrote:

> Task watchers is a notifier chain that sends notifications to registered
> callers whenever a task forks, execs, changes its [re][ug]id, or exits.

Seems a reasonable objective - it'll certainly curtail (indeed, reverse)
the ongoing proliferation of little subsystem-specific hooks all over the
core code, will allow us to remove some #includes from core code and should
permit some more things to be loaded as modules.

But I do wonder if it would have been better to have separate chains for
each of WATCH_TASK_INIT, WATCH_TASK_EXEC, WATCH_TASK_UID, WATCH_TASK_GID,
WATCH_TASK_EXIT.  That would reduce the number of elements which need to be
traversed at each event and would eliminate the need for demultiplexing at
each handler.

