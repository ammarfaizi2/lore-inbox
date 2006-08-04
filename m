Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbWHDHTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbWHDHTr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWHDHTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:19:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:9938 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161079AbWHDHTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:19:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E3PEUgBFx40gCC3TiJmTYzB9/vQjOeWOELPDaN/lT6H0aLb5hTNRdA+Jd5nojs6P0j3eGfrEXwa3rnYsqPjl1YcB4+UrSMF44/etjRsj9as1Iaste2fMtlEqXjdj9Sv4urslUnYQbfvSpW9RyfCFMk6ERVZw3+zpPg9TUqUqiNY=
Message-ID: <69304d110608040019i2f68518dq4e84a96a8787b0eb@mail.gmail.com>
Date: Fri, 4 Aug 2006 09:19:44 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Chris Wright" <chrisw@sous-sol.org>, "Andrew Morton" <akpm@osdl.org>,
       "Jeremy Fitzhardinge" <jeremy@xensource.com>, greg@kroah.com,
       zach@vmware.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       hch@infradead.org, rusty@rustcorp.com.au, jlo@vmware.com,
       xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
Subject: Re: A proposal - binary
In-Reply-To: <20060804070142.GW2654@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
	 <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
	 <44D2B678.6060400@xensource.com>
	 <20060803211850.3a01d0cc.akpm@osdl.org>
	 <20060804054002.GC11244@sequoia.sous-sol.org>
	 <69304d110608032328r36bc0a6ase0a2dbf36d8cc519@mail.gmail.com>
	 <20060804070142.GW2654@sequoia.sous-sol.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/06, Chris Wright <chrisw@sous-sol.org> wrote:
> * Antonio Vargas (windenntw@gmail.com) wrote:
> > One feature I found missing at the paravirt patches is to allow the
> > user to forbid the use of paravirtualization of certain features (via
> > a bitmask on the kernel commandline for example) so that the execution
> > drops into the native hardware virtualization system. Such a feature
>
> There is no native harware virtualization system in this picture.  Maybe
> I'm just misunderstanding you.

What I was refering with "native hardware virtualization" is just the
VT or Pacitifica -provided trapping into the hypervisor upon executing
"dangerous" instructions such as tlb-flushes, reading/setting the
current ring-level, cli/sti...

> > would provide a big upwards compatibility for the kernel<->hypervisor
> > system. The case for this would be needing to forcefully upgrade the
> > hypervisor due to security issues and finding out that the hypervisor
> > is  incompatible at the paravirtualizatrion level, then the user would
> > be at least capable of continuing to run the old kernel with the new
> > hypervisor until the compatibility is reached again.
>
> This seems a bit like a trumped up example, as randomly disabling a part
> of the pv interface is likely to cause correctness issues, not just
> performance degradation.

Yes, maybe just providing a switch to force paravirtops to use the
native hardware implementation would be enough, or just in case,
making the default the native hardware and allowing the kernel
commandline to select another one (just like on io-schedulers)

> Hypervisor compatibility is a slightly separate issue here.  There's two
> interfaces.  The linux paravirt interface is internal to the kernel.
> The hypervisor interface is external to the kernel.
>
> kernel <--pv interface--> paravirt glue layer <--hv interface--> hypervisor
>
> So changes to the hypervisor must remain ABI compatible to continue
> working with the same kernel.  This is the same requirement the kernel
> has with the syscall interface it provides to userspace.

Yes. What I propose is allowing the systems to continue running (only
with degraded performance) when the hv-interface between the running
kernel and the running hypervisor doesn't match.

> > BTW, what is the recommended distro or kernel setup to help testing
> > the latest paravirt patches? I've got a spare machine (with no needed
> > data) at hand which could be put to good use.
>
> Distro of choice.  Current kernel with the pv patches[1], but be
> forewarned, they are very early, and not fully booting.

Thanks, will be setting it up :)

-- 
Greetz, Antonio Vargas aka winden of network
