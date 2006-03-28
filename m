Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWC1SBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWC1SBu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 13:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWC1SBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 13:01:50 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:48820 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751200AbWC1SBt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 13:01:49 -0500
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       Takashi Sato <sho@tnes.nec.co.jp>,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <1143530126.11560.6.camel@openx2.frec.bull.fr>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
Content-Type: text/plain; charset=utf-8
Organization: IBM LTC
Date: Tue, 28 Mar 2006 10:01:45 -0800
Message-Id: <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 09:15 +0200, Laurent Vivier wrote:
> Le mar 28/03/2006 à 00:58, Ravikiran G Thirumalai a écrit :
> > On Mon, Mar 27, 2006 at 01:10:49PM -0800, Andrew Morton wrote:
> > > Mingming Cao <cmm@us.ibm.com> wrote:
> > > >
> > > > I am wondering if we have (or plan to have) "long long " type of percpu
> > > >  counters?  Andrew, Kiran, do you know?  
> > > > 
> > > >  It seems right now the percpu counters are used mostly by ext2/3 for
> > > >  filesystem free blocks accounting. Right now the counter is "long" type,
> > > >  which is not enough if we want to extend the filesystem limit from 2**31
> > > >  to 2**32 on 32 bit machine.
> > > > 
> > > >  The patch from Takashi copies the whole percpu_count.h  and create a new
> > > >  percpu_llcounter.h to support longlong type percpu counters. I am
> > > >  wondering is there any better way for this?
> > > > 
> > > 
> > > I can't immediately think of anything smarter.
> > > 
> > > One could of course implement a 64-bit percpu counter by simply
> > > concatenating two 32-bit counters.  That would be a little less efficient,
> > > but would introduce less source code and would mean that we don't need to
> > > keep two different implemetations in sync.  But one would need to do a bit
> > > of implementation, see how bad it looks.
> > 
> > Since long long is 64 bits on both 32bit and 64 bit arches, we can just
> > change percpu_counter type to long long (or s64) and just have one
> > implementation of percpu_counter?  
> > But reads and writes on 64 bit counters may not be atomic on all 32 bit arches.
> > So the implementation might have to be reviewed for that.
> 
> As 64bit per cpu counter is used only by ext3 and needed only on 64bit
> architecture and when CONFIG_LBD is set, perhaps we can have only one
> implementation, 32bit in the case of 32bit arch and 64bit in the case of
> 64bit arch + LBD, as I did in my 64bit patches for ext3 ?
> 

The current percpu counter on 32 bit machine is "long", a signed value.
It's a problem for ext3 on 32 bit arch also, as the total number of free
blocks in ext3 is a type of u32. Isn't it? Did I miss something?


Mingming
> Cheers,
> Laurent

