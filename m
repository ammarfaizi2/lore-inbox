Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262230AbTCHVmI>; Sat, 8 Mar 2003 16:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbTCHVmI>; Sat, 8 Mar 2003 16:42:08 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:58637 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262230AbTCHVmG>; Sat, 8 Mar 2003 16:42:06 -0500
Date: Sat, 8 Mar 2003 21:52:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Greg KH <greg@kroah.com>, Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
       akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308215239.A782@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joel Becker <Joel.Becker@oracle.com>, Greg KH <greg@kroah.com>,
	Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, akpm@digeo.com,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <UTC200303080057.h280v0o28591.aeb@smtp.cwi.nl> <20030308005333.GF23071@kroah.com> <20030308073407.A24272@infradead.org> <20030308192908.GB26374@kroah.com> <20030308194331.A31291@infradead.org> <20030308214130.GK2835@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030308214130.GK2835@ca-server1.us.oracle.com>; from Joel.Becker@oracle.com on Sat, Mar 08, 2003 at 01:41:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 01:41:30PM -0800, Joel Becker wrote:
> On Sat, Mar 08, 2003 at 07:43:31PM +0000, Christoph Hellwig wrote:
> > So people should have started working on it sooner.  If people really think
> > they need a 32bit dev_t for their $BIGNUM of disks (and I still don't buy
> > that argument) we should just introduce it and use it only for block devices
> > (which already are fixed up for this) and stay with the old 8+8 split for
> > character devices.  Note that Linux is about doing stuff right, not fast.
> 
> 	Wait, so ugly hacks that steal every remaining major

What hack to steal every remaining major?  Remember that Linus already said
that there won't be new static majors anyway.

> I've done the math with the current available majors.  I don't
> see 4000 disks there, and that is just life as it exists today,

were do you get this 4000 disks number from?  Every big system in practice
is attached to some EMC/LSI/IBM/whatever array anyway that virtualizes
away the actual disk.

Calculating with 120 left block major alone (and ignoring the fact that
most of the officially registered space is now free aswell with the new
major/minor less block device registration) this would be about 1900 disks.

Given that no shipping Linux version supports more than 256 (scsi) disks
this is enough for sensible seyups for a few years.

> years from now when 2.8 finally appears.  Like Andrew asked, please
> describe exactly how you'd support it.

I did repson to Andrew, go and read it - and play with the code a bit.

