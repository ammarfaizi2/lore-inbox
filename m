Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030493AbVJGRSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbVJGRSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 13:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbVJGRSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 13:18:38 -0400
Received: from zipcon.net ([209.221.136.5]:25480 "HELO zipcon.net")
	by vger.kernel.org with SMTP id S1030493AbVJGRSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 13:18:38 -0400
Message-ID: <4346ADD7.9010604@beezmo.com>
Date: Fri, 07 Oct 2005 10:18:15 -0700
From: William D Waddington <william.waddington@beezmo.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RFClue] pci_get_device, new driver model
References: <43469FB8.50303@beezmo.com> <1128706111.18867.8.camel@localhost.localdomain>
In-Reply-To: <1128706111.18867.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2005-10-07 at 09:18 -0700, William D Waddington wrote:

>>If I just give in to the new driver model how/when do I associate
>>instance/minor numbers with boards found?  Is it ever possible for
>>ordinary PCI boards to be (logically) removed and re-added w/out
>>removing the driver?  If so, how to maintain association between
>>a particular board and minor number?
> 
> 
> Its up to you how you implement this. One requirement I suspect would be
> that the boards have unique serial numbers. Most drivers do not retain
> state if someone unplugs a board, moves it and plugs it back in. Instead
> they report the old device as "gone" and let user space sort it out

I don't have unique serial #s available, but my question wasn't clear.

Is it ever possible that the hotplug stuff will try to remove and re-add
one (or all) of my boards when there _hasn't_ been a physical change or
power cycle/reboot/driver reload/whatever.

As long as the driver gets reloaded following any logical or physical
system change I will just go through the instance/minor assignment
again.  What I don't want is /dev/idr0 /dev/idr1 turning into /dev/idr2
/dev/idr3 because someone tickled the hotplug controls.

Still not quite clear how to assocuiate instance/minor #s with boards.
Do I just keep a global counter and bump it each time probe (or init)
gets called for each board?  Hence my worry above.

Thanks for the quick reply.

Bill (not sure if this will thread OK)
--------------------------------------------
William D Waddington
Bainbridge Island, WA, USA
william.waddington@beezmo.com
--------------------------------------------
"Even bugs...are unexpected signposts on
the long road of creativity..." - Ken Burtch


