Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292803AbSCDTwk>; Mon, 4 Mar 2002 14:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292805AbSCDTwV>; Mon, 4 Mar 2002 14:52:21 -0500
Received: from dsl-213-023-043-195.arcor-ip.net ([213.23.43.195]:32919 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292803AbSCDTwT>;
	Mon, 4 Mar 2002 14:52:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Date: Mon, 4 Mar 2002 20:48:02 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        James Bottomley <James.Bottomley@steeleye.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <phillips@bonn-fries.net> <1201480000.1015262195@tiny> <20020304180537.F1444@redhat.com>
In-Reply-To: <20020304180537.F1444@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hyRG-0000fO-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 4, 2002 07:05 pm, Stephen C. Tweedie wrote:
> Hi,
> 
> On Mon, Mar 04, 2002 at 12:16:35PM -0500, Chris Mason wrote:
>  
> > writeback data order is important, mostly because of where the data blocks
> > are in relation to the log.  If you've got bdflush unloading data blocks
> > to the disk, and another process doing a commit, the drive's queue
> > might look like this:
> > 
> > data1, data2, data3, commit1, data4, data5 etc.
> > 
> > If commit1 is an ordered tag, the drive is required to flush 
> > data1, data2 and data3, then write the commit, then seek back
> > for data4 and data5.
> 
> Yes, but that's a performance issue, not a correctness one.
> 
> Also, as soon as we have journals on external devices, this whole
> thing changes entirely.  We still have to enforce the commit ordering
> in the journal, but we also still need the ordering between that
> commit and any subsequent writeback, and that obviousy can no longer
> be achieved via ordered tags if the two writes are happening on
> different devices.

But the bio layer can manage it, by sending a write barrier down all relevant 
queues.  We can send a zero length write barrier command, yes?

-- 
Daniel
