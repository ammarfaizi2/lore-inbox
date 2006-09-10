Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWIJOe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWIJOe4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 10:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWIJOe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 10:34:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:26579 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932208AbWIJOey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 10:34:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RGmxO27uvZ6CRzY94I8BDYo2MG2ON/MBbhyEhcEgj5AxXh7gvxXiZACdbIxXRyMuWWgT1wEyiDBZ6+j3NddOvQNUoxe0Gz5Zn/Nvy4Vtes7lDPkRkqvdqUPgAA5xXF5+J7Aup1VwndPW9nhbsf5RaxHgPwZH+rv6I/GWvKzr2gw=
Message-ID: <82ecf08e0609100734w4c0faaf9yffce5b67d5aeaedd@mail.gmail.com>
Date: Sun, 10 Sep 2006 11:34:52 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Dave Jones" <davej@redhat.com>, "Thiago Galesi" <thiagogalesi@gmail.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Cpufreq not working in 2.6.18-rc6
In-Reply-To: <82ecf08e0609090813g4889b659sfcb90e005cb42c14@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <82ecf08e0609090722p1ded935dm794d569278d60122@mail.gmail.com>
	 <20060909144739.GS28592@redhat.com>
	 <82ecf08e0609090813g4889b659sfcb90e005cb42c14@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, apparently it is my fault...

I traced the failure to

if (cpufreq_driver) {
                spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
                return -EBUSY;
        }

(cpufreq_register_driver in drivers/cpufreq/cpufreq.c)

Turns out I was modprobing acpi-cpufreq before modprobing cpufreq-k7.
This worked in previous kernels and apparently, not in this one.

If I do not modprobe acpi-cpufreq, it works.

Thiago

On 9/9/06, Thiago Galesi <thiagogalesi@gmail.com> wrote:
> >  >
> >  > CONFIG_X86_POWERNOW_K7_ACPI=y
> >  > ..
> >  > CONFIG_ACPI_PROCESSOR=m
> >
> > Does it start working again if you change ACPI_PROCESSOR=y ?
>
> No. nothing changes
>
> --
> -
> Thiago Galesi
>
