Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267047AbSKMAPe>; Tue, 12 Nov 2002 19:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbSKMAPd>; Tue, 12 Nov 2002 19:15:33 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:18187 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266999AbSKMAPc>; Tue, 12 Nov 2002 19:15:32 -0500
Date: Wed, 13 Nov 2002 00:22:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: Linux v2.5.47
Message-ID: <20021113002222.B323@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org
References: <Pine.LNX.4.44.0211101944030.17742-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211101944030.17742-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Nov 10, 2002 at 07:46:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 07:46:06PM -0800, Linus Torvalds wrote:
> 
> I still have stuff pending, but this is what's currently merged. 

Btw, here's a little headsup for all maintainers of scsi host adapter
drivers.  In 2.5.47 the detect and release methods of the Scsi_Host_Template
have become optional.  If you had an old pci driver with the following
loop in foo_detcect:

	while ((pdev = pci_find_device())) {
		[do basic setup]
		sdev = scsi_register();
		[do more setup]
	}

You can convert it easily into a new-style pci driver with the following
probe routine:

	[do basic setup]
	sdev = scsi_register();
	[do more setup]
	return scsi_add_host();

Similarly a new routine, scsi_remove_host exist to call at the end
of the remove routine.


