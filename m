Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264886AbUFRAc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264886AbUFRAc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 20:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbUFRAc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 20:32:59 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:7046 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264886AbUFRAc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 20:32:56 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 17 Jun 2004 17:32:53 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Ben Greear <greearb@candelatech.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: poll
In-Reply-To: <Pine.LNX.4.53.0406171958570.3414@chaos>
Message-ID: <Pine.LNX.4.58.0406171726000.24496@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.53.0406170954190.702@chaos> <40D21C8E.4040500@candelatech.com>
 <Pine.LNX.4.53.0406171958570.3414@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004, Richard B. Johnson wrote:

> This all works fine-and-dandy with kernel 2.4.26. However, Linux
> has a history of removing availability of undefined things.

It'd work just fine in 2.6. The poll infrastructure is just a proxy to the 
event core, and shouldn't mask anything. Your driver's f_op->poll will 
return a mask, and this will be and'ed with the mask that you pass to poll(2). 
Non-zero results will be reported to you. Just do not use bits 30 and 31 
if you want it to work with epoll.



- Davide

