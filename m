Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVFBVxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVFBVxr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 17:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVFBVwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 17:52:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7663 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261231AbVFBVum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 17:50:42 -0400
Subject: Re: [PATCH] Abstracted Priority Inheritance for RT
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com, rostedt@goodmis.org,
       inaky.perez-gonzalez@intel.com
In-Reply-To: <Pine.OSF.4.05.10506022017400.3853-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10506022017400.3853-100000@da410.phys.au.dk>
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 02 Jun 2005 14:50:28 -0700
Message-Id: <1117749028.20350.12.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 22:27 +0200, Esben Nielsen wrote:

> But right now the following ideas spring to my mind:
> If it is to solve the problem of having a callback wrap every use
> in macroes and use the TYPE_EQUAL() to expclicit call the right function.
> Only if the explicit type is unknown in the macro use the callback. That
> should optimize stuff a little bit.. Just a wild idea.

It's a little hard to do that. It's basically the situation you have
below, there is no way to know what "waiter" is at compile time, so you
can't really do the TYPE_EQUAL() trick on "get_next_waiter" .

I have "waiter->waiter_changed_prio()" which results in the same
problem. There is no way to know what "type" waiter is at compile
time .. 


> If it is explicitly for PI you can do a thing like
>  waiter->get_next_waiter();
> to resolve the chain of waiters. Then you can have the PI algotithm work
> iteratively without knowing the explicit kind of lock involved.

This is essentially what I have now, but it's also what I'm unhappy
with. The only reason that I don't like this method is that it's a
little slow .. I don't mind keeping it as long as no better way presents
itself. 

Daniel

