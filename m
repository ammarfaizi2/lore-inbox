Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVFAM6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVFAM6B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 08:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVFAM6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 08:58:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54005 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261171AbVFAM57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 08:57:59 -0400
Date: Wed, 1 Jun 2005 05:57:55 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, sdietrich@mvista.com, rostedt@goodmis.org,
       inaky.perez-gonzalez@intel.com
Subject: Re: [PATCH] Abstracted Priority Inheritance for RT
In-Reply-To: <20050601075414.GA25081@elte.hu>
Message-ID: <Pine.LNX.4.10.10506010542420.23911-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Jun 2005, Ingo Molnar wrote:

> i'd rather not slow things down by callbacks and other abstraction 
> before seeing how things want to integrate in fact. Do we really need 
> the callbacks?

I think it would be hard to do without a way to signal when a waiter
changes priorties. Since other structures could handle it differently.

Another problem is that there needs to be a clear way to know which
structure owns the rt_mutex_waiter . Something in there needs to be 
unique. It can't be assumed anymore that everything is an rt_mutex. 

The lock owner could be put into the rt_mutex_waiter structure. Which
would make the structure bigger, but it's usually stack space. This would
also create some duplicate data since every waiter would need to hold the
owners task_struct pointer. 


Daniel

