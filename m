Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265465AbUBPJyh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 04:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265477AbUBPJyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 04:54:36 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:53936 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265465AbUBPJyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 04:54:35 -0500
Subject: Re: dm-crypt using kthread (was: Oopsing cryptoapi (or
	loop	device?) on 2.6.*)
From: Christophe Saout <christophe@saout.de>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0402160409190.26082@alpha.polcom.net>
References: <402A4B52.1080800@centrum.cz>
	 <1076866470.20140.13.camel@leto.cs.pocnet.net>
	 <20040215180226.A8426@infradead.org>
	 <1076870572.20140.16.camel@leto.cs.pocnet.net>
	 <20040215185331.A8719@infradead.org>
	 <1076873760.21477.8.camel@leto.cs.pocnet.net>
	 <20040215194633.A8948@infradead.org>
	 <20040216014433.GA5430@leto.cs.pocnet.net>
	 <20040215175337.5d7a06c9.akpm@osdl.org>
	 <Pine.LNX.4.58.0402160303560.26082@alpha.polcom.net>
	 <1076900606.5601.47.camel@leto.cs.pocnet.net>
	 <Pine.LNX.4.58.0402160409190.26082@alpha.polcom.net>
Content-Type: text/plain
Message-Id: <1076925269.5228.7.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 10:54:29 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 16.02.2004 schrieb Grzegorz Kulewski um 04:22:

> Did you heard / read about Herring?

No, what is it?

> I found .pdf somewhere (I think I still have it). It is better alternative 
> to ECB or CBC algorithms used in cryptoloop (if I understand good). Could 
> something like that be implemented in dm-crypt? Is it already?

I can do whatever cryptoapi offers (and isn't too complicated).

> Could somebody write dm-compress (compressing not encrypting)? Is it 
> technically possible (can device mapper handle different data size at 
> input, differet at output)? (I think there is compressing loop patch.)
> Could dm first compress data (even with weak algorithm), then encrypt, to 
> make statistical analysis harder?

Compression is something that is fine in the loop driver but when done
read-only (because it can be backed by something that isn't limited to
do I/O on sector boundaries) but very hard to do in the block layer,
especially read-write. It should really be done in a filesystem because
you have to do dynamic allocation and such things and you can't even
guarantee a certain disk size.

> And, to be sure, does dm-crypto add anything in the begining (ie. 
> header) or in other places to the stored data? Or it is the same data 
> (same size) but encrypted?  

No, it doesn't do anything. These things should be done entirely in
userspace.


