Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWFMPAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWFMPAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 11:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWFMPAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 11:00:16 -0400
Received: from rtr.ca ([64.26.128.89]:46050 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751168AbWFMPAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 11:00:14 -0400
Message-ID: <448ED2FC.2040704@rtr.ca>
Date: Tue, 13 Jun 2006 11:00:12 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.17: networking bug??
References: <448EC6F3.3060002@rtr.ca> <448ECB09.3010308@rtr.ca>
In-Reply-To: <448ECB09.3010308@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
..
> The differences I see are widely varying "window sizes".
> What would cause this?

This is from (working) 2.6.16.18:
> IP silvy.localnet.56224 > 216-145-246-23.rev.dls.net.www: . ack 1 win 1460 <nop,nop,timestamp 730448 134760199>
> IP silvy.localnet.56224 > 216-145-246-23.rev.dls.net.www: P 1:607(606) ack 1 win 1460 <nop,nop,timestamp 730448 134760199>
> IP 216-145-246-23.rev.dls.net.www > silvy.localnet.56224: P 1:206(205) ack 607 win 32798 <nop,nop,timestamp 134760217 730448>
> IP silvy.localnet.56224 > 216-145-246-23.rev.dls.net.www: . ack 206 win 1728 <nop,nop,timestamp 730626 134760217> 

This is from (failing) 2.6.17-rc6-git2:
> IP silvy.localnet.33472 > 216-145-246-23.rev.dls.net.www: . ack 1 win 92 <nop,nop,timestamp 4294759337 134771817>
> IP silvy.localnet.33472 > 216-145-246-23.rev.dls.net.www: P 1:607(606) ack 1 win 92 <nop,nop,timestamp 4294759337 134771817>
> IP silvy.localnet.33472 > 216-145-246-23.rev.dls.net.www: P 1:607(606) ack 1 win 92 <nop,nop,timestamp 4294760162 134771817>
> IP 216-145-246-23.rev.dls.net.www > silvy.localnet.33472: . ack 607 win 32798 <nop,nop,timestamp 134771918 4294760162> 

Both kernels default to /proc/sys/net/ipv4/tcp_window_scaling == 1,
and 2.6.16.18 works regardless of whether I turn it off/on again.

But 2.6.17-rc6-git2 fails to work with the webserver at www.everymac.com
when /proc/sys/net/ipv4/tcp_window_scaling == 1.  Setting this to 0
"fixes" the problem.

BUG.
