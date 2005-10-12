Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVJLCjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVJLCjw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 22:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVJLCjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 22:39:52 -0400
Received: from science.horizon.com ([192.35.100.1]:33097 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932094AbVJLCjw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 22:39:52 -0400
Date: 11 Oct 2005 22:39:50 -0400
Message-ID: <20051012023950.5261.qmail@science.horizon.com>
From: linux@horizon.com
To: cfriesen@nortel.com, linux@horizon.com
Subject: Re: SMP syncronization on AMD processors (broken?)
Cc: dev@sw.ru, linux-kernel@vger.kernel.org
In-Reply-To: <434C710C.2040305@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This may work on some processors, but on others the read of "progress" 
> in XXX, or the write in YYY may require arch-specific code to force the 
> update out to other cpus.
> 
> Alternately, explicitly atomic operations should suffice, but a simple 
> increment is probably not enough for portable code.

Er.. you mean, the pre-incremented value could be cached *indefinitely*
by XXX?  That seems odd...

I can see an arch hook (memory barrier sort of thuing) to push it out a
bit faster, but are there architecures on which noticing the increment
could be delayed indefinitely?

In particular, that same hook would already be used by the spin lock
release sequence (to ensure that someone else notices the lock is now
available), and unless it's address-specific, it would do for the
"progress" counter as well.
