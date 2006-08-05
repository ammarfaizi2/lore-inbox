Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWHETrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWHETrg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 15:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWHETrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 15:47:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19600 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932170AbWHETrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 15:47:35 -0400
Date: Sat, 5 Aug 2006 15:47:30 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, michal.k.k.piotrowski@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Message-ID: <20060805194730.GG13393@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com> <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org> <20060804222400.GC18792@redhat.com> <20060805003142.GH18792@redhat.com> <20060805021051.GA13393@redhat.com> <20060805022356.GC13393@redhat.com> <20060805024947.GE13393@redhat.com> <20060805064727.GF13393@redhat.com> <20060805004600.2e63fcd9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060805004600.2e63fcd9.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 12:46:00AM -0700, Andrew Morton wrote:
 > @@ -320,10 +320,10 @@ void fastcall flush_workqueue(struct wor
 >  	} else {
 >  		int cpu;
 >  
 > -		lock_cpu_hotplug();
 > +		mutex_lock(&workqueue_mutex);
 >  		for_each_online_cpu(cpu)
 >  			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu));
 > -		unlock_cpu_hotplug();
 > +		mutex_unlock(&workqueue_mutex);
 >  	}
 >  }

Is this enough though? I mean, what stops the hotplug cpu code
from modifying cpu_online_map underneath us here, making for_each_online_cpu
do the wrong thing ?

		Dave

-- 
http://www.codemonkey.org.uk
