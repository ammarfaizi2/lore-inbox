Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVIJHO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVIJHO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 03:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932711AbVIJHO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 03:14:56 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:34728 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932262AbVIJHO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 03:14:56 -0400
Date: Sat, 10 Sep 2005 16:11:45 +0900 (JST)
Message-Id: <20050910.161145.74742186.taka@valinux.co.jp>
To: pj@sgi.com
Cc: magnus.damm@gmail.com, kurosawa@valinux.co.jp, dino@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using
 CPUSETS
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20050909063131.64dc8155.pj@sgi.com>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > What do you think if you make cpusets for sched domain be able to
> > have their siblings, which have the same attribute and share
> > their resources between them.
> 
> I do not understand this question.  I guess "cpusets for sched
> domains" means "cpusets whose 'cpu_exclusive' attribute is
> marked true, but which have no child cpusets so marked."

Yes.

> But even that guess I am unsure of, and the rest of the sentence
> "which have the same ..." I don't even have a guess what means.

Sorry for the poor explanation.
I just thought that it wouldn't be bad to allow "each cpuset whose
cpu_exclusive attribute is mark true" to have its clones like the
figure below. In this case, cpu-2 and cpu-3 will be used exclusively
for the clones --- CPUSET 1, 2, and 3 ---.

I guess it seems very similar to one of your ideas except for reusing
cpu_exclusive flag. Do you think reusing the flag is good idea?


     +-------------------+----------------+----------------+
     |                   |                |                |
  CPUSET 0            CPUSET 1         CPUSET 2         CPUSET 3
  sched domain A      sched domain B   sched domain B   sched domain B
  cpus: 0, 1          cpus: 2, 3       cpus: 2, 3       cpus: 2, 3
  cpu_exclusive       cpu_exclusive    cpu_exclusive    cpu_exclusive 
                      meter_cpu        meter_cpu        meter_cpu
                      <------should we call it resouce domain?------>


Thanks,
Hirokazu Takahashi.
