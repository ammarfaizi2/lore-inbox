Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936340AbWLFQOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936340AbWLFQOT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936250AbWLFQOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:14:19 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:36723 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936340AbWLFQOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:14:16 -0500
Date: Wed, 6 Dec 2006 08:15:37 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: sparse errors in srcu.h
Message-ID: <20061206161537.GA2013@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <45769256.1070400@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45769256.1070400@ens-lyon.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 10:50:14AM +0100, Brice Goglin wrote:
> Hi,
> 
> When running sparse checks on a file that ends up including srcu.h, we
> get the following warnings:
> 
>     include/linux/srcu.h:52:44: error: undefined identifier 'sp'
>     include/linux/srcu.h:52:44: error: bad constant expression
>     include/linux/srcu.h:53:56: error: undefined identifier 'sp'
>     include/linux/srcu.h:53:56: error: bad constant expression
> 
> It seems to be caused by the following lines:
> 
>     int srcu_read_lock(struct srcu_struct *sp) __acquires(sp);
>     void srcu_read_unlock(struct srcu_struct *sp, int idx) __releases(sp);
> 
> which come from the following commit.
> 
>     commit 621934ee7ed5b073c7fd638b347e632c53572761
>     Author: Paul E. McKenney <paulmck@us.ibm.com>
>     Date:   Wed Oct 4 02:17:02 2006 -0700
> 
>     [PATCH] srcu-3: RCU variant permitting read-side blocking
> 
> 
> I was wondering if there is a way to fix those errors...

I believe that you need to update your version of sparse to 0.1.
See http://lwn.net/Articles/208312/ for more info.

							Thanx, Paul
