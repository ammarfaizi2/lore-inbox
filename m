Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269148AbTB0BQL>; Wed, 26 Feb 2003 20:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269149AbTB0BQL>; Wed, 26 Feb 2003 20:16:11 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:38409 "EHLO
	badula.org") by vger.kernel.org with ESMTP id <S269148AbTB0BQK>;
	Wed, 26 Feb 2003 20:16:10 -0500
Date: Wed, 26 Feb 2003 20:26:18 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Mikael Pettersson <mikpe@user.it.uu.se>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <mingo@redhat.com>
Subject: Re: [BUG] 2.5.63: ESR killed my box!
In-Reply-To: <Pine.LNX.4.44.0302261559170.3527-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302261931130.6844-100000@moisil.badula.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003, Linus Torvalds wrote:

> Ok, can people agree on this simplified version of Mikaels patch, which 
> doesn't BUG_ON(), and doesn't reset 'boot_cpu_physical_apicid' 
> unnecessarily..
> 
> Does this work for people?

Works for me, but I'm curious if it works for Rusty. We're still not sure 
if he's hitting the same bug... but I guess it's rather early morning in 
.au. :-)

Oh, and 2.4 needs the same fix -- and if Mikael's original BUG_ON() is 
undesirable then we should probably also remove this code from 2.4's 
apic.c:setup_local_APIC()

        if (!clustered_apic_mode && 
            !test_bit(GET_APIC_ID(apic_read(APIC_ID)), &phys_cpu_present_map))
                BUG();

because it's essentially the same test as the BUG_ON(), at least for the 
UP case.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.


