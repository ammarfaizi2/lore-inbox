Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161326AbWI2SIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161326AbWI2SIO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161323AbWI2SIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:08:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:53154 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751245AbWI2SIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:08:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WEU6sgOF3QNk9GNWFR1MvMt8NQ9ZcKGYCiQspLVUCLAY4ySXBLRBP1i85PzABxg9+5X/VIlygwlb5mco3VHOvl1jT4liHbSBBMxOXF7CpiXdEzvLRXGM5lO60l4+M3NA90Jfvr/Ot5jVVj/SibmrjJTRQ9qVeAqiA1uqSBRHExI=
Message-ID: <4807377b0609291108x84f39c6ic4c669fd91f8fcd4@mail.gmail.com>
Date: Fri, 29 Sep 2006 11:08:10 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Sukadev Bhattiprolu" <sukadev@us.ibm.com>
Subject: Re: Network problem with 2.6.18-mm1 ?
Cc: "Auke Kok" <auke-jan.h.kok@intel.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060929005205.GA3876@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060928013724.GA22898@us.ibm.com> <451B2D29.9040306@intel.com>
	 <20060928185222.GB3352@us.ibm.com>
	 <4807377b0609281410p28d445c8mc32e7d2cb71221ab@mail.gmail.com>
	 <20060929005205.GA3876@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/06, Sukadev Bhattiprolu <sukadev@us.ibm.com> wrote:
> $ cat /proc/interrupts
>
>            CPU0       CPU1
>  28:          0          0   IO-APIC-fasteoi  eth0
> NMI:         96         35
> LOC:      18251      18524
> ERR:          0

you should be getting an interrupt every two seconds from the eth0
(e1000) driver.  You are having interrupt delivery problems probably
due to something screwing up interrupt routing in the kernel.
Normally these issues are associated with MSI interrupts but your
adapter doesn't support those and is using generic IRQ

I'm guessing that if you somehow enable interrupts on your vga card on
the same bus as e1000 (bus 3) it will have interrupt delivery problems
as well.  Maybe try xorg?

Jesse
