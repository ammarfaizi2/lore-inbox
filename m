Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSFZRsf>; Wed, 26 Jun 2002 13:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316746AbSFZRse>; Wed, 26 Jun 2002 13:48:34 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:20237 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S316739AbSFZRsc>; Wed, 26 Jun 2002 13:48:32 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A789A@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'rwhite@pobox.com'" <rwhite@pobox.com>, "'Theodore Tso'" <tytso@mit.edu>,
       "'Russell King'" <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: RE: n_tty.c driver patch (semantic and performance correction) (a
	ll recent versions)
Date: Wed, 26 Jun 2002 10:48:30 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Sat, June 15, 2002, Robert White wrote:
> 
> The n_tty line discipline module contains a "semantic error" 
> that limits its speed and usefullness in many uses.  The 
> attached patch directly addresses serial performance in a 
> completely backwards-compatable way.
> 
> In particular, the current handling of VMIN hugely limits, 
> complicates, and/or slows down optimal serial use.  The most 
> obvius example is that if you call read(2) with a buffer size 
> less than the current value of VMIN, the line discipline will 
> insist that the read call wait for characters that can not be 
> returned to that call.  The POSIX standard is silent on the 
> subject of whether this is right or wrong.  Common sense says 
> it is wrong.
> 

Ten years ago, I would have agreed with you. I suggested a very 
similar change for VTIME=0;VMIN>0 behavior back then, while we 
were porting SVR4 to proprietary hardware. This was for 
compatibility with the way reads were handled on a previous 
non-un*x product. It was deemed a spec violation, so we added an 
ioctl to implement the compatible behavior. 

Does the spec say that VMIN behavior depends on the size of a 
blocking read? No, it says that the read completes when VMIN or 
more characters have been received. If VMIN is three and two 
characters have been received, completing a blocking read of any 
size is a violation. Should we also add a "read buffer size" 
parameter to select and poll, etc. so they can report that read 
data is available before satisfying VMIN, too? 

Ted, Russell, please weigh in on this. 

Best regards,
Ed

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
