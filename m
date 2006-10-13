Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWJMRUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWJMRUr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWJMRUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:20:47 -0400
Received: from web58113.mail.re3.yahoo.com ([68.142.236.136]:46213 "HELO
	web58113.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1751432AbWJMRUq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:20:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=IkTxI3RFEbGV94/6Kuv7avUA/wBf0N6sWCWbMxa7rmNr1KpXPvWwUfb8HHNjB+/g6PWgG4pK0v8kwgMfH2w0W+2sqFy5by6PpgsJ7bqm9p5fNHNzbW8CtiagrR/YpwIzdrrezz4AGgAXMdlouXwTRRGgy2kHY60zfxy1c8GHdVQ=  ;
Message-ID: <20061013172042.21215.qmail@web58113.mail.re3.yahoo.com>
Date: Fri, 13 Oct 2006 10:20:42 -0700 (PDT)
From: Open Source <opensource3141@yahoo.com>
Subject: Re: [linux-usb-devel] USB performance bug since kernel 2.6.13 (CRITICAL???)
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just tested using CONFIG_HZ_1000=y and
CONFIG_HZ=1000 and as expected, this change
improves the throughput.  Thank you Lee for pointing
that out so quickly.

Alan -- yes, I understand the ability to increase throughput
by transfering more bytes and I am definitely able to see
better overall throughput when increasing the number
of bytes per transaction.  However, I needs to still have
good transaction-level timing because I cannot always
queue the transactions up.  Recall that each transaction
is a WRITE followed by a READ.  The results of the
READ determine the outgoing bytes for the following
transaction's WRITE.

Not to sound like a broken record, but there is something
seriously wrong here.  This has to be a bug somewhere.
It could be very well just be something as simple as
issuing the right incantation with libusb, devio, etc.  But,
I've been using libusb for years now and am at a loss
on what might have changed to require this.

Any ideas???


Best regards.


p.s. My apologies about the word wrap.  I'm using
a different mail client than my usual one and didn't
realize it was not wrapping automatically.


----- Original Message ----
From: Alan Stern <stern@rowland.harvard.edu>
To: Open Source <opensource3141@yahoo.com>
Cc: linux-usb-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
Sent: Friday, October 13, 2006 6:56:31 AM
Subject: Re: [linux-usb-devel] USB performance bug since kernel 2.6.13 (CRITICAL???)

[FYI, it would make things easier for the rest of us if you can convince 
your email client to wrap lines before 80 columns.]

I'll be interested to here if changing HZ back to 1000 makes any 
difference.  As others have already stated, it shouldn't matter but maybe 
it does somehow.

Even if it does, there are things you might be able to do with HZ=250 to 
improve throughput.  You could transfer more than 512/1024 bytes per URB.  
You could queue multiple URBs before waiting for the first one to 
complete.  Provided you can keep the endpoint queues filled, you should be 
able to achieve the maximum throughput of the hardware.

Alan Stern








