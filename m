Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTLIKzO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 05:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbTLIKzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 05:55:10 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:8455 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262186AbTLIKxc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 05:53:32 -0500
Message-ID: <3FD5AB6C.3040008@aitel.hist.no>
Date: Tue, 09 Dec 2003 12:01:00 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com> <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org> <20031209075619.GA1698@kroah.com> <1070960433.869.77.camel@nomade> <20031209090815.GA2681@kroah.com> <buoiskqfivq.fsf@mcspd15.ucom.lsi.nec.co.jp> <yw1xd6ayib3f.fsf@kth.se>
In-Reply-To: <yw1xd6ayib3f.fsf@kth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> Miles Bader <miles@lsi.nec.co.jp> writes:
> 
> 
>>>>>  A:  That is correct.  If you really require this functionality, then
>>>>>      use devfs.  There is no way that udev can support this, and it
>>>>>      never will.
>>>>
>>>>That's something I don't understand: I thought that with a well
>>>>configured hotplug+udev system, you'll never have to worry about loading
>>>>drivers on device-node open() because all drivers should be auto-loaded
>>>>and all device-nodes should be auto-created.
>>>
>>>No, you are correct.  That's why I'm not really worried about this, and
>>>I don't think anyone else should be either.
>>
>>Is there a specific case for which people want this feature?
>>Offhand it seems like a slightly odd thing to ask for...
> 
> 
> I believe the original motivation for module autoloading was to save
> memory by unloading modules when their devices were unused.  Loading
> them automatically on demand made for less trouble for users, who
> didn't have to run modprobe manually to use the sound card, or
> whatever.  This could still be a good thing in embedded systems.
> 

Sure.  

And if you want to run this way with udev, set it up so device nodes
don't get deleted when the device unloads.  That way you keep
device nodes for your driverless devices, and when you try to open
them the kernel runs modprobe for you.  Devfs isn't needed for that
afaik, it is only needed for modprobing devices that doesn't have
a /dev entry yet.

Your /dev will contain nodes both for driven and non-driven
devices, but not for devices you don't have at all.

Helge Hafting

