Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161475AbWJUSMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161475AbWJUSMM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWJUSMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:12:12 -0400
Received: from mail.suse.de ([195.135.220.2]:56745 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S2992784AbWJUSML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:12:11 -0400
From: Andi Kleen <ak@suse.de>
To: patches@x86-64.org
Subject: Re: [patches] Re: [PATCH] [14/19] i386: Disable nmi watchdog on all ThinkPads
Date: Sat, 21 Oct 2006 20:11:56 +0200
User-Agent: KMail/1.9.5
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <20061021651.356252000@suse.de> <20061021165134.7ADBB13CB4@wotan.suse.de> <20061021172401.GD30758@redhat.com>
In-Reply-To: <20061021172401.GD30758@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610212011.56215.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  > -	if (nmi_watchdog == NMI_DEFAULT && dmi_get_year(DMI_BIOS_DATE) >= 2004)
>  > +	   Probably safe on most older systems too, but let's be careful.
>  > +	   IBM ThinkPads use INT10 inside SMM and that allows early NMI inside SMM
>  > +	   which hangs the system. Disable watchdog for all thinkpads */
>  > +	if (nmi_watchdog == NMI_DEFAULT && dmi_get_year(DMI_BIOS_DATE) >= 2004 &&
>  > +		!dmi_name_in_vendors("ThinkPad"))
>  >  		nmi_watchdog = NMI_LOCAL_APIC;
> 
> This is going to get some people scratching their heads wondering
> why it isn't working if they ever try nmi_watchdog on one of these.
> How about adding an explanitory printk ?

When you enable it manually then NMI_DEFAULT won't be set and this code
is never executed.

BTW their machines will likely not stay up long enough that they can
see the printk (unless Lenovo fixes that particular bug in the future,
they are aware of it)

-Andi
