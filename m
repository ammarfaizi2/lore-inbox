Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbUJ0D7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbUJ0D7z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbUJ0D7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:59:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:63456 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261434AbUJ0D7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:59:54 -0400
Date: Tue, 26 Oct 2004 20:57:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Leber <christian@leber.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] trivial sysrq addon
Message-Id: <20041026205748.709b768b.akpm@osdl.org>
In-Reply-To: <20041023194239.GA21432@core.home>
References: <20041023194239.GA21432@core.home>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Leber <christian@leber.de> wrote:
>
> I think sysrq needs a key to call oom_kill manually.

oy, you can't do that - oom_kill() takes non-IRQ-safe locks.

You'll have to use schedule_work() to punt the operation up to process
context.
