Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWHYOSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWHYOSp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWHYOSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:18:45 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:48225 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751486AbWHYOSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:18:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LC7x+FWnJIqRKvA9y/LpmgL/iVan41X/u0MPLb1le8pEaS7gdqCCRQnPtGQ6u0NcpU14cNAaOu1zBOCpZFoXxOm2ju6nN5Zl4E6elb6S5nVSdT/v0VztJDMLiuVS4kMP3TiLseoULTqQ21Mfqn45ED2S3+wwDx0KcUQJx8+N4LU=
Message-ID: <58d0dbf10608250718r3b3f88a4l77b7c62b1cbf8736@mail.gmail.com>
Date: Fri, 25 Aug 2006 16:18:43 +0200
From: "Jan Kiszka" <jan.kiszka@googlemail.com>
To: "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: [RFC] maximum latency tracking infrastructure (version 2)
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, mingo@elte.hu,
       akpm@osdl.org, jbarnes@virtuousgeek.org, dwalker@mvista.com,
       nickpiggin@yahoo.com.au, rpm@xenomai.org
In-Reply-To: <44EEFFC8.40202@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1156504939.3032.26.camel@laptopd505.fenrus.org>
	 <58d0dbf10608250643v1bb19d0ci99ae30243125a962@mail.gmail.com>
	 <44EEFFC8.40202@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/8/25, Arjan van de Ven <arjan@linux.intel.com>:
> Jan Kiszka wrote:
> >> The patch below adds infrastructure to track "maximum allowable
> >> latency" for
> >> power saving policies.
> >
> > Very interesting approach. I wonder if it could be used to cover
> > another problematic source of latencies as well: asynchronous SMIs.
> > They quickly cause delays reaching from a few 100 us up to
> > milliseconds.
> >
> > Hard-RT extension like Xenomai work around this on several Intel
> > chipsets by disabling SMI unconditionally
>
>
> I would consider that a mistake. SMI's are used to do things like emergency thermal protections etc etc.
> Disabling them unconditionally is going to risk you your hardware.

For sure, this risk remains unless SMI is fine-grained controllable
and you can avoid that cirtical services. It's a compromise between
not using common PC hardware for fast time critical jobs at all and a
small risk to loose hardware when something goes wrong anyway.

And such feature would certainly not be on by default. Even we don't
do this, the user must decide after being warned. I'm not aware of
complaints about damages after years of application in the field.

>
> > I guess an interface to let also applications / the sysadmin specifiy
> > a latency constraint would be useful as well. sysfs?
>
> I thought about this a lot but decided against. There are already ways to do things like disable specific C states etc,
> and if we expose this it'll mostly get abused by certain desktop applications who have no idea what they are doing ;=(
> What makes anyone think that userspace could make a better decision than the drivers?

I was thinking about critical timed operations in userspace that are
not known to any driver ahead of time.

> Video / Audio playback are not good examples since these both already would work automatically correct with only in-kernel
> infrastructure. Hard-RT systems are also not a good example since those should use the existing boot parameters. I couldn't
> come up with other scenarios, and until we have a good one I'm against exposing crap to sysfs "just because we can".
>

Jan
