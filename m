Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbUKFD4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbUKFD4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 22:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbUKFD4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 22:56:38 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:36242 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261307AbUKFD4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 22:56:36 -0500
Date: Fri, 5 Nov 2004 19:55:22 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Ross Biro <ross.biro@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@pyxtechnologies.com>
Subject: Re: [PATCH 2/3] WIN_* -> ATA_CMD_* conversion: update WIN_* users to use ATA_CMD_*
Message-ID: <20041106035522.GA13091@taniwha.stupidest.org>
References: <20041103091101.GC22469@taniwha.stupidest.org> <418AE8C0.3040205@pobox.com> <58cb370e041105051635c15281@mail.gmail.com> <20041106032314.GC6060@taniwha.stupidest.org> <8783be660411051945252097c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8783be660411051945252097c3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 10:45:04PM -0500, Ross Biro wrote:

> Just a reminder, this error recovery doesn't work on many modern
> hard drives, and is a violation of all ATA specs after ATA-2*.

I think this code is the only user of that token and I wonder how well
tested this is?  Bart?  Andre?

> In particular, most Maxtor and Western Digital Drives will not
> recover from errors with this command sequence.  The preferred error
> recovery is to do a reset followed by a set features, because that
> is what Windows does (as told to me by a drive vendor).

I assume for Windows they do that for all drives?  Even older ones?

I also wonder what happens with TCQ when you get an error?  Do you
just retry everything outstanding?

> I've tested the reset/set features method of error recovery and it
> works on all the drives I've tried.  I have not tried it on any
> older drives, or any other types of ATAPI devices.

It probably should get fixed, there just doesn't seem to be much
incentive to beat on the old IDE code though :( Minor cleanups seem
worthwhile but anything intrusive I worry will break some hard-to-test
platform for someone.

That said, if libata gets PATA support merged then know this is
wonderful there.
