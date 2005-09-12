Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVILJA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVILJA3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVILJA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:00:28 -0400
Received: from zorg.st.net.au ([203.16.233.9]:49118 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S1751249AbVILJA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:00:28 -0400
Message-ID: <432543C6.1020403@torque.net>
Date: Mon, 12 Sep 2005 19:00:54 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 2/14] sas-class: README
References: <4321E4DD.7070405@adaptec.com>
In-Reply-To: <4321E4DD.7070405@adaptec.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:

<snip>

> +
> +DISCOVERY
> +---------
> +
> +The sysfs tree has the following purposes:
> +    a) It shows you the physical layout of the SAS domain at
> +       the current time, i.e. how the domain looks in the
> +       physical world right now.
> +    b) Shows some device parameters _at_discovery_time_.
> +
> +This is a link to the tree(1) program, very useful in
> +viewing the SAS domain:
> +ftp://mama.indstate.edu/linux/tree/
> +I expect user space applications to actually create a
> +graphical interface of this.
> +
> +That is, the sysfs domain tree doesn't show or keep state if
> +you e.g., change the meaning of the READY LED MEANING
> +setting, but it does show you the current connection status
> +of the domain device.

So in that case, user applications should ignore READY
LED MEANING in sysfs and ask the device directly.
For example:
    sdparm --get RLM --transport sas /dev/sda

> +Keeping internal device state changes is responsibility of
> +upper layers (Command set drivers) and user space.

... and what about multiple initiators sitting on different
machines? Should they be responsible for:
  1) finding out about one another
  2) and keeping the sysfs tree in the other machine
     in sync when one changes READY LED MEANING
     (or anything else)?

Putting distributed state information in sysfs and then
passing off the responsibility for maintaining its state
(because it is a difficult problem) brings into question
the wisdom of the strategy.


Doug Gilbert
