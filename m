Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265277AbUAPFtl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 00:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbUAPFtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 00:49:41 -0500
Received: from palrel12.hp.com ([156.153.255.237]:65156 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265254AbUAPFth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 00:49:37 -0500
Date: Thu, 15 Jan 2004 21:50:31 -0800
From: Grant Grundler <iod00d@hp.com>
To: Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       jeremy@sgi.com
Subject: Re: [PATCH] readX_relaxed interface
Message-ID: <20040116055031.GD13222@cup.hp.com>
References: <20040115204913.GA8172@sgi.com> <20040116003224.GF23253@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116003224.GF23253@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 04:32:25PM -0800, Greg KH wrote:
[ deleted reminder for readb() to return success/fail codes ]
> Just wanted to put this idea in people's heads that we need to start
> planning for something like it.

I just remembered another part of linux 2.4/2.6 that needs revisiting:
DMA mapping routines don't return an error code.
ie pci_map_single() must panic since it can't return a failure.
It was designed that way on purpose to make life easier for driver
writers (and I agree, it has).

(my guess is x86-64 needs this change more urgently than any other arch.)

I'm sure there are other robustness issues too.
Looking for "panic" will probably give alot of them away.
The current 2.6.1 tree has over 1000 panic() calls.
I used "find -name \*.c | fgrep panic\( | wc ".

And for my amusement:
grundler <506>find drivers/scsi -name \*.c | xargs fgrep panic\( | wc
    183    1243   14722
grundler <507>find drivers/net -name \*.c | xargs fgrep panic\( | wc
     10      53     662

My point is a substantial number of things can be done to improve
robustness besides (or in addition to?) recovering from IO subsystem
crashes.

grant
