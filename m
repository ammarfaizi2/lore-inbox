Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317499AbSG2QRT>; Mon, 29 Jul 2002 12:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSG2QRT>; Mon, 29 Jul 2002 12:17:19 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:38084 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317499AbSG2QRS>;
	Mon, 29 Jul 2002 12:17:18 -0400
Subject: page allocation failure. order:0,  mode:0x0
To: Andrew Morton <akpm@zip.com.au>
Cc: akpm@zip.com.au, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF0A1A9652.12E2201D-ON85256C05.005979B0@pok.ibm.com>
From: "David F Barrera" <dbarrera@us.ibm.com>
Date: Mon, 29 Jul 2002 11:20:31 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 SPR# MIAS5B3GZN |June
 28, 2002) at 07/29/2002 12:20:32 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tried the lru-removal.patch on 2.5.27 but the problem still occurs.
Many of these displayed on dmesg:  pdflush: page allocation failure.
order:0, mode:0x0

David Barrera



                                                                                                                                       
                      Andrew Morton                                                                                                    
                      <akpm@zip.com.au>        To:       Andrea Arcangeli <andrea@suse.de>                                             
                      Sent by:                 cc:       David F Barrera/Austin/IBM@IBMUS, linux-kernel@vger.kernel.org                
                      akpm@e3.ny.us.ibm        Subject:  Re: kernel BUG at page_alloc.c:92! & page allocation failure. order:0,        
                      .com                      mode:0x0                                                                               
                                                                                                                                       
                                                                                                                                       
                      07/24/2002 03:11                                                                                                 
                      PM                                                                                                               
                                                                                                                                       
                                                                                                                                       



Andrea Arcangeli wrote:
>
> On Wed, Jul 24, 2002 at 12:35:54PM -0700, Andrew Morton wrote:
> > And please drop the ptrace.c change and use
> > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.27/lru-removal.patch
> > instead.
>
> page_cache_release() can return a #define to __free_page().
>

Man, it can do a ton more than that.  This patch is just a stopgap
to prevent the oops.

page_cache_release() goes out onto the bus for the PageReserved()
test and then immediately goes out onto the bus again to perform the
atomic_dec_and_test().  Plus it tends to do all this inside
a global lock.  That PageReserved thing needs to go away.

Seriously, this stuff needs a truck driven through it.  See
http://mail.nl.linux.org/linux-mm/2002-07/msg00009.html and things
like pagevec_release().  It still needs quite some work, but the
optimisations which are available here are considerable.

-





