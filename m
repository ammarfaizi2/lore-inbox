Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVHSXKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVHSXKU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbVHSXKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:10:20 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:29194 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S932321AbVHSXKU (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Fri, 19 Aug 2005 19:10:20 -0400
Message-ID: <430666DB.70802@symas.com>
Date: Fri, 19 Aug 2005 16:10:19 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b4) Gecko/20050810 SeaMonkey/1.0a
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: sched_yield() makes OpenLDAP slow
References: <43057641.70700@symas.com> <17157.45712.877795.437505@gargle.gargle.HOWL>
In-Reply-To: <17157.45712.877795.437505@gargle.gargle.HOWL>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
>  Howard Chu <hyc@symas.com> writes:
> > concurrency. It is the nature of such a system to encounter
> > deadlocks over the normal course of operations. When a deadlock is
> > detected, some thread must be chosen (by one of a variety of
> > algorithms) to abort its transaction, in order to allow other
> > operations to proceed to completion. In this situation, the chosen
> > thread must get control of the CPU long enough to clean itself up,

>  What prevents transaction monitor from using, say, condition
>  variables to "yield cpu"? That would have an additional advantage of
>  blocking thread precisely until specific event occurs, instead of
>  blocking for some vague indeterminate load and platform dependent
>  amount of time.

Condition variables offer no control over which thread is waken up. 
We're wandering into the design of the SleepyCat BerkeleyDB library 
here, and we don't exert any control over that either. BerkeleyDB 
doesn't appear to use pthread condition variables; it seems to construct 
its own synchronization mechanisms on top of mutexes (and yield calls). 
In this specific example, we use whatever BerkeleyDB provides and we're 
certainly not about to write our own transactional embedded database 
engine just for this.
-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

