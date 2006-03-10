Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751829AbWCJQo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbWCJQo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWCJQo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:44:27 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:38634 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751829AbWCJQo0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:44:26 -0500
Subject: Re: [RFC PATCH] ext3 writepage() journal avoidance
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Dave Jones <davej@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       sct@redhat.com, jack@suse.cz,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>
In-Reply-To: <20060310161940.GA18755@redhat.com>
References: <1141929562.21442.4.camel@dyn9047017100.beaverton.ibm.com>
	 <20060309152254.743f4b52.akpm@osdl.org>
	 <1141977557.2876.20.camel@laptopd505.fenrus.org>
	 <20060310002337.489265a3.akpm@osdl.org>
	 <1141980238.2876.27.camel@laptopd505.fenrus.org>
	 <20060310161940.GA18755@redhat.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 08:46:00 -0800
Message-Id: <1142009160.21442.21.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 11:19 -0500, Dave Jones wrote:
> On Fri, Mar 10, 2006 at 09:43:57AM +0100, Arjan van de Ven wrote:
>  > On Fri, 2006-03-10 at 00:23 -0800, Andrew Morton wrote:
>  > > Arjan van de Ven <arjan@infradead.org> wrote:
>  > > >
>  > > > 
>  > > > > I'm not sure that PageMappedToDisk() gets set in all the right places
>  > > > > though - it's mainly for the `nobh' handling and block_prepare_write()
>  > > > > would need to be taught to set it.  I guess that'd be a net win, even if
>  > > > > only ext3 uses it..
>  > > > 
>  > > > btw is nobh mature enough yet to become the default, or to just go away
>  > > > entirely as option ?
>  > > 
>  > > I don't know how much usage it's had, sorry.  It's only allowed in
>  > > data=writeback mode and not many people seem to use even that.
>  > 
>  > would you be prepared to turn it on by default in -mm for a bit to see
>  > how it holds up? The concept seems valuable in itself, so much so that I
>  > feel this should be 1) on always by default when possible and 2) isn't
>  > really the kind of thing that should be a long term option; not having
>  > it almost is a -o pleaseAddThisBug option for each bug fixed.
> 
> It'd be good to get that hammered on, as it doesn't see hardly any testing
> based upon the experiments I did sometime last year.  It left me with
> an unmountable root filesystem :-/

BTW, were you doing "chattr +j" on any of the files ? (writeback, nobh
mounted filesystems ?). If so, I can see my screw ups :(

Only yesterday, I came to know about this fancy thing. I need to take
a closer look. I can't really do NOBH for this case (which currently it
does).

Thanks,
Badari

