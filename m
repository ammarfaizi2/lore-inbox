Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbUKDGko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbUKDGko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 01:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbUKDGkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 01:40:43 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:57869 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262095AbUKDGjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:39:46 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Russell Miller <rmiller@duskglow.com>, Doug McNaught <doug@mcnaught.org>
Subject: Re: is killing zombies possible w/o a reboot?
Date: Thu, 4 Nov 2004 08:39:34 +0200
User-Agent: KMail/1.5.4
Cc: Jim Nelson <james4765@verizon.net>, DervishD <lkml@dervishd.net>,
       Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?M=E5ns=20Rullg=E5rd?= <mru@inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <87k6t24jsr.fsf@asmodeus.mcnaught.org> <200411031733.30469.rmiller@duskglow.com>
In-Reply-To: <200411031733.30469.rmiller@duskglow.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411040839.34350.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 01:33, Russell Miller wrote:
> On Wednesday 03 November 2004 17:03, Doug McNaught wrote:
> 
> > It was already mentioned in this thread that the bookkeeping required
> > to clean up properly from such an abort would add a lot of overhead
> > and slow down the normal, non-buggy case.
> >
> I am going to continue pursuing this at the risk of making a bigger fool of 
> myself than I already am, but I want to make sure that I understand the 
> issues - and I did read the message you are referring to.
> 
> I think what you are saying is that there is kind of a race condition here.  
> When something is on the wait queue, it has to be followed through to 
> completion.  An interrupt could be received at any time, and if it's taken 
> off of the wait queue prematurely, it'll crash the kernel, because the 
> interrupt has no way of telling that.

The problem is in locking. You must not kill process while it is
in uninterruptible state because it is uninterruptible
for a reason - has taken semaphore, or get_cpu(), etc.
You do want it to do put_cpu(), right?

Processes must never get stuck in D, it's a kernel bug.

Find out how did process ended up in D state forever,
and fix it - that's what I'm trying to do
in these cases.
--
vda

