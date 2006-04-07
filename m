Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWDGOqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWDGOqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWDGOqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:46:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932409AbWDGOqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:46:44 -0400
Date: Fri, 7 Apr 2006 07:46:27 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Frank Pavlic <fpavlic@de.ibm.com>
Subject: Re: [patch] ipv4: initialize arp_tbl rw lock
Message-ID: <20060407074627.2f525b2e@localhost.localdomain>
In-Reply-To: <20060407081533.GC11353@osiris.boeblingen.de.ibm.com>
References: <20060407081533.GC11353@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2006 10:15:33 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> The qeth driver makes use of the arp_tbl rw lock. CONFIG_DEBUG_SPINLOCK
> detects that this lock is not initialized as it is supposed to be.
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---

This is a initialization order problem then, because:
	arp_init
	   neigh_table_init
		rwlock_init

does the initialization already. So fix the initialization sequence
of the qeth driver or you will have other problems.

My impression was the -rt folks wanted all lock initializations t be
done at runtime not compile time.
