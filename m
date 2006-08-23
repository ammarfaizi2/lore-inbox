Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWHWJzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWHWJzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWHWJzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:55:18 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:45580 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751512AbWHWJzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:55:16 -0400
Message-ID: <44EC2600.3070006@argo.co.il>
Date: Wed, 23 Aug 2006 12:55:12 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: ebiederm@xmission.com
CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com, ak@suse.de
Subject: Re: [RFC][PATCH] ps command race fix take2 [1/4] list token
References: <m1ac5woube.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ac5woube.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Aug 2006 09:55:14.0502 (UTC) FILETIME=[3B134660:01C6C69A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com wrote:
>
> I almost removed the tasklist_lock from all read paths.  But as it
> happens sending a signal to a process group is an atomic operation
> with respect to fork so that path has to take the lock, or else
> we get places where "kill -9 -pgrp" fails to kill every process in
> the process group.  Which is even worse.
>

Can't that be fixed by adding a per-pgrp lock, and having both 
fork()/clone() and kill(-pgrp) take that lock?

-- 
error compiling committee.c: too many arguments to function

