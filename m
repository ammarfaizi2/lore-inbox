Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbTLIUXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266098AbTLIUXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:23:01 -0500
Received: from mail.kroah.org ([65.200.24.183]:20953 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265173AbTLIUVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:21:02 -0500
Date: Tue, 9 Dec 2003 12:19:33 -0800
From: Greg KH <greg@kroah.com>
To: Svetoslav Slavtchev <svetljo@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in kobject_get at lib/kobject.c:439
Message-ID: <20031209201933.GA13882@kroah.com>
References: <9528.1070977894@www16.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9528.1070977894@www16.gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 02:51:34PM +0100, Svetoslav Slavtchev wrote:
> 
> Call Trace: [<c017fb84>]  [<c01991f2>]  [<c01995b4>]  [<c01dd15d>] 
> [<c01cbabc>]
>   [<c01cbca8>]  [<c0337fd8>]  [<c03306ce>]  [<c01050b4>]  [<c0105082>] 
> [<c01091f1>]

Can you enable CONFIG_KALLSYMS in your .config, rebuild, and then report
the decoded oops message?

Also a copy of your .config you are using that generates this would be
appreciated.

Odds are you are using a misc driver that happens to be calling
misc_register() before misc_init() gets called.  Others are reporting
this issue with the rtc driver on ppc64 boxes.

thanks,

greg k-h
