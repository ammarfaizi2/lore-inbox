Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVEQFys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVEQFys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 01:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVEQFys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 01:54:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63646 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261182AbVEQFye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 01:54:34 -0400
Date: Tue, 17 May 2005 06:54:52 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, petero2@telia.com
Subject: Re: [PATCH] Fix root hole in pktcdvd
Message-ID: <20050517055452.GQ1150@parcelfarce.linux.theplanet.co.uk>
References: <11163046681444@kroah.com> <11163046692974@kroah.com> <20050517050025.GP1150@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517050025.GP1150@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 06:00:25AM +0100, Al Viro wrote:
> Same comment as for previous patch.  I'll take a look at that sucker,
> it might happen to be OK, seeing that most of the bdev ->ioctl() instances
> ignore file argument and we might get away with passing odd stuff to
> anything that could occur here.

Oh, lovely - pkt_open() opens underlying device, unless we already have our
device opened.  Guess what happens if you open() with O_RDONLY and
then - with O_RDWR?
