Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWCJQ73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWCJQ73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbWCJQ73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:59:29 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:57066 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751629AbWCJQ72
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:59:28 -0500
Subject: Re: [RFC PATCH] ext3 writepage() journal avoidance
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Dave Jones <davej@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       sct@redhat.com, jack@suse.cz,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>
In-Reply-To: <20060310165157.GD18755@redhat.com>
References: <1141929562.21442.4.camel@dyn9047017100.beaverton.ibm.com>
	 <20060309152254.743f4b52.akpm@osdl.org>
	 <1141977557.2876.20.camel@laptopd505.fenrus.org>
	 <20060310002337.489265a3.akpm@osdl.org>
	 <1141980238.2876.27.camel@laptopd505.fenrus.org>
	 <20060310161940.GA18755@redhat.com>
	 <1142008847.21442.17.camel@dyn9047017100.beaverton.ibm.com>
	 <20060310165157.GD18755@redhat.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 09:00:56 -0800
Message-Id: <1142010061.21442.26.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 11:51 -0500, Dave Jones wrote:
> On Fri, Mar 10, 2006 at 08:40:47AM -0800, Badari Pulavarty wrote:
> 
>  > >  > > I don't know how much usage it's had, sorry.  It's only allowed in
>  > >  > > data=writeback mode and not many people seem to use even that.
>  > >  > 
>  > >  > would you be prepared to turn it on by default in -mm for a bit to see
>  > >  > how it holds up? The concept seems valuable in itself, so much so that I
>  > >  > feel this should be 1) on always by default when possible and 2) isn't
>  > >  > really the kind of thing that should be a long term option; not having
>  > >  > it almost is a -o pleaseAddThisBug option for each bug fixed.
>  > > 
>  > > It'd be good to get that hammered on, as it doesn't see hardly any testing
>  > > based upon the experiments I did sometime last year.  It left me with
>  > > an unmountable root filesystem :-/
>  > 
>  > Yuck. You are talking about "nobh" option for writeback mode, correct ?
>  > Have any idea on what you were doing ?
> 
> Actually, I think I may have neglected to make those mounts writeback.
> In retrospect, it was silly, I basically forced nobh on for all mounts.
> A few boots later my / reached its maximum mount count, and got a fsck,
> which moved a bunch of useful things like /lib/ld-linux.so.2 to lost+found.
> There was so much mess that it was easier to reinstall the box than
> to pick through it. (Thankfully I tested it on a scratch box ;-)

Well, This makes me feel better. I am not going to take full
responsibility for this. :)

You can't force NOBH on all mounts. It gets silently ignored (there is
a message in dmesg) on anything other than "writeback" mode and pagesize
== blocksize.

Something else is going wrong here.

Thanks,
Badari

