Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261556AbSIXEwT>; Tue, 24 Sep 2002 00:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261557AbSIXEwS>; Tue, 24 Sep 2002 00:52:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26890 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261556AbSIXEwR>;
	Tue, 24 Sep 2002 00:52:17 -0400
Message-ID: <3D8FF09A.9070502@pobox.com>
Date: Tue, 24 Sep 2002 00:56:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)
Content-Type: multipart/mixed;
 boundary="------------030000030007060200080309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030000030007060200080309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


--------------030000030007060200080309
Content-Type: message/rfc822;
 name="Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)"

Message-ID: <3D8FF040.2040905@pobox.com>
Date: Tue, 24 Sep 2002 00:55:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry Kessler <kessler@us.ibm.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, 
 Rusty Russell <rusty@rustcorp.com.au>,
  linux-kernel@us.ibm.com,  mailing@us.ibm.com,  list@us.ibm.com
Subject: Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)
References: <3D8FC601.80BAC684@us.ibm.com> <3D8FD0A9.1010906@pobox.com> <3D8FE876.EC1B050C@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Larry Kessler wrote:
> Jeff Garzik wrote:
> 
>>>      }
>>>      if (!request_mem_region(pci_resource_start(pdev, 0),
>>>                      pci_resource_len(pdev, 0), "eepro100")) {
>>>-             printk (KERN_ERR "eepro100: cannot reserve MMIO region\n");
>>>+             pci_problem(LOG_ERR, pdev, "eepro100: cannot reserve MMIO region");
>>
>>bloat, no advantage over printk
> 
> 
> the advantage is that the string, which means plenty to the developer, but possibly
> much less to a Sys Admin, can be replaced with a more descriptive message,
> in the local language, by editing the formatting template in user-space.

So, a static string passed to printk can't be translated, but a static 
string passed to pci_problem() can?

And in your view is it impossible to deduce a format string from the 
current code?


> 
> 
>>>              if (sum != 0xBABA)
>>>-                     printk(KERN_WARNING "%s: Invalid EEPROM checksum %#4.4x, "
>>>-                                "check settings before activating this device!\n",
>>>-                                dev->name, sum);
>>>+                     net_pci_problem(LOG_WARNING, dev, pdev, "Invalid EEPROM checksum, "
>>>+                                "check settings before activating this device!",
>>
>>>+                                detail(checksum, "%#4.4x", sum));
>>
>>bloat, checksum is purely informational, and can be obtained through
>>other means
> 
> 
> indeed.  See previous comment.


indeed :)

And for thinking outside the box, here's a random idea:  when 
CONFIG_EVLOG is defined, printk() turns into a tagged format that spits 
out its format string, then a list of variable names and values.  Given 
some C and cpp magic, that should be possible with no code changes at 
all to drivers.

An overriding objection to all this need of information.  It is so wrong 
to decide to just continuing dump all information available, and hope 
that it will become useful.  Decide which information is useful first...

Do you guys even have an idea what diagnostic info is useful from 
network drivers?  from SCSI drivers?  If yes, speak up.  I would love to 
improve the diagnostics of my net drivers where possible.  If not... 
please figure out the problem before implementing a solution.

	Jeff



--------------030000030007060200080309--

