Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbUB0BT7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbUB0BT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:19:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:11192 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261714AbUB0BRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:17:33 -0500
Date: Thu, 26 Feb 2004 17:19:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ben Collins <bcollins@debian.org>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] SCSI host num allocation improvement
Message-Id: <20040226171928.750f5f6f.akpm@osdl.org>
In-Reply-To: <20040226235412.GA819@phunnypharm.org>
References: <20040226235412.GA819@phunnypharm.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins <bcollins@debian.org> wrote:
>
> +next_host_num_try:
> +	list_for_each_entry(cdev, &class->children, node) {
> +		shost = class_to_shost(cdev);
> +		if (shost->host_no == host_num) {
> +			host_num++;
> +			goto next_host_num_try;

yitch.  I realise this is called rarely, for realtively small numbers of N
(which gets squared), but.

This allocate-me-the-lowest-available-number is a common idiom in the
kernel and we really should do it better.  Seems we need to convert the
dynamic pty allocation to do it as well - it has yet another open-coded
ad-hoc allocator.

The lib/idr.c code is a bit clumsy but it does do the job relatively
efficiently.  If it needs some helper wrappers or API simplification then
let's add those.
