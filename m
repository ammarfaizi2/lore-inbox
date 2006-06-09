Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbWFIFmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbWFIFmk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 01:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965217AbWFIFmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 01:42:40 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:15291 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965216AbWFIFmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 01:42:39 -0400
Message-ID: <448909F2.2060306@jp.fujitsu.com>
Date: Fri, 09 Jun 2006 14:41:06 +0900
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@openvz.org>, Srivatsa <vatsa@in.ibm.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>,
       MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Subject: Re: [ckrm-tech] [RFC 0/4] sched: Add CPU rate caps (improved)
References: <20060606023708.2801.24804.sendpatchset@heathwren.pw.nest> <448688B2.2030206@jp.fujitsu.com> <4487D6B0.3080502@bigpond.net.au>
In-Reply-To: <4487D6B0.3080502@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:

> This behaviour is caused by the "make clean" being a short lived CPU 
> intensive task.  It was made worse by the facts that my simplifications 
> to the sinbin duration calculation which assumed a constant CPU burst 
> size based on the time slice and that exiting tasks could still have 
> caps enforced.  (The simplification was done to avoid 64 bit divides.)
> 
> I've put in a more complex sinbin calculation (and don't think the 64 
> bit divides will matter too much as they're on an infrequently travelled 
> path.  Exiting tasks are now excluded from having caps enforced on the 
> grounds that it's best for system performance to let them get out of the 
> way as soon as possible.  A patch is attached and I would appreciate it 
> if you could see if it improves the situation you are observing.

Sorry for my late reply.

The followings are the results of patched kernel. Unfortunately,
the patch doesn't seem to help my situation.

$ ~/withcap.sh  -C 900 /usr/bin/time make clean
1.61user 0.29system 1:33.94elapsed 2%CPU

$ ~/withcap.sh  -C 100 /usr/bin/time make clean
1.68user 0.27system 3:34.45elapsed 0%CPU

Thanks,
MAEDA Naoaki

