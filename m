Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289385AbSAJKsA>; Thu, 10 Jan 2002 05:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289384AbSAJKru>; Thu, 10 Jan 2002 05:47:50 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:10553 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289382AbSAJKro>; Thu, 10 Jan 2002 05:47:44 -0500
Date: Thu, 10 Jan 2002 11:47:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
Message-ID: <20020110114704.I3357@inspiron.school.suse.de>
In-Reply-To: <20020109132148.C12609@redhat.com> <200201091928.g09JSdH23535@eng2.beaverton.ibm.com> <20020110111825.C3357@inspiron.school.suse.de> <20020110112225.S19814@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020110112225.S19814@suse.de>; from axboe@suse.de on Thu, Jan 10, 2002 at 11:22:25AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 11:22:25AM +0100, Jens Axboe wrote:
> On Thu, Jan 10 2002, Andrea Arcangeli wrote:
> > On Wed, Jan 09, 2002 at 11:28:39AM -0800, Badari Pulavarty wrote:
> > > Ben,
> > > 
> > > By any chance do you have a list of drivers that assume this ? 
> > > What does it take to fix them ? 
> > > 
> > > I think Jens BIO changes for 2.5 will fix this problem. But 
> > > 2.4 needs a solution in this area too. This patch showed 
> > > significant improvement for database workloads. 
> > 
> > I didn't checked the implementation but as far as the blkdev is
> > concerned the b_size changes without notification as soon as you 'mkfs
> > -b somethingelse' and then mount the fs. So it cannot break as far I can
> > tell. The only important thing is that b_size stays between 512 and 4k.
> 
> The concern is/was differently sized buffer_heads in the same request,
> ie b_size changing as you iterate through the chunks of one request.

ok, I don't expect problems there. It can happen for example if you
create a snapshot with 4k and then you switch back the original volume
to 1k. the physical volume will get mixed b_size colaesced into the same
request.

Andrea
