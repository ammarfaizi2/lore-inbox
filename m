Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbTHUP3i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTHUP3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:29:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:5778 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262734AbTHUP3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:29:36 -0400
Subject: Re: CPU boot problem on 2.6.0-test3-bk8
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <200308210910.07722.habanero@us.ibm.com>
References: <200308201658.05433.habanero@us.ibm.com>
	 <200308202013.51702.habanero@us.ibm.com>
	 <1061437329.15363.92.camel@nighthawk>
	 <200308210910.07722.habanero@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1061479688.19036.1699.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Aug 2003 08:28:08 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-21 at 07:10, Andrew Theurer wrote:
> Still looks like we have a problem (see attached boot log).  Maybe we should 
> change that for loop to:
> 
> for (bit = 0; kicked < num_processors && bit < BITS_PER_LONG; bit++)
> 
> So we only loop for the actual number processors found in mpparse.c?  This 
> seems to work for me.

You have something else wrong too:

[dave@nighthawk temp]$ egrep -c ^CPU\[0-9\]+: 260test3bk8patch1      
20

It looks like you booted 20 processors, successfully.  

You have 5 "Geniune" cpus and 16 "Xeon" cpus.  Are you using plain
summit, or generic arch support?

$ egrep ^CPU\[0-9\]+: 260test3bk8patch1 
CPU0: Intel(R) Genuine CPU 1.50GHz stepping 01
CPU1: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
CPU2: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
CPU3: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
CPU4: Intel(R) Genuine CPU 1.50GHz stepping 01
CPU5: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
CPU6: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
CPU7: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
CPU8: Intel(R) Genuine CPU 1.50GHz stepping 01
CPU9: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
CPU10: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
CPU11: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
CPU12: Intel(R) Genuine CPU 1.50GHz stepping 01
CPU13: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
CPU14: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
CPU15: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
CPU16: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
CPU17: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
CPU18: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
CPU19: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01


-- 
Dave Hansen
haveblue@us.ibm.com

