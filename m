Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263199AbTCSXo6>; Wed, 19 Mar 2003 18:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263205AbTCSXo6>; Wed, 19 Mar 2003 18:44:58 -0500
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:36356 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP
	id <S263199AbTCSXo4>; Wed, 19 Mar 2003 18:44:56 -0500
Message-ID: <3E7903A3.2000906@torque.net>
Date: Thu, 20 Mar 2003 09:56:19 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rml@tech9.net
Subject: Re: [patch] scsi-sysfs bug fix
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
 > drivers/scsi/scsi_sysfs.c :: store_rescan_field() calls
 > scsi_rescan_device() without a prototype, and thus results
 > in a compiler warning.
 >
 > Fix that up by adding the prototype to scsi.h, where it belongs.

 > But then we see we are storing the return value of a void function
 > (so that is why ANSI C is good)... so fix that up, too, by setting
 > the return value to zero if a valid device was found.  Otherwise,
 > return ENODEV as before.
 >
 > Patch is against 2.5.65.

Christoph Hellwig sent a patch for this to the linux-scsi
list. Both patches have the same minor problem. Sysfs
store() callbacks are supposed to return the count of
bytes consumed. It's a moot point in this case since there
is no sscanf() processing. To use this code I can get
to the appropriate sysfs directory and write:
   # echo "anything_I_like" > rescan

So are all bytes in that string consumed? If so the "ret = 0;"
line in your patch should be "ret = count;".

Doug Gilbert

