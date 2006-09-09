Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWIISEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWIISEM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 14:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWIISEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 14:04:12 -0400
Received: from mout0.freenet.de ([194.97.50.131]:5301 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1751349AbWIISEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 14:04:10 -0400
Date: Sat, 09 Sep 2006 20:11:56 +0200
To: "Greg KH" <greg@kroah.com>, "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: [PATCH] pktcdvd: added sysfs interface + bio write queue handling fix
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Cc: linux-kernel@vger.kernel.org, "petero2@telia.com" <petero2@telia.com>
Content-Type: text/plain; charset=iso-8859-15
MIME-Version: 1.0
References: <op.tfkmp60biudtyh@master> <20060908210042.GA6877@kroah.com> <4501E33B.50204@cfl.rr.com> <20060908220129.GB20018@kroah.com>
Content-Transfer-Encoding: 7bit
Message-ID: <op.tfmh56j9iudtyh@master>
In-Reply-To: <20060908220129.GB20018@kroah.com>
User-Agent: Opera Mail/9.00 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>> +    write_queue_size  (r)  Contains the size of the bio write
>> +                           queue.
...
>> +    mapped_to              Symbolic link to mapped block device
>> +                           in the /sys/block tree.
>
> Shouldn't this whole thing be in /sys/class/ instead of /sys/block/ ?

Don't know. I thought, the pktcdvd is a block driver, so put
the control files into /sys/block ..
Is /sys/class better? If yes, where to put it?

> On Fri, Sep 08, 2006 at 05:40:11PM -0400, Phillip Susi wrote:
>> Greg KH wrote:
>> >On Fri, Sep 08, 2006 at 07:55:08PM +0200, Thomas Maier wrote:
>> >>+/sys/block/pktcdvd/<pktdevname>/packet/
>> >>+    statistic         (r)  Show device statistic. One line with
>> >>+                           5 values in following order:
>> >>+                              packets-started
>> >>+                              packets-end
>> >>+                              written in kB
>> >>+                              read gather in kB
>> >>+                              read in kB
>> >
>> >Please no.  One value per file is the sysfs rule.
>> >
>>
>> Except in cases like this where you want to read the status of the
>> device at a given point in time, and you can't do that unless you grab
>> all the values at once.
>
> Then don't use sysfs for that.  And is something like this as critical
> to get that kind of information all in one atomic chunk?  It seems
> merely to be informational.

The "statistic" and "info" files are only for information purpose.
Into /proc ? No. (i read somewhere /proc should only contain process
information in future)
In debugfs? Hmm, this files should be infos that users should be able
to read, no debug output.

Is it ok, if i split the "statistic" into 5 files, and put the "info"
into debugfs ?

-Thomas Maier
