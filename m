Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUDZRFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUDZRFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 13:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbUDZRFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 13:05:34 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:46478 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S263040AbUDZRFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 13:05:25 -0400
Message-ID: <408D4187.2040104@tmr.com>
Date: Mon, 26 Apr 2004 13:06:15 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "E. Oltmanns" <oltmanns@uni-bonn.de>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops during usb usage (2.6.5)
References: <20040423205617.GA1798@local> <20040424003013.GA13631@kroah.com>
In-Reply-To: <20040424003013.GA13631@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Apr 23, 2004 at 10:56:17PM +0200, E. Oltmanns wrote:
> 
>>Hello everyone,
>>
>>Summary:
>>Kernel Oops caused by multiple access requests to a single scanner
>>through libusb.
>>
>>Detailed description:
>>The following script leads to an kernel oops on my System:
>>#!/bin/bash
>>scanimage > test &
>>scanimage -h
>>
>>This is because scanimage -h tries to append a list of availlable
>>scanners to the help output and thus interferes with the first
>>scanimage process which is initializing the scanner at the same
>>moment.
> 
> 
> Heh, then don't do that :)
> 
> Accesses by two different processes of the same device through usbfs is
> big trouble.  Don't do that.
> 
> That being said, I have some usbfs locking patches that might help a bit
> here that will probably show up in the next -mm release if you want to
> see if that helps you out or not.

Just in general, if there is anything a non-root user can do to crash 
the system, it's probably a kernel bug by definition. It doesn't matter 
that's it a stupid thing to do, it might be malicious. And in this case 
it might just be user error.

Glad someone is working on locking, bozos and evil-doers abound ;-)

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
