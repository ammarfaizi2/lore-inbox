Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbULNTjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbULNTjw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 14:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbULNTjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 14:39:52 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:12438 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261626AbULNTfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 14:35:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Q8lhXsa1bsG8yNJi30pbiYPdgjyybSUeNk4ngDIbrdS2lEq4bo2ZyHg93LzxChbaVxboAszd9lBKf6PEvaphABu5ZnjPMzfj4qX0aaGLMwxdU9CDOpHA/8XqpB6yUctYSp63W6gmmraZVXTrQUHPgID/pyKozpBrNHKzmzfTnro=
Message-ID: <69304d1104121411354f95af5e@mail.gmail.com>
Date: Tue, 14 Dec 2004 20:35:08 +0100
From: Antonio Vargas <windenntw@gmail.com>
Reply-To: Antonio Vargas <windenntw@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: arch/xen is a bad idea
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, samuel@ibrium.se, benh@kernel.crashing.org
In-Reply-To: <p73acsg1za1.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41BF1983.mailP9C1B91GB@suse.de.suse.lists.linux.kernel>
	 <p73acsg1za1.fsf@bragg.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Dec 2004 19:59:50 +0100, Andi Kleen <ak@suse.de> wrote:
> "Andi Kleen" <ak@suse.de> writes:
> 
> [again this time with subject. sorry for the screwup]
> [very late answer]
> 
> > Stunned silence I guess - merging an architecture is
> > usually much more controversial ;)
> 
> In my opinion it's still an extremly bad idea to have arch/xen
> an own architecture. It will cause a lot of work long term
> to maintain it, especially when it gets x86-64 support too.
> It would be much better to just merge it with i386/x86-64.
> 
> Currently it's already difficult enough to get people to
> add fixes to both i386 and x86-64, adding fixes to three
> or rather four (xen32 and xen64) architectures will be quite bad.
> In practice we'll likely get much worse code drift and missing
> fixes. Also I still suspect Ian is underestimating how much
> work it is long term to keep an Linux architecture uptodate.
> 
> I cannot imagine the virtualization hooks are intrusive anyways. The
> only things it needs to hook idle and the page table updates, right?
> Doing that cleanly in the existing architectures shouldn't be that
> hard.
> 
> I suspect xen64 will be rather different from xen32 anyways
> because as far as I can see the tricks Xen32 uses to be
> fast (segment limits) just plain don't work on 64bit
> because the segments don't extend into 64bit space.
> So having both in one architecture may also end up messy.
> 
> And i386 and x86-64 are in many pieces very different anyways,
> I have my doubts that trying to mesh them together in arch/xen
> will be very pretty.
> 
> Also the other thing I'm worried about is that there is no clear
> specification on how the Xen<->Linux interface works. Assuming
> there will be other para Hypervisors in the future too will we
> end up with even more virtual architectures? It would be much
> better to have at least a somewhat defined "linux virtual interface"
> first that is actually understood by multiple people outside
> the Xen group.
> 
> I think before merging stuff the hypervisor interfaces need to be
> discussed on linux-kernel. Splitting the patches and posting them
> as individual pieces for i386 with good description will be a good
> first step for that.
> 
> -Andi
> -

Andi, there is at least one other hypervisor interface, mac-on-linux
features a kernel module that allows booting other kernels inside the
running one, and keeps very good speed anyways.

Their code, at least the user-space part, was also very good coded
for my eyes.

Driver support is done by exporting a customized open-firmware
device tree and then implementing drivers for these devices on
the client OSs.

(just goto http://www.maconlinux.org/ and have a look)

Oh, this is obviusly ppc-only ATM :)

-- 
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/

Las cosas no son lo que parecen, excepto cuando parecen lo que si son.
