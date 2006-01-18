Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030378AbWARQZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbWARQZs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWARQZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:25:48 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:48717 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030378AbWARQZr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:25:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HvbkRgI67uCWrrJpjM614lEAGOCaXom+fSjJpAuzSTKGvFYUskknrGCPMDakzZAyNjpilSZ8HqKBVBCFFwc9eP94ps6WFcEcawk802Yb1DZyK/UrHpQJaM8bf/KTlB/6LpdHl03Vtx0CNDlH9vDDUDh5CoA+RL3/gptdSgvWqBM=
Message-ID: <58cb370e0601180825l105d81fbk9a5e57b722255f96@mail.gmail.com>
Date: Wed, 18 Jan 2006 17:25:44 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: io performance...
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Max Waterman <davidmaxwaterman@fastmail.co.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43CE6363.2020402@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43CB4CC3.4030904@fastmail.co.uk> <43CDAFE3.8050203@fastmail.co.uk>
	 <43CDC44E.6080808@wolfmountaingroup.com>
	 <1137576064.25819.11.camel@localhost.localdomain>
	 <43CE6363.2020402@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/06, Phillip Susi <psusi@cfl.rr.com> wrote:
> I was going to say, doesn't the kernel set the FUA bit on the write
> request to push important flushes through the disk's write-back cache?
> Like for filesystem journal flushes?

Yes if:
* you have a disk supporting FUA
* you have kernel >= 2.6.16-rc1
* you are using SCSI (this includes libata) driver [ support for IDE driver
  will be merged later when races in changing IDE  settings are fixed ]

Bartlomiej

> Alan Cox wrote:
> > Not always. If you have a cache flush command and the OS knows about
> > using it, or if you don't care if the data gets lost over a power
> > failure (eg /tmp and swap) it makes sense to force it.
> >
> > The raid controller drivers that fake scsi don't always fake enough of
> > scsi to report that they support cache flushes and the like. That
> > doesn't mean the controller itself is neccessarily doing one thing or
> > the other.
