Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTFKFGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 01:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTFKFGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 01:06:49 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:10145 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261308AbTFKFGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 01:06:48 -0400
Date: Tue, 10 Jun 2003 22:21:16 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 (virgin) hangs running SDET
Message-Id: <20030610222116.2fb9c001.akpm@digeo.com>
In-Reply-To: <25140000.1055307962@[10.10.2.4]>
References: <60380000.1055188542@flay>
	<20030609140834.11ad0d63.akpm@digeo.com>
	<5930000.1055254447@[10.10.2.4]>
	<12190000.1055266471@flay>
	<20030610124613.40e65da7.akpm@digeo.com>
	<25140000.1055307962@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2003 05:20:31.0228 (UTC) FILETIME=[2D6183C0:01C32FD9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> OK, did that. your patches + debug up the wazoo. Bugger all output,
>  and a hang that looks similar, but the culprit is hiding even more,
>  as far as I can't see ;-(

yes, nobody's spinning on the /proc lock any more.

I don't understand why all the tasks in set_cpus_allowed() are showing up
as being in " R " state.  Possibly the wait_for_completion() in there is
stack gunk and they're really spinning on the runqueue lock?

You haven't tried disabling sched_migrate_task() yet?


