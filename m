Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272746AbTHKPMW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272747AbTHKPMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:12:22 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:29579
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272746AbTHKPMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:12:21 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm1
Date: Tue, 12 Aug 2003 01:17:48 +1000
User-Agent: KMail/1.5.3
References: <20030809203943.3b925a0e.akpm@osdl.org> <94490000.1060612530@[10.10.2.4]>
In-Reply-To: <94490000.1060612530@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308120117.48938.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003 00:35, Martin J. Bligh wrote:
> Degredation on kernbench is still there:
>
> Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
>                               Elapsed      System        User         CPU
>               2.6.0-test3       45.97      115.83      571.93     1494.50
>           2.6.0-test3-mm1       46.43      122.78      571.87     1496.00
>
> Quite a bit of extra sys time. I thought the suspected part of the sched
> changes got backed out, but maybe I'm just not following it ...

It was plus and minus. I've improved my hacks, but the A3 patch nanosecond 
timing will add extra overhead/locking. I'm not sure how you can compare 
these to the last ones you posted:

                              Elapsed      System        User         CPU
              2.6.0-test2       46.05      115.20      571.75     1491.25
          2.6.0-test2-con       46.98      121.02      583.55     1498.75
          2.6.0-test2-mm1       46.95      121.18      582.00     1497.50

I'll take a stab in the dark and say the nanosecond timing is a big part now. 
Backing out all the O*int patches in broken-out of 2.6.0-test3-mm1 should 
help identify that. 

I have an idea on how to trim the nanosecond overhead as well. The sched clock 
should be called if the timing is less than say two jiffies only. That will 
mean it will be called far less frequently.

Con

