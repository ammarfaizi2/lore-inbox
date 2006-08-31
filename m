Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWHaNYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWHaNYu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWHaNYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:24:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:54949 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932264AbWHaNYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:24:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=o9K6zAptZwRXspCkRMBe647BYlxSY2V+NkFW2ebNx+Bu6hx85LkzLVKwoDeSjgYSpBPZfn8FWsLHr29WyLZwgbvdoNt/WqRKQ2m3T9kspm1FeWkQ63DU72txIF/vRPp5xcmaVFdCJXegnOYS/p8/pH/ES++3uXER0fAZuPStSDk=
Message-ID: <44F6E30E.7010501@gmail.com>
Date: Thu, 31 Aug 2006 17:24:30 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
References: <20060830062338.GA10285@kroah.com> <44F5C5E0.4050201@gmail.com> <20060830175250.GA6258@kroah.com> <44F6164F.6000709@gmail.com> <20060831001742.GB26265@kroah.com>
In-Reply-To: <20060831001742.GB26265@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Aug 31, 2006 at 02:50:55AM +0400, Manu Abraham wrote:
>> Greg KH wrote:
>>> On Wed, Aug 30, 2006 at 09:07:44PM +0400, Manu Abraham wrote:
>>>> Being a bit excited and it is really interesting to have such a
>>>> proposal, it would simplify the matters that held us up even more,
>>>> probably. The name sounds fine though. All i was wondering whether there
>>>> would be any high latencies for the same using in such a context. But
>>>> since the transfers would occur in any way, even with a kernel mode
>>>> driver, i think it should be pretty much fine.
>>> As mentioned, this framework is being used in industrial settings right
>>> now, where latencies are a huge issue.  It works just fine, so I do not
>>> think there are any problems in this area.
>> Cool.
>>
>> Is there some way we can avoid the poll ? It would be a real gain
>> indeed, if a POLL can be avoided.
> 
> Use the signal that will be sent to your userspace program when an
> interrupt happens.
> 


Ok, that said, If we had RT signalling, that would have been a quantum leap.


> If you can handle the small latency that causes it should be fine, but
> if you can't, then you should be using poll :)
> 

hmm.. having a choice does always hurt your brain. ;-)


> It all depends on the hardware you are using, your processor, and what
> your tolerances are on your interrupt handling latency.


Usually in the typical application we have (where latency is an issue),
most probably many of the people have a saturated PCI bus. In most
cases, the IPTV guys have such a scenario. Say > 6 or 7 DVB adapters and
the latency goes very high. What i have seen is that when the bus gets
saturated, the CPU usage shoots of rather abnormally. When the latency
goes higher, the resultant stream is useless and packets needs to be
dropped, eventually that results in Transport Stream discontinuities.

Currently we already have a latency issue, based on the loud cries from
some people.

Thanks,
Manu
