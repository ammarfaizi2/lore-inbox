Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268522AbTGISbb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266084AbTGISba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:31:30 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:26102 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S268504AbTGISb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:31:27 -0400
Message-ID: <3F0C6288.4030502@mvista.com>
Date: Wed, 09 Jul 2003 11:44:24 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: interesting problem with priorities and /sbin/hotplug
References: <42050DF556283A4D977B111EB70632080DD9B5@orsmsx407.jf.intel.com> <pan.2003.07.03.17.05.54.578748@kroah.com> <3F0C5E3D.1090402@mvista.com> <20030709183435.GA17969@kroah.com>
In-Reply-To: <20030709183435.GA17969@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote:

>On Wed, Jul 09, 2003 at 11:26:05AM -0700, Steven Dake wrote:
>  
>
>>Greg,
>>
>>We found a small problem with the scheduler with our Linux 2.4 O1 
>>backport in that a certain kernel process, keventd, would create a 
>>priority inversion.  If a process was run at realtime priority level 99, 
>>keventd would never run.  The keventd process is required for the 
>>console, creating the appearance that the system had stopped responding.
>>
>>This problem started me thinking about priority inversions with 
>>/sbin/hotplug.  I wanted to get your thoughts about priority inversion 
>>impact on /sbin/hotplug.  Should /sbin/hotplug run at priority level 99 
>>realtime?
>>    
>>
>
>I don't know, why would that help anything out?  How would there be a
>priority inversion in the existing code?
>  
>
I'm not sure if there is a problem, but one example to consider is the 
following:

If a process is running with realtime priority 99 totally consuming the 
system, and an /sbin/hotplug process is started by the kernel because of 
a device insert or remove, /sbin/hotplug will never be scheduled if it 
runs with standard priority. If that service depends on those hotplug 
events, it will never see them (even though they have occured). Since 
I'm no scheduler expert, I don't know if this is actually how the system 
would behave.... I do know that it would be desireable to have 
/sbin/hotplug always run even if other processes in the system are 
running in realtime priority....



