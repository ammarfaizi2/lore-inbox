Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUIFHGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUIFHGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 03:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267491AbUIFHGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 03:06:36 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:12048 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S267396AbUIFHGb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 03:06:31 -0400
Message-ID: <20040906110628.A31962@castle.nmd.msu.ru>
Date: Mon, 6 Sep 2004 11:06:28 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q about pagecache data never written to disk
References: <20040905120147.A9202@castle.nmd.msu.ru> <20040905035233.6a6b5823.akpm@osdl.org> <20040905154336.B9202@castle.nmd.msu.ru> <20040905140040.58a5fcdc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20040905140040.58a5fcdc.akpm@osdl.org>; from "Andrew Morton" on Sun, Sep 05, 2004 at 02:00:40PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2004 at 02:00:40PM -0700, Andrew Morton wrote:
> Andrey Savochkin <saw@saw.sw.com.sg> wrote:
> > On Sun, Sep 05, 2004 at 03:52:33AM -0700, Andrew Morton wrote:
> > > That would be a retrograde step - it would be nice to move in the other
> > > direction: perform disk allocation at writeback time rather than at write()
> > > time, even for regular write() data.  To do that we (probably) need space
> > > reservation APIs.  And yes, we perhaps could reserve space in the
> > > filesystem when that page is first written to.
> > > 
> > > But then what would we do if there's no space?  SIGBUS?  SIGSEGV? 
> > > Inappropriate.  SIGENOSPC?
> > 
> > Should the space be allocated on close()?
> 
> What effect are you trying to achieve?

Sending a signal while there is still a process...

> > Who will get the signal if nobody accesses the file anymore?
> 
> Nobody.  That's the point.  Plus there _is_ no signal defined for this. 
> Neither in Linux nor in POSIX.
> 
> > I'm also thinking about various shell scripts with redirects to files...
> 
> ?  I doubt that they're writing files via MAP_SHARED.

I was deliberating on your idea about delayed allocation for regular write()s
also...
