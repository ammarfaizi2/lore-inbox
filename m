Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVFNVms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVFNVms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 17:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVFNVmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 17:42:47 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:63141 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261353AbVFNVm3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 17:42:29 -0400
Date: Tue, 14 Jun 2005 23:42:26 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Frank van Maarseveen <frankvm@frankvm.com>,
       Gr?goire Favre <gregoire.favre@gmail.com>, dino@in.ibm.com,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050614214226.GA15560@janus>
References: <20050530190716.GA9239@gmail.com> <1118081857.5045.49.camel@mulgrave> <20050607085710.GB9230@gmail.com> <1118590709.4967.6.camel@mulgrave> <20050613145000.GA12057@gmail.com> <1118674783.5079.9.camel@mulgrave> <20050613183719.GA8653@gmail.com> <1118695847.5079.41.camel@mulgrave> <20050613214208.GA7471@janus> <1118703593.5079.56.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118703593.5079.56.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 05:59:53PM -0500, James Bottomley wrote:
> On Mon, 2005-06-13 at 23:42 +0200, Frank van Maarseveen wrote:
> > kernel:    Vendor: WANGTEK   Model: 5525ES SCSI       Rev: 73F 
> > kernel:    Type:   Sequential-Access                  ANSI SCSI
> > revision: 02
> > kernel:   target0:0:4: Beginning Domain Validation
> > kernel:   target0:0:4: Domain Validation skipping write tests
> > kernel:  scsi0:0:4:0: Attempting to queue an ABORT message
> 
> The aic7xxx error handling is still very unreconstructed and DV takes
> the driver through this if there's a mismatch.  My best guess is that
> like Gr\'egoir's CD-ROM, your wangtek is claiming to support a speed it
> cannot.  We find this out in DV, but not until we've gone through all
> the error paths.  The quick fix is simply to set the bios to whatever
> the tape eventually configures with (although you'll need the current
> patch set to make that work properly).

Well, I can't seem to find the right collection of patches applying
cleanly on 2.6.12-rc6 and the Adaptec BIOS says "ASYNC". It cannot
go below 10MB/s and the tape unit can't go above 3.3 according to
/proc/scsi/aic7xxx/0 I think:

Target 4 Negotiation Settings
        User: 6.600MB/s transfers (16bit)
        Goal: 3.300MB/s transfers
        Curr: 3.300MB/s transfers
        Channel A Target 4 Lun 0 Settings
                Commands Queued 61
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0

So, I'm kind of stuck with a very slow driver initialization. I think it
takes much longer than the 30 seconds visible in the logfile, at least
that's the impression I have (I'll use a stopwatch next time).

-- 
Frank
