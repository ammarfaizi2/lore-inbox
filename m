Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVDLWWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVDLWWa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVDLWTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:19:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:2293 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262212AbVDLWQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:16:11 -0400
Subject: Re: FUSYN and RT
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org, inaky.perez-gonzalez@intel.com,
       mingo@elte.hu
In-Reply-To: <Pine.OSF.4.05.10504122206230.6111-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10504122206230.6111-100000@da410.phys.au.dk>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1113344159.6394.25.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Apr 2005 15:15:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 13:29, Esben Nielsen wrote:

> You basicly need 3 priorities:
> 1) Actual: task->prio
> 2) Base prio with no RT locks taken: task->static_prio
> 3) Base prio with no Fusyn locks taken: task->??
> 
> So no, you will not need the same API, at all :-) Fusyn manipulates
> task->static_prio and only task->prio when no RT lock is taken. When the
> first RT-lock is taken/released it manipulates task->prio only. A release
> of a Fusyn will manipulate task->static_prio as well as task->prio.

mutex_setprio() , I don't know if you could call that an API but that's
what I was talking about.. They should both use that. I think it would
be better if the RT mutex (and fusyn) didn't depend on a field in the
task_struct to retain the old priority. That would make it easier ..

This goes back to the assumption that the locking isn't intermingled
once you get into the kernel . The RT mutex can safely save the owner
priority with out a Fusyn jumping in and changing it and the other way
around..

Daniel

