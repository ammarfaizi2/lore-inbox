Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273516AbRIYWQr>; Tue, 25 Sep 2001 18:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273545AbRIYWQh>; Tue, 25 Sep 2001 18:16:37 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:33995 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S273516AbRIYWQR>; Tue, 25 Sep 2001 18:16:17 -0400
Date: Tue, 25 Sep 2001 18:16:43 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: marcelo@conectiva.com.br, andrea@suse.de, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
Message-ID: <20010925181643.D19494@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0109251601360.2193-100000@freak.distro.conectiva> <20010925.132905.32720330.davem@redhat.com> <20010925170055.B19494@redhat.com> <20010925.145547.90825509.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010925.145547.90825509.davem@redhat.com>; from davem@redhat.com on Tue, Sep 25, 2001 at 02:55:47PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 02:55:47PM -0700, David S. Miller wrote:
> I'm willing to investigate using RCU.  However, per hashchain locking
> is a much proven technique (inside the networking in particular) which
> is why that was the method employed.  At the time the patch was
> implemented, the RCU stuff was not fully formulated.

*nod*

> Please note that the problem is lock cachelines in dirty exclusive
> state, not a "lock held for long time" issue.

Ahh, that's a cpu bug -- one my athlons don't suffer from.

> I agree.  But to my understanding, and after having studied the
> pagecache lock usage, it was minimally used and not used in any places
> unnecessarily as per the io_request_lock example you are stating.
> 
> In fact, the pagecache_lock is mostly held for extremely short periods
> of time.

True, and that is why I would like to see more of the research that 
justifies these changes, as well as comparisons with alternate techniques 
before any of these patches make it into the base tree.  Even before that, 
we need to clean up the code first.

		-ben
