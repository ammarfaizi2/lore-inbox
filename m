Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVIMKRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVIMKRb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 06:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVIMKRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 06:17:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6027 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750751AbVIMKRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 06:17:30 -0400
Date: Tue, 13 Sep 2005 11:17:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Douglas Gilbert <dougg@torque.net>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 2/14] sas-class: README
Message-ID: <20050913101727.GA30865@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Douglas Gilbert <dougg@torque.net>,
	Luben Tuikov <luben_tuikov@adaptec.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <4321E4DD.7070405@adaptec.com> <432543C6.1020403@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432543C6.1020403@torque.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 07:00:54PM +1000, Douglas Gilbert wrote:
> > +This is a link to the tree(1) program, very useful in
> > +viewing the SAS domain:
> > +ftp://mama.indstate.edu/linux/tree/
> > +I expect user space applications to actually create a
> > +graphical interface of this.
> > +
> > +That is, the sysfs domain tree doesn't show or keep state if
> > +you e.g., change the meaning of the READY LED MEANING
> > +setting, but it does show you the current connection status
> > +of the domain device.
> 
> So in that case, user applications should ignore READY
> LED MEANING in sysfs and ask the device directly.
> For example:
>     sdparm --get RLM --transport sas /dev/sda
> 
> > +Keeping internal device state changes is responsibility of
> > +upper layers (Command set drivers) and user space.
> 
> ... and what about multiple initiators sitting on different
> machines? Should they be responsible for:
>   1) finding out about one another
>   2) and keeping the sysfs tree in the other machine
>      in sync when one changes READY LED MEANING
>      (or anything else)?
> 
> Putting distributed state information in sysfs and then
> passing off the responsibility for maintaining its state
> (because it is a difficult problem) brings into question
> the wisdom of the strategy.

If you looks at what the other transport classes do is that they put
information at discovery time into sysfs, but try to refresh it on
every access.  IMHO that makes a lot of sense, and should be done
that way in the final SAS transport class.
