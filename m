Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVKTXmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVKTXmq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVKTXmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:42:45 -0500
Received: from mailgate.Cadence.COM ([158.140.2.1]:60036 "EHLO
	mailgate.Cadence.COM") by vger.kernel.org with ESMTP
	id S932133AbVKTXmo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:42:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: unable to use dpkg 2.6.15-rc2
Date: Sun, 20 Nov 2005 15:41:00 -0800
Message-ID: <D11CB0F7920F2641B06153812BB47BD704E2BE@MAILSJ1.global.cadence.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: unable to use dpkg 2.6.15-rc2
Thread-Index: AcXuJ3tGL9uiDxdgQ0K+49GkHFiR2gABGHG5
References: <20051120075233.GA20295@the-penguin.otak.com> <20051121100820.D6790390@wobbly.melbourne.sgi.com>
From: "Chris Croswhite" <csc@cadence.com>
To: "Nathan Scott" <nathans@sgi.com>,
       "Lawrence Walton" <lawrence@the-penguin.otak.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, <linux-xfs@oss.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just another data point, running 2615rc1/2 I do not have an issue with XFS runing on MPT scsi device.


-----Original Message-----
From: linux-xfs-bounce@oss.sgi.com on behalf of Nathan Scott
Sent: Sun 20-Nov-05 15:08
To: Lawrence Walton
Cc: linux-kernel; linux-xfs@oss.sgi.com
Subject: Re: unable to use dpkg 2.6.15-rc2
 
Hi there,

On Sat, Nov 19, 2005 at 11:52:33PM -0800, Lawrence Walton wrote:
> Hi!
> 
> This is the second report of this error.

Please CC linux-xfs if you want to be sure XFS people see your
report.

> It's reproducible in 2.6.15-rc1, 2.6.15-rc1-mm1, 2.6.15-rc1-mm2 and
> 2.6.15-rc2.
> 
> It does not occur in 2.6.14.
> 
> Most easily triggered by "make clean" in the Linux source, for those of
> you without access to dpkg. But both clean and dpkg will trigger it.

So far I've not been able to reproduce this; I'm using "make clean"
and it works just fine for me (I'm using the current git tree).

> There are no oops.

No, it looks like XFS is stuck waiting for an IO to complete.

> I'm not sure what to report next, though If I were to guess it is a
> interaction between XFS file system and SCSI. I've got another SCSI box
> that is very similar that runs rc1, rc1-mm1 and rc1-mm2 just fine, the
> only real difference being it has a ext3 file system instead.
> 
> The driver for the SCSI card (aic7xxx) did not appear change. 
> lspi says it's a Adaptec AIC-7892A U160/m (rev 2) card.

>From your earlier report with the stack traces included, it looks
like XFS is waiting for a log write to complete, but it never
does (which is not valid driver behaviour).  I'm using the sym53c8xx
driver in my testing BTW, which is different to you, so maybe see if
this still happens for you with different hardware?  (if you can).

> Questions, patches, flames are welcome.

You could also try to drop the XFS (fs/xfs) code from 2.6.14 into
2.6.15-rc2 and see if your problem persists.  There isn't anything
I can see from scanning though everything we committed into .15 so
far that would explain this.  Oh, an easier test you could do would
be to try XFS CVS from oss.sgi.com - that has 2.6.14 + all the XFS
changes since then, so that should confirm/deny an XFS regression
too.  Thanks!

cheers.

-- 
Nathan



