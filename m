Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbUJWXyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbUJWXyw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 19:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbUJWXyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 19:54:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:1511 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261283AbUJWXys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 19:54:48 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How is user space notified of CPU speed changes?
References: <1098399709.4131.23.camel@krustophenia.net.suse.lists.linux.kernel>
	<1098444170.19459.7.camel@localhost.localdomain.suse.lists.linux.kernel>
	<1098508238.13176.17.camel@krustophenia.net.suse.lists.linux.kernel>
	<1098566366.24804.8.camel@localhost.localdomain.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Oct 2004 01:54:46 +0200
In-Reply-To: <1098566366.24804.8.camel@localhost.localdomain.suse.lists.linux.kernel>
Message-ID: <p73ekjp7zy1.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> It did
> 
> - The kernel doesn't always know
> - CPU speed is meaningless in hyper-threading since performance is not
> x2 for two cores but instead varies
> - It doesn't handle split CPU speed SMP - where CPU speeds vary
> - God help you if virtualised

Even without virtualization it doesn't make much sense to know the
exact CPU speed for an user process: it never knows how much CPU time
it will get (even with real time scheduling there could be even higher
priority processes)

The solution is to call gettimeofday frequently to resychronize.
It should be cheap enough that it isn't a big issue.

-Andi
 
