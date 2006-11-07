Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753735AbWKGAYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbWKGAYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 19:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753871AbWKGAYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 19:24:19 -0500
Received: from mga03.intel.com ([143.182.124.21]:45931 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1753735AbWKGAYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 19:24:18 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,392,1157353200"; 
   d="scan'208"; a="142153707:sNHT18765299"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Brent Baccala'" <cosine@freesoft.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: async I/O seems to be blocking on 2.6.15
Date: Mon, 6 Nov 2006 16:24:18 -0800
Message-ID: <000101c70203$10244b80$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccCAD1IqgfA3GchRw+fLW8Rw2f8jwAAHUQg
In-Reply-To: <Pine.LNX.4.64.0611061903220.27775@debian.freesoft.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brent Baccala wrote on Monday, November 06, 2006 4:04 PM
> On Mon, 6 Nov 2006, Chen, Kenneth W wrote:
> > I've tried that myself too and see similar result.  One thing to note is
> > that I/O being submitted are pretty big at 1MB, so the vector list inside
> > bio is going to be pretty long and it will take a while to construct that.
> > Drop the size for each I/O to something like 4KB will significantly reduce
> > the time.  I haven't done the measurement whether the time to submit I/O
> > grows linearly with respect to I/O size.  Most likely it will.  If it is
> > not, then we might have a scaling problem (though I don't believe we have
> > this problem).
> 
> I'm basically an end user here (as far as the kernel is concerned), so
> let me ask the basic "dumb user" question here:
> 
> How should I do my async I/O if I just want to read or write
> sequentially through a file, using O_DIRECT, and letting the CPU get
> some work done in the meantime?  What about more random access?
> 
> I've already concluded that I should try to keep my read and write
> files on seperate disks and hopefully on seperate controllers, but I
> still seem to be fighting this thing to keep it from blocking.


You bark rightfully at the fact that kernel blocks in the async path when
block queue is full. It would be nice that -EAGAIN is returned so app can
do other stuff.

My earlier post was commenting on the measurement of I/O submit when
nothing blocks (which happens to be extremely important to me).  Your
measurement of 7ms seems excessive. While mine and Jens came at around
90 micro-second which isn't all that unreasonable given the size of the
I/O request.

- Ken

