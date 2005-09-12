Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbVILAWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVILAWN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 20:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVILAWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 20:22:13 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:6293 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751105AbVILAWM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 20:22:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wtr8GlkjiZXaRntA2SY583RWZIZTSC1b45nthITsXdAoEG6tTkEy1e4nn2CZZKj6eCy3aXDj/Qm8W1oTnSQeCznGELxGS+v9Tifhkei+n8w5lWKQCZ5pcbh+KGL09onCHIgqky1okNj6wxAc/jTPgAsiJFIdepNDmE9mnRx43kk=
Message-ID: <9a87484905091117222d318f4@mail.gmail.com>
Date: Mon, 12 Sep 2005 02:22:08 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: read-from-all-disks support for RAID1?
Cc: Lennert Buytenhek <buytenh@wantstofly.org>, linux-kernel@vger.kernel.org
In-Reply-To: <17188.49961.268818.355923@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050910123902.GA9461@xi.wantstofly.org>
	 <17188.49961.268818.355923@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/05, Neil Brown <neilb@cse.unsw.edu.au> wrote:
> On Saturday September 10, buytenh@wantstofly.org wrote:
> > (please CC on replies)
> >
> > Hi!
> >
> > I recently had a case where one disk in a two-disk RAID1 array went
> > subtly bad, effectively refusing to write to certain sectors without
> > reporting an error.  Basically, parts of the disk went undetectably
> > read-only, causing file system corruption that wouldn't go away after
> > fsck, and all kinds of other fun.
> 
> That really isn't something that a drive should do.  If a write fails,
> you need to be told that it failed.  If anything else happens, maybe
> you should consider boycotting that manufacturer, or at least buying
> more expensive drives (do I guess right that there were fairly
> cheap??).
> 
> 
> >
> > Would it be hard/wise to add an option for RAID1 mode to read from all
> > devices on a read, and report an error to syslog or simply return an
> > I/O error if there is a mismatch?  (Or use majority voting and tell
> > people to use 3-disk RAID1 arrays from now on ;-)
> >
> 
> No, I don't think so.  The overhead would be substantial, so people
> would be very unlikely to use it.

There are situations where data integrity is far more important than speed.
On AIX I usually use the Mirror Write Consistency and Write Verify
options on my mirrored volumes that store data where integrity is more
important than speed.
I guess something like those options would also satisfy Lennert's
needs, but I don't know if it's currently possible with the Linux LVM
or elsewhere.

You can read a bit about the MWC and WV options in AIX at :
http://publib.boulder.ibm.com/infocenter/pseries/index.jsp?topic=/com.ibm.aix.doc/aixbman/prftungd/diskperf2.htm


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
