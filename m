Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWALDaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWALDaX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 22:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWALDaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 22:30:23 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:11159 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965011AbWALDaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 22:30:22 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: John Hesterberg <jh@sgi.com>
cc: Matt Helsley <matthltc@us.ibm.com>, Jes Sorensen <jes@trained-monkey.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors 
In-reply-to: Your message of "Wed, 11 Jan 2006 15:39:10 MDT."
             <20060111213910.GA17986@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Jan 2006 14:29:52 +1100
Message-ID: <8699.1137036592@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Hesterberg (on Wed, 11 Jan 2006 15:39:10 -0600) wrote:
>On Wed, Jan 11, 2006 at 01:02:10PM -0800, Matt Helsley wrote:
>> 	Have you looked at Alan Stern's notifier chain fix patch? Could that be
>> used in task_notify?
>
>I have two concerns about an all-tasks notification interface.
>First, we want this to scale, so don't want more global locks.
>One unique part of the task notify is that it doesn't use locks.

Neither does Alan Stern's atomic notifier chain.  Indeed it cannot use
locks, because the atomic notifier chains can be called from anywhere,
including non maskable interrupts.  The downside is that Alan's atomic
notifier chains require RCU.

An alternative patch that requires no locks and does not even require
RCU is in http://marc.theaimsgroup.com/?l=linux-kernel&m=113392370322545&w=2

