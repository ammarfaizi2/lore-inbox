Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWHDSqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWHDSqI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 14:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWHDSqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 14:46:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:32324 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751442AbWHDSqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 14:46:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jNIf/FWL+hd9JlNK9kDtP5jSLa+eMO514NyehQoHk9G3OGgD2Jv52/CfU7w9dtcAA3fkHQx0jGLLvDa3RQY5enlCsIOg3mmUM3GZkwSsNIsCS8pScKHCybcDuCMuP6KtLJRtbSj9IRtZUmojXjUZbmShh1spDLvaa0BSkcg4xY0=
Message-ID: <69304d110608041146t44077033j9a10ae6aee19a16d@mail.gmail.com>
Date: Fri, 4 Aug 2006 20:46:05 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "David Lang" <dlang@digitalinsight.com>,
       "Rusty Russell" <rusty@rustcorp.com.au>,
       "Andrew Morton" <akpm@osdl.org>, jeremy@xensource.com, greg@kroah.com,
       zach@vmware.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       hch@infradead.org, jlo@vmware.com, xen-devel@lists.xensource.com,
       simon@xensource.com, ian.pratt@xensource.com, jeremy@goop.org
Subject: Re: A proposal - binary
In-Reply-To: <Pine.LNX.4.63.0608040944480.18902@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
	 <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
	 <44D2B678.6060400@xensource.com>
	 <20060803211850.3a01d0cc.akpm@osdl.org>
	 <1154667875.11382.37.camel@localhost.localdomain>
	 <20060803225357.e9ab5de1.akpm@osdl.org>
	 <1154675100.11382.47.camel@localhost.localdomain>
	 <Pine.LNX.4.63.0608040944480.18902@qynat.qvtvafvgr.pbz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/06, David Lang <dlang@digitalinsight.com> wrote:
> On Fri, 4 Aug 2006, Rusty Russell wrote:
>
> > On Thu, 2006-08-03 at 22:53 -0700, Andrew Morton wrote:
> >> On Fri, 04 Aug 2006 15:04:35 +1000
> >> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >>
> >>> On Thu, 2006-08-03 at 21:18 -0700, Andrew Morton wrote:
> >>> Everywhere in the kernel where we have multiple implementations we want
> >>> to select at runtime, we use an ops struct.  Why should the choice of
> >>> Xen/VMI/native/other be any different?
> >>
> >> VMI is being proposed as an appropriate way to connect Linux to Xen.  If
> >> that is true then no other glue is needed.
> >
> > Sorry, this is wrong.  VMI was proposed as the appropriate way to
> > connect Linux to Xen, *and* native, *and* VMWare's hypervisors (and
> > others).  This way one Linux binary can boot on all three, using
> > different VMI blobs.
> >
> >>> Yes, we could force native and Xen to work via VMI, but the result would
> >>> be less clear, less maintainable, and gratuitously different from
> >>> elsewhere in the kernel.
> >>
> >> I suspect others would disagree with that.  We're at the stage of needing
> >> to see code to settle this.
> >
> > Wrong again.  We've *seen* the code for VMI, and fairly hairy.  Seeing
> > the native-implementation and Xen-implementation VMI blobs will not make
> > it less hairy!
> >
> >>>  And, of course, unlike paravirt_ops where we
> >>> can change and add ops at any time, we can't similarly change the VMI
> >>> interface because it's an ABI (that's the point: the hypervisor can
> >>> provide the implementation).
> >>
> >> hm.  Dunno.  ABIs can be uprevved.  Perhaps.
> >
> > Certainly VMI can be.  But I'd prefer to leave the excellent hackers at
> > VMWare with the task of maintaining their ABI, and let Linux hackers
> > (most of whom will run native) manipulate paravirt_ops freely.
> >
> > We're not good at maintaining ABIs.  We're going to be especially bad at
> > maintaining an ABI when the 99% of us running native will never notice
> > the breakage.
>
> some questions from a user. pleas point out where I am misunderstanding things.

asking is the smart way :)

> one of the big uses of virtualization will be to run things in sandboxes, when
> people do this they typicaly migrate the sandbox from system to system over time
> (working with chroot sandboxes I've seen some HUGE skews between what's running
> in the sandbox and what's running in the host). If the interface between the
> guest kernel and the hypervisor isn't fixed how could somone run a 2.6.19 guest
> and a 2.6.30 guest at the same time?
>
> if it's only a source-level API this implies that when you move your host kernel
> from 2.6.19 to 2.6.25 you would need to recompile your 2.6.19 guest kernel to
> support the modifications. where are the patches going to come from to do this?
>
> It seems to me from reading this thread that the PowerPC and S390 have a ABI
> defined, specificly defined by the hardware in the case of PowerPC and by the
> externaly maintained, Linux-independant hypervisor (which is effectivly the
> hardware) in the case of the s390.

the trick with ppc, s390, m68k... is that they were defined since day
zero (*simplifies 68000/68010 history here*) so that when you run as
non-priviledged-task and try to execute a priviledged instruction,
then the security acts out and the OS gets control. x86 wasn't since
they had some instructions where the non-priviledged could detect it
was so, thus barring any way of the hypervisor appearing invisible.
this is solved on x86 and x64_64 with the new extensions.

> If there's going to be long-term compatability between different hosts and
> guests there need some limits to what can change.
>
> needing to uprev the host when you uprev a guest is acceptable
>
> needing to uprev a guest when you uprev a host is not.

Now, allowing this transparent acting is great since you can run your
normal kernel as-is as a guest. But to get close to 100% speed, what
you do is to rewrite parts of the OS to be aware of the hypervisor,
and stablish a common way to talk.

Thus happens the work with the paravirt-ops. Just like you can use any
filesystem under linux because they have a well-defined intrface to
the rest of the kernel, the paravirt-ops are the way we are wrking to
define an interface so that the rest of the kernel can be ignorant to
whether it's running on the bare metal or as a guest.

Then, if you needed to run say 2.6.19 with hypervisor A-1.0, you just
need to write paravirt-ops which talk and translate between 2.6.19 and
A-1.0. If 5 years later you are still running A-1.0 and want to run a
2.6.28 guest, then you would just need to write the paravirt-ops
between 2.6.28 and A-1.0, with no need to modify the rest of the code
or the hypervisor.

At the moment we only have 1 GPL hypervisor and 1 binary one. Then
maybe it's needed to define if linux should help run under binary
hypervisors, but imagine instead of this one, we had the usual Ghyper
vs Khyper separation. We would prefer to give the same adaptations to
both of them and abstract them away just like we do with filesystems.

> this basicly boils down to 'once you expose an interface to a user it can't
> change', with the interface that's being exposed being the calls that the guest
> makes to the host.

Yes, that's the reason some mentioned ppc, sparc, s390... because they
have been doing this longer than us and we could consider adopting
some of their designs (just like we did for POSIX system calls ;)

> David Lang

-- 
Greetz, Antonio Vargas aka winden of network
