Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWDLCce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWDLCce (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 22:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWDLCce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 22:32:34 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:57044 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751308AbWDLCcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 22:32:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:resent-from:resent-date:resent-message-id:resent-to:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=L6X0OxZfei+utoGcUD7bemVxUF0h/BJlOBNRbBVmRIlcZQMB7trnr6QnQn5BDIF5LN1bYXurXpzy7rtS/IBD4HzKUp+RANaXWBBgXjEXltWzf442NTLjbE3Epmu77ftmyAERQDulaQERuiFmaDMhBmmnb7XdqZBkNDqU2M/XWWY=
Date: Wed, 12 Apr 2006 10:13:40 +0800
From: lepton <ytht.net@gmail.com>
To: lkm@gsy2.lepton.home
Subject: 386/smp issue with atomic_add_return()
Message-ID: <20060412021340.GA6718@gsy2.lepton.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
	Is there any smp box with 386 cpu?
	If it exist, then I think atomic_add_return has a problem.
	Just disabling local interrupts can not keep another cpu from entering this function.
	What do you think about this?

	This is the code (copied from 2.6.16.4):

	#ifdef CONFIG_M386
 no_xadd: /* Legacy 386 processor */
        local_irq_disable();
        __i = atomic_read(v);
        atomic_set(v, i + __i);
        local_irq_enable();
        return i + __i;
	#endif
