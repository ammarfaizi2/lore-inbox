Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWIKLt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWIKLt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 07:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWIKLt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 07:49:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:20786 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751200AbWIKLt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 07:49:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QqBnRnzi8TDoFonH92x7swhAwQ8yLug5HDnLNk5gj4Y0NmThRrcQg5Wb2NWG30WHp4YR6leEJrvOxmuMj6bnn9MKzaovZy0tiesGBRDs9a3jVPrtS1j3bixzzWWfNLpoTh6mZAI935eNorAgLk+G1HaPaEDn6ASmlQtaA0ZW+KQ=
Message-ID: <1b270aae0609110449m2f71495cna78a6cb17e7ca649@mail.gmail.com>
Date: Mon, 11 Sep 2006 13:49:57 +0200
From: "Metathronius Galabant" <m.galabant@googlemail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: top displaying 50% si time and 50% idle on idle machine
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1b270aae0609110405r183748d2y753c0e846229f1d0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1b270aae0609071108h22bc10b0v5d2227abfc66c53c@mail.gmail.com>
	 <20060907175323.57a5c6b0.akpm@osdl.org>
	 <1b270aae0609081403u11b76ae9v72ad933475a2319f@mail.gmail.com>
	 <20060908224752.GK8793@ucw.cz>
	 <1b270aae0609110405r183748d2y753c0e846229f1d0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>>Cpu(s):  0.0% us,  0.0% sy,  0.0% ni, 50.0% id,  0.0%
> >>>>wa,  0.0% hi, 50.0%si
>
> >> BTW what means si? (interrupt service time? google
> >> didn't find anything)
>
> > 'soft interrupt' probably. try disconnecting network.
>
> The cause has been found. The timer of that machine is seriously
> broken, 1 second is approximately 500ms long.
> It is a HP DL360 G4 and I configured the kernel without ACPI or
> similar. Maybe there are some strange BIOS power management schemes
> active. I will look deeper into the problem and report back.
> A broken timer is _very_ strange to me (I didn't encounter that in the
> last 12 years w/ custom kernels).

Power management was completely switched off, so that was not the cause.
Instead, please have a look the this dmesg outputs:

not working (no ACPI):

ENABLING IO-APIC IRQs
unknown bus type 32. (repeated MULTIPLE TIMES!)
..TIMER: vector=0x31 apic1=-1 pin1=-1 apic2=-1 pin2=-1
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.


working (ACPI + processor support):

ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1

Can this be considered as a kernel-bug?

Thanks for the help,
M.
