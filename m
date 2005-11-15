Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVKOESF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVKOESF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 23:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVKOESF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 23:18:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54176 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932363AbVKOESD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 23:18:03 -0500
Date: Mon, 14 Nov 2005 20:17:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [RFC][Patch 0/4] Per-task delay accounting
Message-Id: <20051114201741.3d5496b3.akpm@osdl.org>
In-Reply-To: <4379658E.1020707@watson.ibm.com>
References: <4379658E.1020707@watson.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
> They are made available through a connector interface which allows
>  - stats for a given <pid> to be obtained in response to a command
>  which specifies the <pid>. The need for dynamically obtaining delay
>  stats is the reason why piggybacking delay stats onto BSD process
>  accounting wasn't considered.

I think this is the first time that anyone has come out with real code
which does per-task accounting via connector.

Which makes one wonder where this will end up.  If numerous different
people add numerous different accounting messages, presumably via different
connector channels then it may all end up a bit of a mess.  Given the way
kernel development happens, that's pretty likely.

For example, should the next developer create a new message type, or should
he tack his desired fields onto the back of yours?  If the former, we'll
end up with quite a lot of semi-duplicated code and a lot more messages and
resources than we strictly need.  If the latter, then perhaps the
versioning you have in there will suffice - I'm not sure.

I wonder if at this stage we should take a shot at some overarching "how do
do per-task accounting messages over connector" design which can at least
incorporate the various things which people have been talking about
recently?
