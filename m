Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbULPUFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbULPUFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 15:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbULPUFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 15:05:05 -0500
Received: from mail.tmr.com ([216.238.38.203]:63249 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261879AbULPUE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 15:04:58 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: CD and 2.6 - more data fewer answers
Date: Thu, 16 Dec 2004 15:06:16 -0500
Organization: TMR Associates, Inc
Message-ID: <cpsp7f$mve$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1103226928 23534 192.168.12.100 (16 Dec 2004 19:55:28 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 2.6.7-rc1-mm1 test system with both IDE CD and USB CD-R. Both 
work fine as I normally use them, the CD-R is my primary backup device.

With all the discussion of DMA or not DMA, I decided to try some 
reads... I tried readcd using /dev/hdc and the user was 60%, sys 40%, no 
idle. Using ATAPI:0,0,0 I saw user 60%, sys 2% idle 38%. Then using the 
USB device I saw user 4%, sys 9%, idle 12%, wio 75%. The USB is much 
faster, so this looked right, and it appeared that on data reads DMA was 
being used. I have no idea where all the user CPU was going.

Then I turned on -c2scan to read 2352 byte sectors without the final 
error correct. With /dev/hdc I saw use 42%, sys 68%. Using ATAPI:0,0,0 I 
saw user 47%, sys 53%. And using the USB device the c2scan ended without 
reading any data.

The difference between /dev/hdc and ATAPI:0,0,0 is small, although 
consistent. The access by SCSI number failed with the USB drive, and 
/dev/scd0 resulted in "readcd: Invalid argument. Cannot get SCSI I/O 
buffer" when tried (yes, as root as well).

I make no claim that this sheds light on the question, just a sprinkle 
of data to provide flavor. I'll bring in an audio CD tomorrow and see 
what trying to rip that does, unless someone beats me to it.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
