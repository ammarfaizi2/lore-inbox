Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbVCWGtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbVCWGtQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 01:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVCWGtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 01:49:16 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:27559 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262827AbVCWGtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 01:49:13 -0500
Date: Wed, 23 Mar 2005 07:48:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: segmentation fault while loading modules
In-Reply-To: <Pine.LNX.4.60.0503231042480.21050@lantana.cs.iitm.ernet.in>
Message-ID: <Pine.LNX.4.61.0503230744430.21578@yvahk01.tjqt.qr>
References: <Pine.LNX.4.60.0503231042480.21050@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> int
> ksignal(int pid,int signum)
> {
> struct task_struct x;
> struct task_struct *p;
> /* run through the task list of linux until we find our pid */
> //for (p = &init_task ; (p = next_task(p)) != &init_task ; ){
> for (p = &x ; (p = next_task(p)) != &x ; ){
...

next_task(p) is defined (not in the sense of a macro, though) as 
  p->tasks.next
and your x is not initiailzed, so what do you expect next_task(x)
to do, if p->tasks... does not contain a valid value?

You want this:
for(p = &init_task; (p = next_task(p)) != &init_task; ) {
    ...
}


Jan Engelhardt
-- 
