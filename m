Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265147AbUFHBDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265147AbUFHBDe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 21:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUFHBDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 21:03:33 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:22759 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S265147AbUFHBDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 21:03:32 -0400
Subject: Re: Finding user/kernel pointer bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040608000310.GL12308@parcelfarce.linux.theplanet.co.uk>
References: <1086652124.14180.5.camel@dooby.cs.berkeley.edu> 
	<20040608000310.GL12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Jun 2004 18:03:29 -0700
Message-Id: <1086656609.14180.16.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-07 at 17:03, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Mon, Jun 07, 2004 at 04:48:44PM -0700, Robert T. Johnson wrote:
> > - cqual requires _zero_ annotations in device drivers.
> > 
> >   Once the generic driver interfaces have been annotated, all device
> >   drivers can be checked against these annotations without any further
> >   effort.  This is critical, since annotating the thousands of device
> >   drivers in linux will be extremely difficult and take months.
> 
> Aha, so you have never actually bothered to read the damn things.  Two words:
> ioctl code.

CQual has already found numerous bugs in driver ioctl code, all without
any explicit annotations in that code.  This is possible because cqual
infers the required annotations from a few annotations I gave it.  

While examining these bugs, I had to read _a lot_ of driver code, and I
agree that some of it is very colorful.

> And one more: counting drivers that do not have a single __user in them
> is meaningless for so many reasons it's not even funny.

Maybe sparse has features that I don't know about, but since lots of
device drivers have ioctl functions, doesn't that mean that lots of
device drivers need at least one __user annotation (on the ioctl "arg"
argument)?  If that annotation is missing and the device driver
dereferences arg (after casting it to a pointer), won't this result in a
false negative?  I agree that it's not a perfect metric, but it's a
start.

Best,
Rob


