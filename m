Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272315AbRIKHra>; Tue, 11 Sep 2001 03:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272316AbRIKHrU>; Tue, 11 Sep 2001 03:47:20 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:28427 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S272315AbRIKHrM>; Tue, 11 Sep 2001 03:47:12 -0400
Message-ID: <3B9DC12C.9C9C31D2@idb.hist.no>
Date: Tue, 11 Sep 2001 09:45:48 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.10-pre7 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <Pine.LNX.4.33.0109101909010.1290-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> > An observation: logical readahead can *never* read a block before it knows
> > what the physical mapping is, whereas physical readahead can.
> 
> Sure. But the meta-data is usually on the order of 1% or less of the data,
> which means that you tend to need to read a meta-data block only 1% of the
> time you need to read a real data block.

Seems to me a readahead without metadata don't buy very much.  Sure,
you get the file page early without looking up metadata on disk.  But
oops - it cannot be used yet as we don't yet know the fact that it _is_
part of the file!  When the process gets to ask for that part of the
file
we still have to wait for metadata.

Physical readahead may or may not help - but I cannot see that this
particular aspect helps anything.

Helge Hafting
