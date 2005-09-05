Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbVIEXde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbVIEXde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 19:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbVIEXde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 19:33:34 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:61348 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S964959AbVIEXdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 19:33:33 -0400
Date: Mon, 5 Sep 2005 16:32:36 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Daniel Phillips <phillips@istop.com>,
       linux-cluster@redhat.com, wim.coekaerts@oracle.com,
       linux-fsdevel@vger.kernel.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050905233236.GF8684@ca-server1.us.oracle.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrew Morton <akpm@osdl.org>, Daniel Phillips <phillips@istop.com>,
	linux-cluster@redhat.com, wim.coekaerts@oracle.com,
	linux-fsdevel@vger.kernel.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <20050903183241.1acca6c9.akpm@osdl.org> <20050904030640.GL8684@ca-server1.us.oracle.com> <200509040022.37102.phillips@istop.com> <20050903214653.1b8a8cb7.akpm@osdl.org> <1125823035.23858.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125823035.23858.10.camel@localhost.localdomain>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 09:37:15AM +0100, Alan Cox wrote:
> I am curious why a lock manager uses open to implement its locking
> semantics rather than using the locking API (POSIX locks etc) however.

	Because it is simple (how do you fcntl(2) from a shell fd?), has no
ranges (what do you do with ranges passed in to fcntl(2) and you don't
support them?), and has a well-known fork(2)/exec(2) pattern.  fcntl(2)
has a known but less intuitive fork(2) pattern.
	The real reason, though, is that we never considered fcntl(2).
We could never think of a case when a process wanted a lock fd open but
not locked.  At least, that's my recollection.  Mark might have more to
comment.

Joel

-- 

"In the room the women come and go
 Talking of Michaelangelo."

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

