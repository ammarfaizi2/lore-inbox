Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267407AbUGVXgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267407AbUGVXgx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 19:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUGVXdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 19:33:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:16276 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267379AbUGVXat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 19:30:49 -0400
Date: Thu, 22 Jul 2004 19:29:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: [announce] HVCS for inclusion in 2.6 tree
Message-Id: <20040722192952.2cc0bd05.akpm@osdl.org>
In-Reply-To: <1090528007.3161.7.camel@localhost>
References: <1089819720.3385.66.camel@localhost>
	<16633.55727.513217.364467@cargo.ozlabs.ibm.com>
	<1090528007.3161.7.camel@localhost>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Arnold <rsa@us.ibm.com> wrote:
>
>
> +/* This function is executed by the driver "rescan" sysfs entry */
> +static int hvcs_rescan_devices_list(void)
> +{
> +	struct hvcs_struct *hvcsd = NULL;
> +	unsigned long flags;
> +
> +	/* Locking issues? */
> +	list_for_each_entry(hvcsd, &hvcs_structs, next) {
> 

Well yes.  hvcs_structs definitely needs locking.  If it's easy to do then
slapping a semaphore around it should be a five-minute job.  If it's hard
to do then now is the best time to do it, while the code is fresh in one's
mind, no?

