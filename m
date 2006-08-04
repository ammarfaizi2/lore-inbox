Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161370AbWHDTJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161370AbWHDTJy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161373AbWHDTJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:09:53 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:11768 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1161370AbWHDTJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:09:53 -0400
Date: Fri, 4 Aug 2006 12:06:28 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Antonio Vargas <windenntw@gmail.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
Subject: Re: A proposal - binary
In-Reply-To: <69304d110608041146t44077033j9a10ae6aee19a16d@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0608041150360.18862@qynat.qvtvafvgr.pbz>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
  <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com> 
 <44D2B678.6060400@xensource.com> <20060803211850.3a01d0cc.akpm@osdl.org> 
 <1154667875.11382.37.camel@localhost.localdomain>  <20060803225357.e9ab5de1.akpm@osdl.org>
  <1154675100.11382.47.camel@localhost.localdomain> 
 <Pine.LNX.4.63.0608040944480.18902@qynat.qvtvafvgr.pbz>
 <69304d110608041146t44077033j9a10ae6aee19a16d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006, Antonio Vargas wrote:

>> If there's going to be long-term compatability between different hosts and
>> guests there need some limits to what can change.
>> 
>> needing to uprev the host when you uprev a guest is acceptable
>> 
>> needing to uprev a guest when you uprev a host is not.
>
> Now, allowing this transparent acting is great since you can run your
> normal kernel as-is as a guest. But to get close to 100% speed, what
> you do is to rewrite parts of the OS to be aware of the hypervisor,
> and stablish a common way to talk.

I understand this, but for example a UML 2.6.10 kernel will continue to run 
unmodified on top of a 2.6.17 kernel, the ABI used is stable. however if you 
have a 2.6.10 host with a 2.6.10 UML guest and want to run a 2.6.17 guest you 
may (but not nessasarily must) have to upgrade the host to 2.6.17 or later.

> Thus happens the work with the paravirt-ops. Just like you can use any
> filesystem under linux because they have a well-defined intrface to
> the rest of the kernel, the paravirt-ops are the way we are wrking to
> define an interface so that the rest of the kernel can be ignorant to
> whether it's running on the bare metal or as a guest.
>
> Then, if you needed to run say 2.6.19 with hypervisor A-1.0, you just
> need to write paravirt-ops which talk and translate between 2.6.19 and
> A-1.0. If 5 years later you are still running A-1.0 and want to run a
> 2.6.28 guest, then you would just need to write the paravirt-ops
> between 2.6.28 and A-1.0, with no need to modify the rest of the code
> or the hypervisor.

who is going to be writing all these interface layers to connect each kernel 
version to each hypervisor version. and please note, I am not just considering 
Xen and vmware as hypervisors, a vanilla linux kernel is the hypervisor for UML. 
so just stating that the hypervisor maintainers need to do this is implying that 
the kernel maintainers would be required to do this.

also I'm looking at the more likly case that 5 years from now you may still be 
runnint 2.6.19, but need to upgrade to hypervisor A-5.8 (to support a different 
client). you don't want to have to try and recompile the 2.6.19 kernel to keep 
useing it.

> At the moment we only have 1 GPL hypervisor and 1 binary one. Then
> maybe it's needed to define if linux should help run under binary
> hypervisors, but imagine instead of this one, we had the usual Ghyper
> vs Khyper separation. We would prefer to give the same adaptations to
> both of them and abstract them away just like we do with filesystems.

you have three hypervisors that I know of. Linux, Xen (multiple versions) , and 
VMware. each with (mostly) incompatable guests

>> this basicly boils down to 'once you expose an interface to a user it can't
>> change', with the interface that's being exposed being the calls that the 
>> guest
>> makes to the host.
>
> Yes, that's the reason some mentioned ppc, sparc, s390... because they
> have been doing this longer than us and we could consider adopting
> some of their designs (just like we did for POSIX system calls ;)

I'm not commenting on any of the specifics of the interface calls (I trust you 
guys to make that be sane :-) I'm just responding the the idea that the 
interface actually needs to be locked down to an ABI as opposed to just 
source-level compatability.

David Lang
