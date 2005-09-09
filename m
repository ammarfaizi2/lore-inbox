Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbVIIT7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbVIIT7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbVIIT7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:59:16 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:49644 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030408AbVIIT7P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:59:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q0sUAqfZsH7DadzQi/GjPmSQHiKNHNA2Su83bsQJebo8n6kplyD0XdqE4vBaOVxEoXlEG/NwNslvhs6tsQMZeWgPuHHdO9MJ+K5Ijr/7z8htkpqV29CJ23+t0VsObzC5k1WPXZAML6tv6ZFowalXmTPM6jPaSQQrKeLT/l63wAI=
Message-ID: <29495f1d05090912591d55be5f@mail.gmail.com>
Date: Fri, 9 Sep 2005 12:59:08 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: Luben Tuikov <luben_tuikov@adaptec.com>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4321E51F.8040906@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4321E51F.8040906@adaptec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/05, Luben Tuikov <luben_tuikov@adaptec.com> wrote:
> Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

<snip>


+static int sas_execute_task(struct sas_task *task, void *buffer, int size,
+                           int pci_dma_dir)

<snip>

+                       set_current_state(TASK_INTERRUPTIBLE);
+                       schedule_timeout(HZ);

<snip>

+                               set_current_state(TASK_INTERRUPTIBLE);
+                               schedule_timeout(5*HZ);

Can you use msleep_interruptible() here? I don't see wait-queues in
the immediate vicinity. If not, and you're going for the normal -mm
route (and from there to mainline), can you use
schedule_timeout_interruptible(), please?

Thanks,
Nish
