Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285328AbRLGASJ>; Thu, 6 Dec 2001 19:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285329AbRLGASA>; Thu, 6 Dec 2001 19:18:00 -0500
Received: from bitmover.com ([192.132.92.2]:43654 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S285328AbRLGARp>;
	Thu, 6 Dec 2001 19:17:45 -0500
Date: Thu, 6 Dec 2001 16:17:44 -0800
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: lm@bitmover.com, alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net,
        davidel@xmailserver.org, rusty@rustcorp.com.au,
        Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011206161744.V27589@work.bitmover.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, lm@bitmover.com,
	alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net,
	davidel@xmailserver.org, rusty@rustcorp.com.au,
	Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
	lars.spam@nocrew.org, hps@intermeta.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011206151504.R27589@work.bitmover.com> <20011206.151945.57439059.davem@redhat.com> <20011206153257.T27589@work.bitmover.com> <20011206.154735.71088809.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011206.154735.71088809.davem@redhat.com>; from davem@redhat.com on Thu, Dec 06, 2001 at 03:47:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 03:47:35PM -0800, David S. Miller wrote:
>    From: Larry McVoy <lm@bitmover.com>
>    Date: Thu, 6 Dec 2001 15:32:57 -0800
>    
>    And, the ccCluster approach moves most of the nasty locking
>    problems into a ccCluster specific filesystem rather than buggering
>    up the generic paths.
> 
> I still don't believe this, you are still going to need a lot of
> generic VFS threading.  This is why myself and others keep talking
> about ftruncate(), namei() et al.
> 
> If I look up "/etc" on bigfoot, littletoe, or whatever fancy name you
> want to call the filesystem setup, SOMETHING has to control access to
> the path name components (ie. there has to be locking).

Sure, but you are assuming one file system, which is global.  That's
certainly one way to do it, but not the only way, and not the way that
I've suggested.  I'm not sure if you remember this, but I always advocated
partially shared and partially private.  /, for example, is private.
In fact, so is /proc, /tmp, and /dev.  There are /gproc, /gtmp, and /gdev
which are in the global namespace and do for the cluster what /<xxx>
does for a regular machine.

We can go around and around on this and the end result will be that I will
have narrowed the locking problem down to the point that only the processes
which are actually using the resource have to participate in the locking.
In a traditional SMP OS, all processes have to participate.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
