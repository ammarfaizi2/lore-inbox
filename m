Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273569AbRIYVAy>; Tue, 25 Sep 2001 17:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273577AbRIYVAe>; Tue, 25 Sep 2001 17:00:34 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:32424 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S273569AbRIYVAa>; Tue, 25 Sep 2001 17:00:30 -0400
Date: Tue, 25 Sep 2001 17:00:55 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: marcelo@conectiva.com.br, andrea@suse.de, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
Message-ID: <20010925170055.B19494@redhat.com>
In-Reply-To: <20010925.131528.78383994.davem@redhat.com> <Pine.LNX.4.21.0109251601360.2193-100000@freak.distro.conectiva> <20010925.132905.32720330.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010925.132905.32720330.davem@redhat.com>; from davem@redhat.com on Tue, Sep 25, 2001 at 01:29:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 01:29:05PM -0700, David S. Miller wrote:
> Well, there are two things happing in that patch.  Per-hash chain
> locks for the page cache itself, and the lock added to the address
> space for that page list.

Last time I looked, those patches made the already ugly vm locking 
even worse.  I'd rather try to use some of the rcu techniques for 
page cache lookup, and per-page locking for page cache removal 
which will lead to *cleaner* code as well as a much more scalable 
kernel.

Keep in mind that just because a lock is on someone's hitlist doesn't 
mean that it is for the right reasons.  Look at the io_request_lock 
that is held around the bounce buffer copies in the scsi midlayer.  
*shudder*

		-ben
