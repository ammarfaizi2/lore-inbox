Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVHYPHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVHYPHk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVHYPHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:07:40 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:23101 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751104AbVHYPHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:07:39 -0400
From: Ian Campbell <ijc@hellion.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cifs-client@lists.samba.org,
       Asser =?ISO-8859-1?Q?Fem=F8?= <asser@diku.dk>
In-Reply-To: <20050825145750.GA6658@mail.shareable.org>
References: <20050823130023.GB8305@diku.dk>
	 <20050823152331.GA10486@mail.shareable.org>
	 <1124973618.17190.9.camel@icampbell-debian>
	 <20050825145750.GA6658@mail.shareable.org>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 16:07:25 +0100
Message-Id: <1124982445.17190.44.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.3.3
X-SA-Exim-Mail-From: ijc@hellion.org.uk
Subject: Re: dnotify/inotify and vfs questions
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 15:57 +0100, Jamie Lokier wrote:
> Ian Campbell wrote:
> > On Tue, 2005-08-23 at 16:23 +0100, Jamie Lokier wrote:
> > >     <receive some request>...
> > >     if (any_dnotify_or_inotify_events_pending) {
> > >         read_dnotify_or_inotify_events();
> > >         if (any_events_related_to(file)) {
> > >             store_in_userspace_stat_cache(file, stat(file));
> > >         }
> > >     }
> > >     stat_info = lookup_userspace_stat_cache(file);
> > > 
> > > Now that's a silly way to save one system call in the fast path by itself.
> > 
> > I'm not that familiar with inotify internals but doesn't
> > read_dnotify_or_inotify_events() or
> > any_dnotify_or_inotify_events_pending() involve a syscall?
> 
> The fast path is just any_dnotify_or_inotify_events_pending: there
> aren't any relevant events pending in the fast path.
[snip]
> As I explained in the previous mail, all this is absolutely pointless
> to save one system call.  It's a lot of work for negligable gain.
> 
> The point is when it saves lots of calls and userspace logic together,
> for things like web page templates and compiled programs, which depend
> on many files which can be revalidated in a small number of operations.

Thanks for the explaination.

Ian.
-- 
Ian Campbell
Current Noise: Iron Maiden - Prodigal Son

Fay: The British police force used to be run by men of integrity.
Truscott: That is a mistake which has been rectified.
		-- Joe Orton, "Loot"

