Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276110AbRJBSXV>; Tue, 2 Oct 2001 14:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276109AbRJBSXE>; Tue, 2 Oct 2001 14:23:04 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:37382 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S276108AbRJBSWM>; Tue, 2 Oct 2001 14:22:12 -0400
Message-ID: <3BBA05E9.63162EB4@zip.com.au>
Date: Tue, 02 Oct 2001 11:22:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ricky Beam <jfbeam@bluetopia.net>
CC: Lorenzo Allegrucci <lenstra@tiscalinet.it>, linux-kernel@vger.kernel.org
Subject: Re: Huge console switching lags
In-Reply-To: <3BB9F1F2.B6873DFD@zip.com.au> <Pine.GSO.4.33.0110021408310.22872-100000@sweetums.bluetronic.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam wrote:
> 
> On Tue, 2 Oct 2001, Andrew Morton wrote:
> >In 2.4.10, the console switching code moved from interrupt context
> >into process context.  So if your system is taking a long time to
> >schedule processes (in this case, keventd) then yes, console
> >switching will take a long time.
> 
> And what's the brilliant reason for this?  And don't give any BS about it
> taking too long inside an interrupt context -- we're switching consoles not
> start netscrape.
> 

It takes too long in interrupt context :)  Tens of milliseconds
or more.  More importantly, it sorts the locking out - you can't
acquire a semaphore in interrupt context.
