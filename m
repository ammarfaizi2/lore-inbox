Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVBLA4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVBLA4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 19:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVBLA4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 19:56:21 -0500
Received: from orb.pobox.com ([207.8.226.5]:61084 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262378AbVBLA4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 19:56:14 -0500
Date: Fri, 11 Feb 2005 18:56:09 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6-bk: cpu hotplug + preempt = smp_processor_id warnings galore
Message-ID: <20050212005609.GB14499@otto>
References: <20050211232821.GA14499@otto> <420D4646.4010600@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420D4646.4010600@tiscali.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 12:56:54AM +0100, Matthias-Christian Ott wrote:
> Nathan Lynch wrote:
> 
> >With 2.6.11-rc3-bk7 on ppc64 I am seeing lots of smp_processor_id
> >warnings whenever I hotplug cpus:
...
>
> Use get_cpu() (It disables preemption) or __smp_processor_id () (on a smp).

It's not necessarily that simple (ok, maybe the idle loop warning is).
But at least one of the warnings I listed appears to be caused by a
kernel thread that is normally bound to a particular cpu trying to do
normal processing on another cpu before it has stopped.  Injudicious
use of __smp_processor_id or get_cpu in this case would only obscure
the problem.


Nathan

