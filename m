Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbUCAW3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 17:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUCAW3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 17:29:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:23719 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261460AbUCAW3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 17:29:46 -0500
Date: Mon, 1 Mar 2004 14:31:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org
Subject: Re: per-cpu blk_plug_list
Message-Id: <20040301143139.474fe56e.akpm@osdl.org>
In-Reply-To: <20040301141728.71e49546.akpm@osdl.org>
References: <B05667366EE6204181EABE9C1B1C0EB501F2AB4C@scsmsx401.sc.intel.com>
	<20040301141728.71e49546.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> @@ -1251,6 +1251,9 @@ void blk_run_queues(void)
>  {
>  	LIST_HEAD(local_plug_list);
>  
> +	if (list_empty(&blk_plug_list))
> +		return;
> +

hmm, no, that won't help.  There will always be at least one plugged disk.

Perhaps what we need here is a per-task container of "queues which I have
plugged".  Or, more accurately, "queues which need to be unplugged so that
I can complete".  It'll get tricky because in some situations a task can
need unplugging of a queue which it did not plug, and even a queue to which
it did not submit any I/O.

You should try just nuking the whole plugging scheme, btw.  Stick a bunch
of `return' statements at the top of all the plugging functions.  I bet
that would run nicely...

