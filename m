Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVEBXSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVEBXSa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 19:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVEBXSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 19:18:30 -0400
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:61100 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S261217AbVEBXSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 19:18:22 -0400
Subject: Re: How to flush data to disk reliably?
From: Arjan van de Ven <arjan@infradead.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Grzegorz Kulewski <kangur@polcom.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1050502182749.28303A-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1050502182749.28303A-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Date: Mon, 02 May 2005 19:17:16 -0400
Message-Id: <1115075836.6501.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-02 at 18:30 -0400, Bill Davidsen wrote:
> On Mon, 2 May 2005, Alan Cox wrote:
> 
> > On Llu, 2005-05-02 at 20:18, Grzegorz Kulewski wrote:
> > > What about other filesystems? Does anybody know anwser for Reiserfs3, 
> > > Reiser4, JFS, XFS and any other popular server filesystems? I assume that 
> > > if log file is some block device (like partition) both O_SYNC and fsync 
> > > will work? What about ext2? What about some strange RAID/DM/NBD 
> > > configurations? (I do not know in advance what our customers will use so I 
> > > need portable method.)
> > 
> > RAID does stripe sized rewrites so you get into the same situation as
> > with actual disks - a physical media failure might lose you old data
> > (but then if the disk goes bang so does the data...)
> 
> I hope I'm reading that wrong, and that rewriting a single sector of a
> file doesn't result in r-a-w of the entire stripe. That would be a large
> memory hit for filesystems with large stripes for mostly sequential i/o.

it results in a read of the entire stripe and at least two writes (the
actual data and the new parity)

the alternative (and I don't think linux does that) is to read the old
data sector, and do an differential xor. 



