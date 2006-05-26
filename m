Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWEZJ3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWEZJ3R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 05:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWEZJ3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 05:29:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:43317 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751355AbWEZJ3Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 05:29:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z4JQ/Ms2COz7FF24/IrgOaoFGaZiWGZGTJ5YLJqxNATEmz2N8VDXPZ2PB26q7Qhmzr5IPy4Ss5LNwbbhAoOw3fdm6PQSmDYTeVPjvdWbya0SJCYGtsRETCULJAgojgsJzCLj4oTGNTP/9WUk3hSN+AASlAoIKTwhXGBEId5bCV0=
Message-ID: <aec7e5c30605260229i5a182254u188d1a7f9e73056e@mail.gmail.com>
Date: Fri, 26 May 2006 18:29:15 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] [PATCH 03/03] kexec: Avoid overwriting the current pgd (V2, x86_64)
Cc: "Gerd Hoffmann" <kraxel@suse.de>, "Magnus Damm" <magnus@valinux.co.jp>,
       "Andrew Morton" <akpm@osdl.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1r72hb0vc.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	 <20060524044247.14219.13579.sendpatchset@cherry.local>
	 <m1slmystqa.fsf@ebiederm.dsl.xmission.com>
	 <1148545616.5793.180.camel@localhost> <4476B0F6.2000708@suse.de>
	 <aec7e5c30605260202m531b0f01pfd244932d9fc99a9@mail.gmail.com>
	 <m1r72hb0vc.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Magnus Damm" <magnus.damm@gmail.com> writes:
>
> > On 5/26/06, Gerd Hoffmann <kraxel@suse.de> wrote:
> >> > 1a. The C-code in xen_machine_kexec() performs a hypercall.
> >> >
> >> > 1b. The hypervisor jumps to the assembly code.
> >> > After prepare we've created a NX-safe mapping for the control page. We
> >> > jump to that NX-safe address to transfer control to the assembly code.
> >>
> >> This is about kexec'ing the physical machine, not the virtual machine,
> >> right?
> >
> > Correct, kexec:ing from dom0.
>
> And staying in dom0?  Or does Xen go away?

You replace what's running on the physical machine.

You can chose to kexec into a new "regular" Linux kernel (Xen goes
away), or kexec into a new Xen hypervisor with a new dom0 kernel (Xen
is replaced). Kexec behaves exactly the same as Linux today - no
patches are needed to kexec-tools.

Kdump is a little different though, we reserve the physical ram range
in the hypervisor and our hypervisor code is currently using a
differen format for the command line options. With Kdump under Xen it
is possible to take a memory snapshot of the entire machine - both the
hypervisor and dom0.

/ magnus
