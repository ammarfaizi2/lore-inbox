Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267351AbUGVW6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267351AbUGVW6h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 18:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267353AbUGVW6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 18:58:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:10215 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267351AbUGVW6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 18:58:35 -0400
Date: Thu, 22 Jul 2004 18:57:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: [announce] HVCS for inclusion in 2.6 tree
Message-Id: <20040722185733.2806e615.akpm@osdl.org>
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

A little stylistic thing:

> +	struct hvcs_struct *hvcsd = (struct hvcs_struct *)tty->driver_data;
> +	struct hvcs_struct *hvcsd = (struct hvcs_struct *)tty->driver_data;
> +	struct hvcs_struct *hvcsd = (struct hvcs_struct *)dev_instance;

It's not necessary to add a typecast when assigning to and from a void*. 
In fact, it's harmful: if someone were to later change, say,
tty->driver_data to a `struct foo *', your typecast will suppress the
warning which we would very much like to receive.

