Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273515AbRIUNKv>; Fri, 21 Sep 2001 09:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273519AbRIUNKk>; Fri, 21 Sep 2001 09:10:40 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:40947 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S273515AbRIUNKf>; Fri, 21 Sep 2001 09:10:35 -0400
Date: Fri, 21 Sep 2001 14:10:50 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Define conflict between ext3 and raid patches against 2.2.19
Message-ID: <20010921141050.A1946@redhat.com>
In-Reply-To: <20010916155835.C24067@mikef-linux.matchmail.com> <15271.11056.810538.66237@notabene.cse.unsw.edu.au> <20010919133811.B22773@mikef-linux.matchmail.com> <15273.7576.395258.345452@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15273.7576.395258.345452@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Thu, Sep 20, 2001 at 08:35:04AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 20, 2001 at 08:35:04AM +1000, Neil Brown wrote:

> However when a RAID rebuild happens, every block on the array is read
> into the buffer cache (if it isn't already there) and then written
> back out again.  This defeats the control that ext3 tries to maintain
> on the buffer cache.
> 
> I don't know exactly what large-scale effects this might have.  It
> could be simply that a crash at the wrong time could leave the
> filesystem corrupted.

Immediately after a crash, the fs will be OK.  But during the
subsequent background raid reconstruction, it can get out of sync
again.  This can result in silent data loss in some cases, but it is
also likely to trigger some internal ext3 debugging which detects
out-of-order data writes, resulting in a kernel panic.

Cheers,
 Stephen
