Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270795AbRHTLg6>; Mon, 20 Aug 2001 07:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271109AbRHTLgi>; Mon, 20 Aug 2001 07:36:38 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:36367 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S270795AbRHTLgb>; Mon, 20 Aug 2001 07:36:31 -0400
Message-ID: <3B80F5FA.D9B0C8@idb.hist.no>
Date: Mon, 20 Aug 2001 13:35:22 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: otto.wyss@bluewin.ch, linux-kernel@vger.kernel.org
Subject: Re: Why don't have bits the same rights as humans! (flushing to disk 
 waiting time)
In-Reply-To: <3B802B68.ADA545DB@bluewin.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otto Wyss wrote:
> 
> I recently wrote some small files to the floppy disk and noticed almost nothing
> happened immediately but after a certain time the floppy actually started
> writing. So this action took more than 30 seconds instead just a few. This
> remembered me of the elevator problem in the kernel. To transfer this example
> into real live: A person who wants to take the elevator has to wait 8 hours
> before the elevator even starts. While probably everyone agrees this is
> ridiculous in real live astonishingly nobody complains about it in case of a disk.
> 
> Why don't have bits the same rights as humans! ;-)
> 
Bits are in no hurry.  If you want to eject - run umount.  umount
will flush everything immediately.  If you merely want stuff out to
disk - use sync.

Putting writes on hold for a while helps the impossible to foresee
situation when some important reads suddenly comes up.  The system don't
_know_ yet it will happen, but it will happen in shorter time than
it takes to write the stuff.  So writes are stalled in cache because
you have enough of that, and it is always possible to cache a write.
Reads must be done now and then because they aren't always in cache,
and the kernel tries to keep devices ready to do that on short notice.


Helge Hafting
