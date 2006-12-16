Return-Path: <linux-kernel-owner+w=401wt.eu-S1030869AbWLPLU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030869AbWLPLU3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 06:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030872AbWLPLU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 06:20:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:29158 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030869AbWLPLU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 06:20:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XmpO/hlBXRqXyOPo9EIX6H5bmTOUdwFvpor1JywkmopcT03nNRVbnOZYqNxsCwmVDZMlLtAtU9aUWcEP00WRQIIsTYxRADS5a5pAttYyhkdcuoEXM05WWiJIuV/CpyNnlyT0LH7h9szss2QoobwYytxMQ8LhMTKFKnSInrvsO1A=
Message-ID: <2c0942db0612160320o5f830855y3c607585d5f855f1@mail.gmail.com>
Date: Sat, 16 Dec 2006 03:20:26 -0800
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.19-rc5: known regressions (v3)
Cc: "Andi Kleen" <ak@suse.de>, "Eric Dumazet" <dada1@cosmosbay.com>,
       "Adrian Bunk" <bunk@stusta.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Stephen Hemminger" <shemminger@osdl.org>, gregkh@suse.de,
       "Ingo Molnar" <mingo@redhat.com>, "Len Brown" <len.brown@intel.com>,
       phil.el@wanadoo.fr, oprofile-list@lists.sourceforge.net
In-Reply-To: <20061122104245.3ce89487.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	 <200611151135.48306.dada1@cosmosbay.com>
	 <200611221128.05769.dada1@cosmosbay.com>
	 <200611221136.14565.ak@suse.de>
	 <20061122104245.3ce89487.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/06, Andrew Morton <akpm@osdl.org> wrote:
> On Wed, 22 Nov 2006 11:36:14 +0100
> Andi Kleen <ak@suse.de> wrote:
>
> > On Wednesday 22 November 2006 11:28, Eric Dumazet wrote:
> > > On Wednesday 15 November 2006 11:35, Eric Dumazet wrote:
> > > > On Wednesday 15 November 2006 11:21, Adrian Bunk wrote:
> > > > > Subject    : x86_64: oprofile doesn't work
> > > > > References : http://lkml.org/lkml/2006/10/27/3
> > > > > Submitter  : Prakash Punnoor <prakash@punnoor.de>
> > > > > Status     : unknown
> > > >
> > >
> > > I hit the same problem on i386 architecture too, if CONFIG_ACPI is not set.
> >
> > oprofile is still broken because it cannot deal with the lack of perfctr 0.
>
> The kernel is still broken because we changed the interface.

I just got bit by this on 2.6.20-latest (well, of two days ago anyway)
while trying to debug another transient 'kacpid sucks all available
cpu time'. But that's okay, I'm sure it will happen again in a week or
two.

In the meantime, who won this pis^H^H^H discussion?

Mikael Pettersson wrote:
> Andrew Morton writes:
> > Surely the appropriate behaviour is to allow oprofile to steal the NMI and
> > to then put the NMI back to doing the watchdog thing after oprofile has
> > finished with it.
>
> Which is _exactly_ what pre-2.6.19-rc1 kernels did. I implemented
> the in-kernel API allowing real performance counter drivers like
> oprofile (and perfctr) to claim the HW from the NMI watchdog,
> do their work, and then release it which resumed the watchdog.
>
> Note that oprofile (and perfctr) didn't do anything behind the
> NMI watchdog's back. They went via the API. Nothing dodgy going on.

Well, that seems clear.
