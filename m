Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVIKNlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVIKNlc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 09:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbVIKNlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 09:41:32 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:3003 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750817AbVIKNlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 09:41:31 -0400
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
From: James Bottomley <James.Bottomley@SteelEye.com>
To: ak@muc.de
Cc: Rik van Riel <riel@redhat.com>, Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050911035621.87661.qmail@mail.muc.de>
References: <20050910041218.29183.qmail@web51612.mail.yahoo.com>
	 <Pine.LNX.4.63.0509101028510.4630@cuia.boston.redhat.com>
	 <20050911035621.87661.qmail@mail.muc.de>
Content-Type: text/plain
Date: Sun, 11 Sep 2005 08:41:10 -0500
Message-Id: <1126446071.4831.5.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-11 at 05:56 +0200, ak@muc.de wrote:
> >> Naturally, aic94xx has _no limitations_. :-)  But hey, our hardware just 
> >> kicks a*s!
> >
> > That's very nice for you - but lets face it, a SAS layer
> > that'll be unable to also deal with the El-Cheapo brand
> > controllers isn't going to be very useful.
> 
> Nobody knows what these bu^wlimitations will be though. So you cannot
> really plan for them in advance.  When someone writes drivers for such 
> limited hardware they can add code to handle the limitations. But it 
> seems reasonable to start with a clean hardware model, and only
> add the hacks later when they are really needed and the requirements
> are understood.

But my point was that we already have a mechanism for coping with this:
The scsi template parameterises some of these things (max sector size,
sg table elements, clustering, etc).  For less standard things it
doesn't cover the driver uses the blk_ adjustors directly from
slave_alloc/slave_configure (This is currently how USB and firewire
communicate their alignment requirements).

By wrappering both the template and the slave_alloc/slave_configure
methods in the SAS class and not providing the driver access, it can't
use existing methods to make any adjustments that may be necessary.

James


