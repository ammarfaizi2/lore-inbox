Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWJLU4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWJLU4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWJLU4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:56:53 -0400
Received: from web58103.mail.re3.yahoo.com ([68.142.236.126]:35169 "HELO
	web58103.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1750770AbWJLU4w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:56:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Y2Smum2Dz8jCq80xiZ6YgMp82lHsXQ0BrjP/L7p7Y2Hw2OUb10OtMfHNC+fuHhmE6uaTiYNyZEX76gMNVd03tIJF/yLFfzjgLQ2hnb7TXrZ2tcpCZt1Pr9vnrmuK1gbVQwTlns7iY3IgTxfk6wfBkmTpejZyHNlqSIZA5146DZA=  ;
Message-ID: <20061012205651.2853.qmail@web58103.mail.re3.yahoo.com>
Date: Thu, 12 Oct 2006 13:56:51 -0700 (PDT)
From: Open Source <opensource3141@yahoo.com>
Subject: Re: USB performance bug since kernel 2.6.13 (CRITICAL???)
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I am pretty sure you are right about the timing.  But it shouldn't be that way.  If it is, then there's a bug.

I'm fully willing to accept there is something else I should be doing driver-wise, but it shoudn't require recompiling the stock distribution kernels.  Otherwise, Linux is not competitive with Microsoft Windows in this regard!

I'll try a recompile and report back.  In the meantime, if anyone else has any ideas, please let me know!

Gopal


----- Original Message ----
From: Lee Revell <rlrevell@joe-job.com>
To: Open Source <opensource3141@yahoo.com>
Cc: linux-usb-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
Sent: Thursday, October 12, 2006 1:19:12 PM
Subject: Re: USB performance bug since kernel 2.6.13 (CRITICAL???)

On Thu, 2006-10-12 at 13:05 -0700, Open Source wrote:
> Hi,
> 
> Thanks for the rapid response!  But...I'm a bit confused.  Why is there any software OS timer involved at all?  Bulk messages should be scheduled by the host controller and for USB 2.0 the microframe period is 125 us.  When I submit an URB, it should be sent to the host controller and scheduled for the next microframe.  When the URB completes I should get an interrupt from the hardware.  Hence, my transactions (WRITE followed by READ) should at worst be approximately 250 us plus some overhead to process the transaction itself, provided there aren't any other time consuming processes running on my OS.  My overhead is less than 250 us.  I was willing to tolerate 1 ms per transaction, but 4 ms just doesn't make any sense.  Therefore I'm not sure if CONFIG_HZ is an appropriate excuse for this issue.
> 

I don't know, it just seemed likely because 1ms vs 4ms is close to the
change in the timer tick rate.  Try it.

Lee






