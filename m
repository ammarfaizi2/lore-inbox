Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130069AbRALSzs>; Fri, 12 Jan 2001 13:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129992AbRALSzi>; Fri, 12 Jan 2001 13:55:38 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:36543 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129967AbRALSzY>; Fri, 12 Jan 2001 13:55:24 -0500
Date: Fri, 12 Jan 2001 10:10:59 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: O_NONBLOCK, read(), select(), NFS, Ext2, etc.
To: rothwell@holly-springs.nc.us, linux-kernel@vger.kernel.org
Reply-to: dank@alumni.caltech.edu
Message-id: <3A5F48B3.FC398B81@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell (rothwell@holly-springs.nc.us) wrote:

> How about using fcntl(), O_ASYNC and SIGIO? 

Don't think that's supported for disk files yet, at least by the
kernel.  glibc does aio emulation with threads, which isn't great.

> Or maybe a broader question: 
> what's the preferred/working way to do async file i/o on Linux? 

SGI has done lots of work on this, using kernel threads; 
they don't have a patch yet for 2.4.0, but they do support
2.2.17 and 2.4.0-test10.

TUX uses async I/O, I think, but it's inside the kernel.
I hear plans are afoot for giving userspace async I/O that
avoids creating threads; that should be more scalable than
SGI's approach, if it ever happens.

See http://www.kegel.com/c10k.html#aio for links and a few notes.
- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
