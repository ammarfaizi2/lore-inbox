Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTD3PSe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbTD3PSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:18:34 -0400
Received: from fluent2.pyramid.net ([206.100.220.213]:28322 "EHLO
	fluent2.pyramid.net") by vger.kernel.org with ESMTP id S262192AbTD3PSd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:18:33 -0400
X-Not-Legal-Opinion: IANAL I am not a lawyer
X-For-Entertainment-Purposes-Only: True
Message-Id: <5.2.0.9.0.20030430082756.00a73730@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 30 Apr 2003 08:30:51 -0700
To: Shesha@asu.edu, linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: Why throughput increases as MTU size is increased
In-Reply-To: <Pine.GSO.4.21.0304300706400.28571-100000@general2.asu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:10 AM 4/30/03 -0700, Shesha@asu.edu wrote:
>  When I measure the performance of iSCSI on XScale with MTU size = 1500 
> bytes,
>a throughput of 32 Mbps was observed. As the MTU size was increased, the
>throughput also increased.
>1500 -> 32 Mbps
>3000 -> 56
>4500 -> 80
>6000 -> 100
>7500 -> 108
>9000 -> 108

The non-linear increase as you change MTU is the dead give-away:  the 
slow-start algorithm is working just fine.  The reason you didn't get 
double the throughput as you doubled the MTU is that the slow-start 
algorithm ramps based on packet count, so as you increase the MTU the 
packet rate slope remains reasonably constant.  If you have the source 
code, you can turn off slow-start using setsocketopt(), and see what happens.

Have you considered trying a longer file?


--
X -> unknown; Spurt -> drip of water under pressure
Expert -> X-Spurt -> Unknown drip under pressure.

