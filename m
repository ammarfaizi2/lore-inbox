Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWHWDKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWHWDKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 23:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWHWDKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 23:10:24 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:14015 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932305AbWHWDKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 23:10:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ApVWbcXuhjqApv9sJE+417cf+8I/rs/z5EdOZJnDfmXlhMEaXfiZrbQhPUhAo3Wn6LJhAWLINk4PhzMLIMwsegnJA6J1BeB2EAE3d8F5hFutfcMV/NjLHInTiYk9+cStGvlFh3Jma4MCB4CTp0dTos0pKgMPis9YmRsfMW2IHd4=
Message-ID: <aec7e5c30608222010k2be71311l29d4349f7e174d5@mail.gmail.com>
Date: Wed, 23 Aug 2006 12:10:22 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] [PATCH] x86_64: Reload CS when startup_64 is used.
Cc: "Andi Kleen" <ak@suse.de>, "Magnus Damm" <magnus@valinux.co.jp>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <m1lkphqfz0.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060821095328.3132.40575.sendpatchset@cherry.local>
	 <1156208306.21411.85.camel@localhost>
	 <m1u045sagu.fsf@ebiederm.dsl.xmission.com>
	 <200608221003.12608.ak@suse.de>
	 <m1y7thqi7b.fsf_-_@ebiederm.dsl.xmission.com>
	 <aec7e5c30608220153h4553d890v3a3740e7fdc6986@mail.gmail.com>
	 <m1lkphqfz0.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Magnus Damm" <magnus.damm@gmail.com> writes:
> > On 8/22/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> In long mode the %cs is largely a relic.  However there are a few cases
> >> like lret where it matters that we have a valid value.  Without this
> >> patch it is possible to enter the kernel in startup_64 without setting
> >> %cs to a valid value.  With this patch we don't care what %cs value
> >> we enter the kernel with, so long as the cs shadow register indicates
> >> it is a privileged code segment.
> >>
> >> Thanks to Magnus Damm for finding this problem and posting the
> >> first workable patch.  I have moved the jump to set %cs down a
> >> few instructions so we don't need to take an extra jump.  Which
> >> keeps the code simpler.
> >>
> >> Signed-of-by: Eric W. Biederman <ebiederm@xmission.com>
> >
> > While at it, could you please fix up the purgatory code in kexec-tools
> > to include this fix so we can boot older versions of the kernel too?
>
> I guess I'm not opposed to a patch but I have some serious reservations
> about a solution that limits my address to 32bits in 64bit mode, and
> appears to break the gdt used for entering the 32bit kernel.

The 32-bit pointer issue can easily be resolved. I don't understand
what you mean with breaking the GDT though - to me it looks like the
entry for CS in entry64.S is broken without my patch. You reload the
GDT to a new one anyway in entry64-32.S so I'm not sure what this
32-bit breakage is that you are talking about.

> I'm up way to late tonight.  I just wanted to resolve the situation
> when it was clear what was going on.

Getting the fix in the kernel is hopefully solved now, thanks for the
help. Next step in my mind is to fix up kexec-tools - I'll send an
updated patch to fastboot later on today.

Thanks,

/ magnus
