Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130582AbRCLSwf>; Mon, 12 Mar 2001 13:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130581AbRCLSwZ>; Mon, 12 Mar 2001 13:52:25 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:55556
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130565AbRCLSwM>; Mon, 12 Mar 2001 13:52:12 -0500
Date: Mon, 12 Mar 2001 10:50:42 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <20010307134824.A3715@redhat.com>
Message-ID: <Pine.LNX.4.10.10103121041410.2632-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Stephen C. Tweedie wrote:

> Hi,
> 
> On Tue, Mar 06, 2001 at 10:44:34AM -0800, Linus Torvalds wrote:
> 
> > On Tue, 6 Mar 2001, Alan Cox wrote:
> > > You want a write barrier. Write buffering (at least for short intervals) in
> > > the drive is very sensible. The kernel needs to able to send drivers a write
> > > barrier which will not be completed with outstanding commands before the
> > > barrier.
> > 
> > But Alan is right - we needs a "sync" command or something. I don't know
> > if IDE has one (it already might, for all I know).
> 
> Sync and barrier are very different models.  With barriers we can
> enforce some elemnt of write ordering without actually waiting for the
> IOs to complete; with sync, we're explicitly asking to be told when
> the data has become persistant.  We can make use of both of these.
> 
> SCSI certainly lets us do both of these operations independently.  IDE
> has the sync/flush command afaik, but I'm not sure whether the IDE
> tagged command stuff has the equivalent of SCSI's ordered tag bits.
> Andre?

ATA-TCQ suxs to put is plain and simple.  It really requires a special
host and only the HPT366 series works.  It is similar but not clear as to
the nature.  We are debating the usage of it now in T13.

Cheers,

Andre Hedrick
Linux ATA Development

