Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVIDWSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVIDWSt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 18:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVIDWSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 18:18:48 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:4995 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S932096AbVIDWSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 18:18:47 -0400
Date: Sun, 4 Sep 2005 15:18:20 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Teigland <teigland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050904221820.GB8684@ca-server1.us.oracle.com>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	David Teigland <teigland@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cluster@redhat.com
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain> <20050901132104.2d643ccd.akpm@osdl.org> <20050903051841.GA13211@redhat.com> <20050904203344.GA1987@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904203344.GA1987@elf.ucw.cz>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 10:33:44PM +0200, Pavel Machek wrote:
> > - read-only mount
> > - "specatator" mount (like ro but no journal allocated for the mount,
> >   no fencing needed for failed node that was mounted as specatator)
> 
> I'd call it "real-read-only", and yes, that's very usefull
> mount. Could we get it for ext3, too?

	In OCFS2 we call readonly+journal+connected-to-cluster "soft
readonly".  We're a live node, other nodes know we exist, and we can
flush pending transactions during the rw->ro transition.  In addition,
we can allow a ro->rw transition.
	The no-journal+no-cluster-connection mode we call "hard
readonly".  This is the mode you get when a device itself is readonly,
because you can't do *anything*.

Joel

-- 

"Lately I've been talking in my sleep.
 Can't imagine what I'd have to say.
 Except my world will be right
 When love comes back my way."

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
