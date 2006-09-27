Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031120AbWI0WG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031120AbWI0WG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031126AbWI0WG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:06:28 -0400
Received: from smtp-out.google.com ([216.239.45.12]:35627 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1031120AbWI0WG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:06:27 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=icWeyXy1SmWAZcwqSccA4uk/e3BKblvxFnNfLOLyVUtpudQQGPu7IV7Owy680+ayE
	KLhJr47TPT6pf5w8Qquvw==
Message-ID: <8f95bb250609271506x526a7ac5j99c110dce0f662e0@mail.google.com>
Date: Wed, 27 Sep 2006 15:06:14 -0700
From: "Aaron Durbin" <adurbin@google.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.18-mm1
Cc: "Andi Kleen" <ak@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nil@google.com
In-Reply-To: <m1hcyto112.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060924040215.8e6e7f1a.akpm@osdl.org>
	 <200609270913.15688.ak@suse.de>
	 <m14putpxks.fsf@ebiederm.dsl.xmission.com>
	 <200609270951.17124.ak@suse.de>
	 <m1hcyto112.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Andi Kleen <ak@suse.de> writes:
>
> > On Wednesday 27 September 2006 09:39, Eric W. Biederman wrote:
> >> Andi Kleen <ak@suse.de> writes:
> >>
> >> > On Wednesday 27 September 2006 04:04, Eric W. Biederman wrote:
> >> >>
> >> >> When I apply:
> >> >> x86_64-mm-insert-ioapics-and-local-apic-into-resource-map
> >> >>
> >> >> My e1000 fails to initializes and complains about a bad eeprom checksum.
> >> >> I haven't tracked this down to root cause yet and I am in the process of
> >> > building
> >> >> 2.6.18-mm1 with just that patch reverted to confirm that is the only cause.
> >> >
> >> > Is this with Linux BIOS?
> >>
> >> Yes.  Not that it matters in this case.
> >
> > Well Linus BIOS is known to play very fast-and-lose regarding supplying
> > correct BIOS tables.
>
> Agreed it does tend to push the envelop of what is allowed, and doesn't
> try to work around OS bugs.  Which does tend to expose things.
>
> > Perhaps it conflicts with a broken e820 map?
>
> No. Did you not get the other part of the discussion?
>
> The reservation was wrong because those IOAPICs were on ordinary pci
> devices.  So the two reservations for the same resource conflicted,
> so the pci allocator tried to move the pci device.
>
> The problem is totally contained within the patch under discussion.
>
> The role LinuxBIOS plays seems to be that it is atypical to enable
> ioapics as ordinary pci devices.
>
> Eric
>

Eric,

I agree that clearing the IORESOURCE_BUSY flag would not alleviate
this problem.  Could you please post the output of 'lspci -vvvvx' so
we could better understand the layout of your box?  Perhaps I might
have to defer the registration of the resources until later.  It seems
weird that the IO APIC are mapped in as PCI devices though.

-Aaron
