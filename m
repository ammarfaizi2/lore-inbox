Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWEBOlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWEBOlu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWEBOlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:41:50 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:39385 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S964855AbWEBOlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:41:49 -0400
Message-ID: <346580906.19175@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 2 May 2006 22:42:03 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       axboe@suse.de, nickpiggin@yahoo.com.au, pbadari@us.ibm.com,
       arjan@infradead.org
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060502144203.GA10594@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org, akpm@osdl.org, axboe@suse.de,
	nickpiggin@yahoo.com.au, pbadari@us.ibm.com, arjan@infradead.org
References: <346556235.24875@ustc.edu.cn> <20060502144641.62df9c18.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060502144641.62df9c18.diegocg@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego,

On Tue, May 02, 2006 at 02:46:41PM +0200, Diego Calleja wrote:
> El Tue, 2 May 2006 15:50:49 +0800,
> Wu Fengguang <wfg@mail.ustc.edu.cn> escribió:
> 
> > 	2) kernel module to query the file cache
> 
> Can't mincore() + /proc/$PID/* stuff be used to replace that ?

Nope. mincore() only provides info about files that are currently
opened, by the process itself. The majority in the file cache are
closed files.

> Improving boot time is nice and querying the file cache would work
> for that, but improving the boot time of some programs once the system
> is running (ie: running openoffice 6 hours after booting) is something
> that other preloaders do in other OSes aswell, querying the full file
> cache wouldn't be that useful for such cases.

Yes, it can still be useful after booting :) One can get the cache
footprint of any task started at any time by taking snapshots of the
cache before and after the task, and do a set-subtract on them.

> The main reason why I believe that the pure userspace (preload.sf.net)
> solution slows down in some cases is becauses it uses bayesian heuristics
> (!) as a magic ball to guess the future, which is a flawed idea IMHO.
> I started (but didn't finish) a preloader which uses the process event
> connector to get notifications of what processes are being launched,
> then it profiles it (using mincore(), /proc/$PID/* stuff, etc) and
> preloads things optimally the next time it gets a notification of the
> same app.

My thought is that any prefetcher that ignores the thousands of small
data files is incomplete. Only kernel can provide that info.

> Mac OS X has a program that implements your idea, available (the sources)
> at http://darwinsource.opendarwin.org/projects/apsl/BootCache-25/

Ah, thanks for mentioning it.

It seems to do the job mostly in kernel, comprising of 2400+ LOC.
Whereas my plan is to write a module of ~300 LOC to _only_ provide the
necessary info, and leave other jobs to smart user-land tools.

Wu
