Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269793AbUINUps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269793AbUINUps (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269796AbUINUol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:44:41 -0400
Received: from [195.190.190.7] ([195.190.190.7]:18860 "EHLO mail.pixelized.ch")
	by vger.kernel.org with ESMTP id S269800AbUINUny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:43:54 -0400
Message-ID: <414757FD.5050209@pixelized.ch>
Date: Tue, 14 Sep 2004 22:43:41 +0200
From: "Giacomo A. Catenazzi" <cate@pixelized.ch>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Chris Friesen <cfriesen@nortelnetworks.com>,
       "Giacomo A. Catenazzi" <cate@debian.org>, linux-kernel@vger.kernel.org,
       Tigran Aivazian <tigran@veritas.com>, md@Linux.IT
Subject: Re: udev is too slow creating devices
References: <41473972.8010104@debian.org> <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com>
In-Reply-To: <20040914195221.GA21691@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Sep 14, 2004 at 01:40:22PM -0600, Chris Friesen wrote:
> 
>>Giacomo A. Catenazzi wrote:
>>
>>
>>>udev + modular microcode:
>>>$ modprobe -r microcode
>>>$ modprobe microcode ; microcode_ctl -u
>>>=> microcode_ctl does NOT find the device
>>
>>The loading of the module triggers udev to run.  There is no guarantee that 
>>udev runs before microcode_ctl.
>>
>>One workaround would be to have microcode_ctl use dnotify to get woken up 
>>whenever /dev changes.
> 
> 
> Ick, no.  Use the /etc/dev.d/ notify method I described.  That is what
> it is there for.
> 

After a brief discussion with debian udev maintainer, I've an
other proposal/opinion.

The "bug" appear only in two places: at udev start and after
a modprobe, so IMHO we should correct these two place, so that:
- from a user side perspective it is the right thing!
   (after a successful modprobe, I expect module and devices
    are created sussesfully)
- there are not many special case:
   with udev use dev.d, else do actions now!

Else every distribution should create a script for
every init.d script that would eventually use (also
indirectly) a kernel module.

ciao
	cate
