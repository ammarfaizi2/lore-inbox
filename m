Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbUDHN3a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 09:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUDHN3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 09:29:30 -0400
Received: from [194.67.69.111] ([194.67.69.111]:25745 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S261748AbUDHN33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 09:29:29 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200404081329.RAA16178@yakov.inr.ac.ru>
Subject: Re: route cache DoS testing and softirqs
To: Robert.Olsson@data.slu.se (Robert Olsson)
Date: Thu, 8 Apr 2004 17:29:13 +0400 (MSD)
Cc: dipankar@in.ibm.com, Robert.Olsson@data.slu.se (Robert Olsson),
       andrea@suse.de (Andrea Arcangeli), davem@redhat.com (David S. Miller),
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       paulmck@us.ibm.com, akpm@osdl.org
In-Reply-To: <16498.43191.733850.18276@robur.slu.se> from "Robert Olsson" at  =?ISO-8859-1?Q?=20=E1?=
	=?ISO-8859-1?Q?=D0=D2?= 06, 2004 02:55:19 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> setup. I've done a little experimental patch so *all* softirq's are run via 
> ksoftirqd. 

BTW what's about performance in this extremal situation?

Also, Robert, let's count the numbers again. With this change you should
have latency much less 100msec when priority of ksoftirqd is high.
So, rcu problem must be solved at current flow rates.
This enforces me to suspect we have another source of overflows.
F.e. one silly place could be that you set gc_min_interval via sysctl,
which uses second resolution (yup :-(). With one second you get maximal
ip_rt_max_size/1 second flow rate, it is _not_ a lot.

Alexey
