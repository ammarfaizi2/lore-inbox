Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVD0AYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVD0AYM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 20:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVD0AYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 20:24:12 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46584 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261843AbVD0AYJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 20:24:09 -0400
Subject: Re: del_timer_sync needed for UP  RT systems.
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: george@mvista.com
Cc: ganzinger@mvista.com, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <426ED97B.4050204@mvista.com>
References: <426ED1EC.80500@mvista.com>
	 <1114559749.12773.67.camel@dhcp153.mvista.com>
	 <426ED97B.4050204@mvista.com>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1114561446.12772.71.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Apr 2005 17:24:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 17:14, George Anzinger wrote:

> The problem here is that the reference is to timr, a pointer to something which 
> has been deleted.  The memory may well be used elsewhere by this time which will 
> make the test of it_process wrong.  It also means we could mess with someone 
> elses memory in the memset above.

Bottom line, you can use sys_timer_delete() on a timer, and trigger the
same timer your deleting .. Those operations should be serialized, which
they currently aren't .. 


Daniel

