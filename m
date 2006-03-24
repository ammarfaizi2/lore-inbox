Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWCXPhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWCXPhf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWCXPhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:37:35 -0500
Received: from mail.sw-soft.com ([69.64.46.34]:59559 "EHLO mail.sw-soft.com")
	by vger.kernel.org with ESMTP id S1751031AbWCXPhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:37:34 -0500
Message-ID: <44241224.9000200@sw.ru>
Date: Fri, 24 Mar 2006 18:37:08 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Dave Hansen <haveblue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>,
       OpenVZ developers list <dev@openvz.org>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
References: <20060321061333.27638.63963.stgit@localhost.localdomain>	<1142967011.10906.185.camel@localhost.localdomain> <m1k6anq8uq.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1k6anq8uq.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Do-Not-Rej: Toldya
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>> But, I worry that they just aren't generic enough yet.  I don't see any
>> response from any of the other "container/namespace/vps" people.  I fear
>> that this means that they don't look broadly useful enough, yet.
> 
> Not broadly useful is certainly my impression.
> It feels to me like these patches are simply doing too much.
Exactly!
These patches are really too big and can't be called clean... naming,
bunch of debug etc. I can post the same amount of OpenVZ stuf and
Herbert will claim his code is more clear after that.
Also these patches contradict to what was discussed before: different
name spaces for each subsystem.

>> That said, at this point, I'd just about rather have _anything_ merged
>> than the nothing we have at this point.  As we throw patches back and
>> forth, we can't seem to agree on even some very small points.  
>>
>> I also have a sinking feeling that everybody has gone back off and
>> continues to develop their own out-of-tree functionality, deepening the
>> patch divide.

> I certainly have not.  I do feel that developing this just from the
> top down is the wrong way to do this.  In some of the preliminary
> patches we have found several pieces of code that we will have to
> touch that is currently in need of a cleanup.  That is why I have
> been cleaning up /proc.  sysctl is in need of similar treatment
> but is in less bad shape.
Eric, though I suggest to postpone proc and sysctl a bit, can you share
me your vision of /proc and /sysctl virtualization a bit?
A good way to handle them IMHO is to make fully virtual, i.e. each
namespace should have an own set of sysctl or proc tree.

> Part of it is that I have stopped to look more closely at what
> other people are doing and to look at alternative implementations.
If you need any help with it in OpenVZ, feel free to ask. We have
broken-out patches for recent 2.6.16 kernel.

> One interesting thing I have manged to do is by using ptrace I
> have implemented enter for the existing filesystem namespaces 
> without having to modify the kernel.  This at least says
> that enter and debugging are two faces of the same coin.
Hmmm, strange claim/conclusion... /dev/kmem allows to change namespaces
also :) and even to obtain root priviliges if needed... :)

>> Is there anything we could merge that we _all_ don't like?  I'm pretty
>> convinced that no single solution will support Eric's, OpenVZ's, and
>> VServer's _existing_ usage models.  Somebody is going to have to bend,
>> or nothing will ever get merged.  Any volunteers? ;)
> 
> I don't think that is the case on the fundamentals.  I think with pids
> I am an inch away from implementing a pid namespace that is both
> recursive, efficient, and can map all of the pids into another pid
> space if that is desirable.  Plus I can merge most of it incrementally
> in the existing kernel, before I even allow for multiple pid spaces.
Eric, let's not compare approaches with inches :)
As you remember your PID namespaces doesn't suite us well... :(

Thanks,
Kirill

