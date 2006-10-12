Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWJLUF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWJLUF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWJLUF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:05:28 -0400
Received: from web58107.mail.re3.yahoo.com ([68.142.236.130]:62100 "HELO
	web58107.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1750951AbWJLUF1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:05:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VgDsUVgOzIcg8iK2kEEYF4wcJ6zsEKf+cDtf2GjsSUXwgF8V76tLd8DkskXkHSJuuexdxg4BMjwnEJulpbPI3JoghtARqFsCxtiulm1asj/S5VPvCuKzHCCNicCjtXjN9mfm9+KQqh+QsmhA4fLMRDmkBr/QJ+0DAa/Mt5Ti7XM=  ;
Message-ID: <20061012200527.14579.qmail@web58107.mail.re3.yahoo.com>
Date: Thu, 12 Oct 2006 13:05:27 -0700 (PDT)
From: Open Source <opensource3141@yahoo.com>
Subject: Re: USB performance bug since kernel 2.6.13 (CRITICAL???)
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the rapid response!  But...I'm a bit confused.  Why is there any software OS timer involved at all?  Bulk messages should be scheduled by the host controller and for USB 2.0 the microframe period is 125 us.  When I submit an URB, it should be sent to the host controller and scheduled for the next microframe.  When the URB completes I should get an interrupt from the hardware.  Hence, my transactions (WRITE followed by READ) should at worst be approximately 250 us plus some overhead to process the transaction itself, provided there aren't any other time consuming processes running on my OS.  My overhead is less than 250 us.  I was willing to tolerate 1 ms per transaction, but 4 ms just doesn't make any sense.  Therefore I'm not sure if CONFIG_HZ is an appropriate excuse for this issue.

Besides, Windows is now more than twice as fast out of the box than Linux when it comes to this particular type of USB usage.  We can't have that can we? :-)  Linux used to be fast and the only difference with my recent experiences is the kernel version.

Best regards,
Still Beleagered Open Source Fan


----- Original Message ----
From: Lee Revell <rlrevell@joe-job.com>
To: Open Source <opensource3141@yahoo.com>
Cc: linux-usb-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
Sent: Thursday, October 12, 2006 12:55:55 PM
Subject: Re: USB performance bug since kernel 2.6.13 (CRITICAL???)

On Thu, 2006-10-12 at 12:33 -0700, Open Source wrote:
> I am using a device that submits URBs asynchronously using the libusb
> devio infrastructure.  In version 2.6.12 I am able to submit and reap
> URBs for my particular application at a transaction rate of one per
> millisecond.  A transaction consists of a single WRITE URB (< 512
> bytes) followed by a single READ URB (1024 bytes).  Once I upgrade to
> version 2.6.13, the transactional rate drops to one per 4
> milliseconds!

The kernel's internal tick rate was lowered from 1000Hz to 250Hz
starting with 2.6.13.  Rebuild with CONFIG_HZ=1000 and the performance
should return to normal.

Lee






