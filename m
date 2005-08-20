Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVHTTtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVHTTtv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 15:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVHTTtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 15:49:51 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:4878 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1750846AbVHTTtu (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sat, 20 Aug 2005 15:49:50 -0400
Message-ID: <43078954.2030905@symas.com>
Date: Sat, 20 Aug 2005 12:49:40 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b4) Gecko/20050810 SeaMonkey/1.0a
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: sched_yield() makes OpenLDAP slow
References: <43057641.70700@symas.com>	<17157.45712.877795.437505@gargle.gargle.HOWL>	<430666DB.70802@symas.com> <17159.11995.869374.370114@gargle.gargle.HOWL>
In-Reply-To: <17159.11995.869374.370114@gargle.gargle.HOWL>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
> That returns us to the core of the problem: sched_yield() is used to
> implement a synchronization primitive and non-portable assumptions are
> made about its behavior: SUS defines that after sched_yield() thread
> ceases to run on the CPU "until it again becomes the head of its thread
> list", and "thread list" discipline is only defined for real-time
> scheduling policies. E.g., 
>
> int sched_yield(void)
> {
>        return 0;
> }
>
> and
>
> int sched_yield(void)
> {
>        sleep(100);
>        return 0;
> }
>
> are both valid sched_yield() implementation for non-rt (SCHED_OTHER)
> threads.
I think you're mistaken:
http://groups.google.com/group/comp.programming.threads/browse_frm/thread/0d4eaf3703131e86/da051ebe58976b00#da051ebe58976b00

sched_yield() is required to be supported even if priority scheduling is 
not supported, and it is required to cause the calling thread (not 
process) to yield the processor.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

