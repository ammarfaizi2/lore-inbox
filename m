Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265727AbUEZNxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265727AbUEZNxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbUEZNxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:53:08 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:6911 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265733AbUEZNwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:52:13 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Matthias Schniedermeyer'" <ms@citd.de>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 06:55:18 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040526123740.GA14584@citd.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRDHz9nBfIUe0YPTWe69s0PwXqN3wACSwhQ
Message-Id: <S265733AbUEZNwN/20040526135213Z+639@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well for mmapped pages, man madvise. Specifically look at MADV_SEQUENTIAL
and MADV_DONTNEED.

--Buddy

http://lxr.linux.no/source/mm/madvise.c?v=2.6.5#L92
 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Matthias
Schniedermeyer
Sent: Wednesday, May 26, 2004 5:38 AM
To: Nick Piggin
Cc: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?

On Wed, May 26, 2004 at 09:19:40PM +1000, Nick Piggin wrote:
> Matthias Schniedermeyer wrote:
> >On Wed, May 26, 2004 at 08:33:28PM +1000, Nick Piggin wrote:
> 
> OK, this is obviously bad. Do you get this behaviour with 2.6.5
> or 2.6.6? If so, can you strace the program while it is writing
> an ISO? (just send 20 lines or so). Or tell me what program you
> use to create them and how to create one?

To use other words, this is the typical case where a "hint" would be
useful.

program to kernel: "i read ONCE though this file caching not useful".

The last thing i knew in this area is that there exist a thing to tell
the kernel to drop all cache after the file is closed. (IIRC!)

But this doesn't help in this case as the image-file is up to 4,4GB in
whole which means that it ALONE can fill up the whole cache. Taking
aside the files the image was created from, which can (with a size of up
to 2GB (size-limit of iso9660-filesystem/linux-kernel)) also fill a lot
of cache until they are closed.

(The/My) typical case is this.
1 create image-file
2 remove source-files
3 burn image
4 remove image-file

Step 1 and 3 trash the cache without ANY positive effect.



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

