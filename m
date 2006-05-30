Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbWE3QFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWE3QFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbWE3QFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:05:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44961 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751525AbWE3QFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:05:48 -0400
Subject: Re: [patch, -rc5-mm1] lock validator: remove softirq.c WARN_ON
From: Arjan van de Ven <arjan@infradead.org>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Jiri Slaby <jirislaby@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@vger.kernel.org, alan@redhat.com
In-Reply-To: <20060530160024.GA8987@ms2.inr.ac.ru>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <447C261E.1090202@gmail.com> <20060530115545.GA7025@elte.hu>
	 <20060530160024.GA8987@ms2.inr.ac.ru>
Content-Type: text/plain
Date: Tue, 30 May 2006 18:05:30 +0200
Message-Id: <1149005130.3636.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 20:00 +0400, Alexey Kuznetsov wrote:
> Hello!
> 
> > ok, that WARN_ON is over-eager. Fix is below:
> 
> Nevertheless, I cannot figure out what's happening here.
> 
> This local_bh_disable() is called right after schedule().
> No way irqs can be disabled there. What is wrong?
> 
> 
> static void netlink_table_grab(void)
> {
>         write_lock_bh(&nl_table_lock);

well it could be this one as well...

> 
>         if (atomic_read(&nl_table_users)) {


