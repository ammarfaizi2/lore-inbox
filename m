Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRA0KiK>; Sat, 27 Jan 2001 05:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130370AbRA0KiA>; Sat, 27 Jan 2001 05:38:00 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:29418 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129444AbRA0Khy>; Sat, 27 Jan 2001 05:37:54 -0500
Message-ID: <3A72A6C9.7D085A39@uow.edu.au>
Date: Sat, 27 Jan 2001 21:45:29 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
CC: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
        Aaron Lehmann <aaronl@vitelus.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A728475.34CF841@uow.edu.au> <200101271009.f0RA9fb04363@moisil.dev.hydraweb.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> 
> On Sat, 27 Jan 2001 19:19:01 +1100, Andrew Morton <andrewm@uow.edu.au> wrote:
> 
> > The figures I quoted for the no-hw-checksum case were still
> > using scatter/gather.  That can be turned off as well and
> > it makes it a tiny bit quicker.
> 
> Hmm. Are you sure the differences are not just noise?

I don't think so.  It's all pretty repeatable.

> Unless you
> modified the zerocopy patch yourself, it won't use SG without
> checksums...

I believe it in fact does use SG when hardware tx checksums are unavailable,
but this capability wil be removed RSN because userspace can scribble
on the pagecache after the checksum has been calculated, and before
the frame has hit the wire.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
