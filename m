Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVCBTIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVCBTIS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 14:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbVCBTIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 14:08:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14489 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262412AbVCBTIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:08:06 -0500
Date: Wed, 2 Mar 2005 11:34:41 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, "John L. Males" <jlmales@softhome.net>
Subject: Re: Problems with SCSI tape rewind / verify on 2.4.29
Message-ID: <20050302143440.GA2543@logos.cnet>
References: <E7F85A1B5FF8D44C8A1AF6885BC9A0E472B886@ratbert.vale-housing.co.uk> <20050302120332.GA27882@logos.cnet> <200503021208.51480.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503021208.51480.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


n Wed, Mar 02, 2005 at 12:08:51PM -0500, Gene Heskett wrote:
> On Wednesday 02 March 2005 07:03, Marcelo Tosatti wrote:
> >On Wed, Mar 02, 2005 at 11:15:42AM -0000, Mark Yeatman wrote:
> >> Hi
> >>
> >> Never had to log a bug before, hope this is correctly done.
> >>
> >> Thanks
> >>
> >> Mark
> >>
> >> Detail....
> >>
> >> [1.] One line summary of the problem:
> >> SCSI tape drive is refusing to rewind after backup to allow verify
> >> and causing illegal seek error
> >>
> >> [2.] Full description of the problem/report:
> >> On backup the tape drive is reporting the following error and
> >> failing it's backups.
> >>
> >> tar: /dev/st0: Warning: Cannot seek: Illegal seek
> >>
> >> I have traced this back to failing at an upgrade of the kernel to
> >> 2.4.29 on Feb 8th. The backups have not worked since. Replacement
> >> Drives have been tried and cables to no avail. I noticed in the
> >> the changelog that a patch by Solar Designer to the Scsi tape
> >> return code had been made.
> >
> >v2.6 also contains the same problem BTW.
> >
> >Try this:
> >
> >--- a/drivers/scsi/st.c.orig 2005-03-02 09:02:13.637158144 -0300
> >+++ b/drivers/scsi/st.c 2005-03-02 09:02:20.208159200 -0300
> >@@ -3778,7 +3778,6 @@
> >  read:  st_read,
> >  write:  st_write,
> >  ioctl:  st_ioctl,
> >- llseek:  no_llseek,
> >  open:  st_open,
> >  flush:  st_flush,
> >  release: st_release,
> >-
> 
> Interesting Marcelo.  How long has this been true in 2.6?

Actually I just checked and it seems v2.6 is not using "no_llseek".

However John L. Males reports the same problem with v2.6 - John, care
to retest with v2.6.10 ?

> I thought I had an amanda problem, and eventually went to virtual 
> tapes on disk, largely because of this.  However, I have to say it is 
> working better than tapes ever did here.  Unforch, that 200GB disk is 
> certainly a single point of failure I don't relish thinking about...

:)
