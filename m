Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWEBMr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWEBMr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 08:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWEBMr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 08:47:28 -0400
Received: from nproxy.gmail.com ([64.233.182.190]:22337 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964788AbWEBMr2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 08:47:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=LsMrwmvRSL7wZ/ic1F+9IB/HYyxeWiRc2j4lADSwyvfziiYXXs3z4wdlMqZbTsbiUsPe2P6DCQVKYT8btMSI/buJaL9ze6ArgBJiCpXl7qqB9zs6Spl0m/IFSWNOOnkKNTA6iOt152ZnFWHE3VIzqXfweAEJFblvNoHy3crQveA=
Date: Tue, 2 May 2006 14:46:41 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       axboe@suse.de, nickpiggin@yahoo.com.au, pbadari@us.ibm.com,
       arjan@infradead.org
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-Id: <20060502144641.62df9c18.diegocg@gmail.com>
In-Reply-To: <346556235.24875@ustc.edu.cn>
References: <346556235.24875@ustc.edu.cn>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.16; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 2 May 2006 15:50:49 +0800,
Wu Fengguang <wfg@mail.ustc.edu.cn> escribió:

> 	2) kernel module to query the file cache

Can't mincore() + /proc/$PID/* stuff be used to replace that ?
Improving boot time is nice and querying the file cache would work
for that, but improving the boot time of some programs once the system
is running (ie: running openoffice 6 hours after booting) is something
that other preloaders do in other OSes aswell, querying the full file
cache wouldn't be that useful for such cases.

The main reason why I believe that the pure userspace (preload.sf.net)
solution slows down in some cases is becauses it uses bayesian heuristics
(!) as a magic ball to guess the future, which is a flawed idea IMHO.
I started (but didn't finish) a preloader which uses the process event
connector to get notifications of what processes are being launched,
then it profiles it (using mincore(), /proc/$PID/* stuff, etc) and
preloads things optimally the next time it gets a notification of the
same app.

Mac OS X has a program that implements your idea, available (the sources)
at http://darwinsource.opendarwin.org/projects/apsl/BootCache-25/

Also, mac os x uses launchd, as init/init.d replacement
(http://darwinsource.opendarwin.org/projects/apsl/launchd-106/)
If (as Arjan noticed) the bootup is not really IO-bound, launchd could
help to reduce the amount of CPU time wasted if the CPU time being wasted
is in shell interpreters (a more unixy port has been done by the freebsd
people - http://wikitest.freebsd.org/moin.cgi/launchd)
