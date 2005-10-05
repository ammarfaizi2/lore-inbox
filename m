Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbVJEKCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbVJEKCj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 06:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbVJEKCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 06:02:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1808 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965091AbVJEKCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 06:02:38 -0400
Date: Wed, 5 Oct 2005 12:02:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Con Kolivas <kernel@kolivas.org>, Marc Perkel <marc@perkel.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: Making nice niser for system hogging programs
Message-ID: <20051005100229.GH3511@suse.de>
References: <433F4563.5060700@perkel.com> <200510021307.10372.kernel@kolivas.org> <1128461162.12346.2609.camel@stark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128461162.12346.2609.camel@stark>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04 2005, Matt Helsley wrote:
> On Sun, 2005-10-02 at 13:07 +1000, Con Kolivas wrote:
> > On Sun, 2 Oct 2005 12:26, Marc Perkel wrote:
> > > Just a thought -----
> > >
> > > Programs like cp -a /bigdir /backup and rsync usually bring the server
> > > to a crawl no matter how much "nice" you put on them. Is there any way
> > > to make "nice" smarter in that it limits io as well as processor usage?
> > > If cp and rsyne ran a little slower IO wise then everything else could
> > > run too.
> > 
> > The latest cfq io scheduler supports io nice levels. By default it links the 
> > io nice levels to the cpu nice levels so if you use cfq and set your file 
> > commands nice 19 they will use as little io priority as possible. Note this 
> > only works on the read side but that makes a dramatic difference already.
> > 
> > Cheers
> > Con
> 
> 	If you want a way to assign io priorities without relying on process
> inheritance and (re)nice you might find CKRM, with it's cfq-based IO
> controller, useful.
> 
> 	Basically you create a set of classes that group tasks and give an
> appropriate share of IO performance to tasks in that class. As processes
> get created CKRM will assign tasks to the IO classes based on a set of
> rules. You can run commands like:
> 
> mkdir /rcfs/taskclass/makin_copies
> echo 'res=io,guarantee=20' > /rcfs/taskclass/makin_copies/shares
> echo 'path=/usr/bin/rsync,class=makin_copies' > /rcfs/ce/rsync_rule
> echo 'path=/bin/cp,class=makin_copies' > /rcfs/ce/cp_rule
> 
> to set this up. This should make CKRM useful for those unwilling to
> become full-time administrators just to run their own desktops.

Has the CKRM io controller been updated to 2.6.13 level CFQ, or is it
still using the very basic per-request based io sharing?

-- 
Jens Axboe

