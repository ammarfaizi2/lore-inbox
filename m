Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVAEGxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVAEGxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 01:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVAEGxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 01:53:22 -0500
Received: from pri-dns2.mtco.com ([207.179.200.252]:26587 "HELO
	pri-dns2.mtco.com") by vger.kernel.org with SMTP id S261722AbVAEGxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 01:53:13 -0500
From: Tom Felker <tfelker2@uiuc.edu>
To: "tony osborne" <tonyosborne_a@hotmail.com>
Subject: Re: Main CPU- I/O CPU interaction
Date: Wed, 5 Jan 2005 00:53:13 -0600
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <BAY14-F83B94FD7D13C5D19883F795900@phx.gbl>
In-Reply-To: <BAY14-F83B94FD7D13C5D19883F795900@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501050053.13744.tfelker2@uiuc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 January 2005 06:44 pm, tony osborne wrote:
> Hello,
>
> I wish to be personally CC'ed the answers/comments posted to the list in
> response to this post .
>
>
> The I/O devices are equipped with dedicated processor to free the  main CPU
> from doing the low level I/O operations. However, if i am editing and
> updating a big size file and i want to save
> it afterwards, i  notice my PC getting blocked while saving the file which
> theoritically should NOT happen as it is up to the I/O device processor and
> not the main CPU to save the data into the disk; the main CPU could switch
> to another process after giving the high level command -save-to the device
> processor; so why the main CPU is blocked while saving such big size files
>
> thanks

Check to make sure DMA is on:

hdparm /dev/hda

If not, try turning it on:

hdparm -d 1 /dev/hda

When it's not on, you'll get bad performance (I usually get around 2 MB/s 
according to "hdparm -t /dev/hda") and high system CPU usage.  Because the 
rate is so low, for big files, the high CPU usage starves other processes for 
long enough that you notice.  With DMA, the transfer will be much faster and 
the CPU usage will be minimal.

-- 
Tom Felker, <tcfelker@mtco.com>
<http://vlevel.sourceforge.net> - Stop fiddling with the volume knob.

If nature has made any one thing less susceptible than all others of exclusive 
property, it is the action of the thinking power called an idea.
