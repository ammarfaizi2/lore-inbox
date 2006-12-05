Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968270AbWLEPIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968270AbWLEPIc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968272AbWLEPIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:08:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:5428 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968270AbWLEPIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:08:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iN/UsZLmjqBH/fnQHd+L0hMAuOeE07Kb4gVQqBAxQRnbzTb+lhCQNB3h0bs8HENUMhf9zvlfzufvt+5XQamIw4PIpe3/kazX2nJnni3082jpzPbsx5O5kXqoQzyroIXaLeJa8Hv05HwgWVWBARDQNWdZIE4Z/U8PixZv5xdCeCA=
Message-ID: <aec7e5c30612050708w3fe2e0e4ye4d435dfb9667c41@mail.gmail.com>
Date: Wed, 6 Dec 2006 00:08:25 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: vgoyal@in.ibm.com
Subject: Re: [PATCH 00/02] kexec: Move segment code to assembly files
Cc: "Magnus Damm" <magnus@valinux.co.jp>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>, fastboot@lists.osdl.org,
       ebiederm@xmission.com, "Andrew Morton" <akpm@osdl.org>,
       "Rik van Riel" <riel@redhat.com>
In-Reply-To: <20061205140252.GA7959@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061205133757.25725.96929.sendpatchset@localhost>
	 <20061205140252.GA7959@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> On Tue, Dec 05, 2006 at 10:37:57PM +0900, Magnus Damm wrote:
> > kexec: Move segment code to assembly files
> >
> > The following patches rearrange the lowlevel kexec code to perform idt,
> > gdt and segment setup code in assembly on the code page instead of doing
> > it in inline assembly in the C files.
> >
>
> I don't think we should be doing this. I would rather prefer code to
> keep in C for easier debugging, readability and maintenance.

I prefer to write code in C too, but I don't see how wrapping assembly
instructions in inline C makes the code any easier compared to raw
assembly. Either you understand the assembly or you don't.

> > Our dom0 Xen port of kexec and kdump executes the code page from the
> > hypervisor when kexec:ing into a new kernel. Putting as much code as
> > possible on the code page allows us to keep the amount of duplicated
> > code low.
> >
>
> Is Xen going upstream now? I heard now lhype+KVM seems to be the way.
> Even if it is required, we should do it once Xen goes in.

I am not sure about status of the Xen merging effort. domU seemed to
be the top priority last time I heard something, but this change only
affects dom0 so it is probably even further away.

> You have already moved page table setup code to assembly and we should
> be getting rid of that code too.

This was recommended to me by Eric if I'm not mistaken, but if we can
move out parts of the assembly code to C then that would be great.

> I would rather live with duplicated code than moving more code in assembly
> which can be written in C. Understanding and debugging assembly code
> is such a big pain.

Again, I think that is true for C code - not for inline assembly in C
files. But I guess you are talking about the already merged page table
a patches. My first version implemented the code in C, have a look at
the function create_mapping() which I think is very clear:

http://lists.osdl.org/pipermail/fastboot/2006-May/002838.html

The important question IMO is if this should be merged ahead of the
rest of the Xen stuff, and maybe it shouldn't.

Thanks,

/ magnus
