Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVCaWy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVCaWy2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVCaWy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:54:28 -0500
Received: from fire.osdl.org ([65.172.181.4]:62855 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262035AbVCaWyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:54:18 -0500
Date: Thu, 31 Mar 2005 14:53:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, aquynh@gmail.com,
       dean-list-linux-kernel@arctic.org, pj@sgi.com
Subject: Re: [patch 2.6.12-rc1-mm4] fork_connector: add a fork connector
Message-Id: <20050331145333.2012bf07.akpm@osdl.org>
In-Reply-To: <1112277542.20919.215.camel@frecb000711.frec.bull.fr>
References: <1112277542.20919.215.camel@frecb000711.frec.bull.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
>
>   This patch adds a fork connector in the do_fork() routine.

>  
> +config FORK_CONNECTOR
> +	bool "Enable fork connector"
> +	depends on CONNECTOR=y

This kind of defeats connector's ability to be built as a module.  Doing

	select CONNECTOR

may be better here.

> +static void cn_fork_callback(void *data) 
> +{
> +	struct cn_msg *msg = (struct cn_msg *)data;

The cast is unnecessary.

>  
>  extern int cn_already_initialized;
> +extern int cn_fork_enable;
> +extern struct cb_id cb_fork_id;

Should these declarations be inside CONFIG_FORK_CONNECTOR?

> +
> +static DEFINE_PER_CPU(unsigned long, fork_counts);
> +

This will cause fork_counts to be defined in each compilation unit which
includes this header file.  You should use DEFINE_PER_CPU in .c and
DECLARE_PER_CPU in .h.

