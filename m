Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261641AbSI0GI0>; Fri, 27 Sep 2002 02:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261639AbSI0GI0>; Fri, 27 Sep 2002 02:08:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61160 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261636AbSI0GIZ>;
	Fri, 27 Sep 2002 02:08:25 -0400
Date: Fri, 27 Sep 2002 08:13:28 +0200
From: Jens Axboe <axboe@suse.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file transfers
Message-ID: <20020927061328.GL5646@suse.de>
References: <20020925232736.A19209@shookay.newview.com> <20020926061419.GA12862@suse.de> <3D92B17C.9030504@myrealbox.com> <3870780000.1033054272@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3870780000.1033054272@aslan.scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26 2002, Justin T. Gibbs wrote:
> >     I reported this same problem some weeks ago -
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103069116227685&w=2 .
> > 2.4.20pre kernels solved the error messages flooding the console, and
> > improved things a bit, but system load still got very high and disk read
> > and write performance was lousy. Adding more memory and using a
> > completely different machine didn't help. What did? Changing the Adaptec
> > scsi driver to aic7xxx_old . The performance was up 50% for writes and
> > 90% for reads, and the system load was acceptable. And i didn't even had
> > to change the RedHat kernel (2.4.18-10) for a custom one. The storage was
> > two external Arena raid boxes, btw.
> 
> I would be interested in knowing if reducing the maximum tag depth for
> the driver improves things for you.  There is a large difference in the
> defaults between the two drivers.  It has only reacently come to my
> attention that the SCSI layer per-transaction overhead is so high that
> you can completely starve the kernel of resources if this setting is too
> high.  For example, a 4GB system installing RedHat 7.3 could not even
> complete an install on a 20 drive system with the default of 253 commands.
> The latest version of the aic7xxx driver already sent to Marcelo drops the
> default to 32.

2.4 layer is most horrible there, 2.5 at least gets rid of the old
scsi_dma crap. That said, 253 default depth is a bit over the top, no?

-- 
Jens Axboe, who always uses 4

