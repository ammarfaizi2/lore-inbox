Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292832AbSCDT4a>; Mon, 4 Mar 2002 14:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292805AbSCDT4V>; Mon, 4 Mar 2002 14:56:21 -0500
Received: from pc-80-195-34-57-ed.blueyonder.co.uk ([80.195.34.57]:32387 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S292820AbSCDT4G>; Mon, 4 Mar 2002 14:56:06 -0500
Date: Mon, 4 Mar 2002 19:55:37 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020304195537.I1444@redhat.com>
In-Reply-To: <sct@redhat.com> <200203041828.g24ISJo09358@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200203041828.g24ISJo09358@localhost.localdomain>; from James.Bottomley@steeleye.com on Mon, Mar 04, 2002 at 12:28:19PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 04, 2002 at 12:28:19PM -0600, James Bottomley wrote:
 
> There is one remaining curiosity I have, at least about the benchmarks: Since 
> the linux elevator and tag queueing perform essentially similar function 
> (except that the disk itself has a better notion of ordering because it knows 
> its own geometry).  Might we get better performance by reducing the number of 
> tags we allow the device to use, thus forcing the writes to remain longer in 
> the linux elevator?

Possibly, but my gut feeling says no and so do any benchmarks I've
seen regarding queue depths on adaptec controllers (not that I've seen
many).  For relatively-closeby IOs, the disk will always have a better
idea of how to optimise a number of IOs than the Linux elevator can
have, especially if we have multiple IOs spanning multiple heads
within a single cylinder.

--Stephen
