Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293249AbSCVIHF>; Fri, 22 Mar 2002 03:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293244AbSCVIGp>; Fri, 22 Mar 2002 03:06:45 -0500
Received: from mario.gams.at ([194.42.96.10]:54854 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S293249AbSCVIGk>;
	Fri, 22 Mar 2002 03:06:40 -0500
Message-Id: <200203220806.JAA10107@merlin.gams.co.at>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Axel Kittenberger <Axel.Kittenberger@maxxio.com>
Organization: Maxxio Technologies
To: Pete Zaitcev <zaitcev@redhat.com>,
        Axel Kittenberger <Axel.Kittenberger@maxxio.at>
Subject: Re: Patch, forward release() return values to the close() call
Date: Fri, 22 Mar 2002 09:06:38 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <mailman.1016697001.29134.linux-kernel2news@redhat.com> <200203211845.g2LIjTu22218@devserv.devel.redhat.com>
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a relatively sane part, though I would ask Viro first
> if changing the prototype of fput is such a great idea.
> However, the justification below is completely brain damaged.

I would love to hear his opinion, 
(I send him this patch some months ago...)

> So, we're here with an error from close. NOW WHAT DO WE DO?!
> That's right, you have NO CHOICE but to CLOSE AGAIN, and loop
> until that condition clears (think about exit() for a moment).

Well waybe I picked with "fail on close" the wrong words, close always 
succeeds, but yet it's return value can signal error conditions.

$> man close

NOTES
       Not checking the return value of close is a common but nevertheless 
serious programming error.  File  system  imple­
       mentations  which  use  techniques  as  ``write-behind''  to  increase 
 performance may lead to write(2) succeeding,
       although the data has not been written yet.  The error status may be 
reported at a later write operation, but it  is
       guaranteed  to  be  reported  on  closing the file.  Not checking the 
return value when closing the file may lead to
       silent loss of data.  This can especially be observed with NFS and 
disk quotas.

So when closing a file with write-behind cache, close() signals in example an 
error (it """fails"""), as application I do not have close it again or to 
circle, but I have to live with the fact that something went wrong, and at 
least have to inform the user about this, (or return with the error level 
set, like dd or cp do it, if a close() """fails""".)
