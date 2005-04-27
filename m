Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVD0Aau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVD0Aau (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 20:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVD0Aau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 20:30:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40435 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261865AbVD0Aap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 20:30:45 -0400
Subject: Re: del_timer_sync needed for UP  RT systems.
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: george@mvista.com
Cc: ganzinger@mvista.com, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1114561446.12772.71.camel@dhcp153.mvista.com>
References: <426ED1EC.80500@mvista.com>
	 <1114559749.12773.67.camel@dhcp153.mvista.com>
	 <426ED97B.4050204@mvista.com>
	 <1114561446.12772.71.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1114561842.12777.73.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Apr 2005 17:30:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 17:24, Daniel Walker wrote:
> On Tue, 2005-04-26 at 17:14, George Anzinger wrote:
> 
> > The problem here is that the reference is to timr, a pointer to something which 
> > has been deleted.  The memory may well be used elsewhere by this time which will 
> > make the test of it_process wrong.  It also means we could mess with someone 
> > elses memory in the memset above.
> 
> Bottom line, you can use sys_timer_delete() on a timer, and trigger the
> same timer your deleting .. Those operations should be serialized, which
> they currently aren't .. 

Um, sorry typo, you _can't_ delete a timer, and trigger it at the same
time. That's bad.

Daniel

