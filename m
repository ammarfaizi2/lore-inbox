Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVEIQNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVEIQNd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 12:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVEIQNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 12:13:33 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:18609 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261434AbVEIQN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 12:13:27 -0400
Message-ID: <427F8DE2.50DAD436@tv-sign.ru>
Date: Mon, 09 May 2005 20:20:50 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [PATCH 2/4] rt_mutex: add new plist implementation
References: <Pine.LNX.4.44.0505090840010.14167-100000@dhcp153.mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
>
> On Mon, 9 May 2005, Oleg Nesterov wrote:
>
> > This patch adds new plist implementation, see
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=111547290706136
> >
> > Changes:
> >
> > 	added plist_next_entry() helper (was plist_entry)
> >
> > 	added plist_unhashed() helper, see PATCH 4/4
> >
>
> 	Naw , stick with Inaky's API ..

This patch breaks Inaky's API anyway, plist_del() now has only one
argument, and I think this is good.

I don't mind doing s/plist_next_entry/plist_entry/ if you wish,
but I think this is consistent with plist_next/plist_prev helpers.

And original plist_empty() is confusing. When used on plist's head
it is ok, but it is wrong to use plist_empty(&plist_node).

> Your stuff looks nothing like list.h ..

Is it bad?

Yes, plist_empty/plist_unhashed mimics hlist_empty/hlist_unhashed.

Oleg.
