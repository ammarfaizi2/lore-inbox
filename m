Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbTEGUBN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 16:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTEGUBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 16:01:13 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:19156 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S264276AbTEGUBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 16:01:11 -0400
Date: Tue, 6 May 2003 12:41:14 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, "David S. Miller" <davem@redhat.com>,
       rusty@rustcorp.com.au, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-ID: <20030506124114.S626@nightmaster.csn.tu-chemnitz.de>
References: <20030505.211606.28803580.davem@redhat.com> <20030505224815.07e5240c.akpm@digeo.com> <20030505234248.7cc05f43.akpm@digeo.com> <20030505.223944.23027730.davem@redhat.com> <20030505235758.25f769fc.akpm@digeo.com> <20030506072500.GS812@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030506072500.GS812@suse.de>; from axboe@suse.de on Tue, May 06, 2003 at 09:25:00AM +0200
X-Spam-Score: -32.5 (--------------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19DVIP-0002Nh-00*7QdpPdqQVok*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 09:25:00AM +0200, Jens Axboe wrote:
> On Mon, May 05 2003, Andrew Morton wrote:
> > "David S. Miller" <davem@redhat.com> wrote:
> > The disk_stats structure has an "in flight" member.  If we don't have proper
> > locking around that, disks will appear to have -3 requests in flight for all
> > time, which would look a tad odd.
> 
> So check for < 0 in flight? I totally agree with davem here.

If the disk_stats structure will never be accurate, it will show
nonsense values. If it shows nonsense values, the values have no
meaning anymore and we could remove them alltogether.

If some additions/subtractions will come in later it will not
matter, but if the value we add to or subtract from is already
wrong, then the error will really propagate to much.

Has somebody analyzed this? Can we tell userspace a maximum error
value? Is the maximum error value acceptable?

Is the above questions are all answered with "no", then I (and
several sysadmins) would prefer to just rip the stats or make
them a compile time option and be exact, if we really want them.

What about that?

Most people just want them per system to measure their
IO bandwidth and they want the spots (=per disk stats), just
to analyze the problematic cases.

For the real performance, they could always compile out the per
disk stats, once they are satisfied with the overall bandwidth.

Regards

Ingo Oeser
