Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268960AbTBZWmD>; Wed, 26 Feb 2003 17:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbTBZWmD>; Wed, 26 Feb 2003 17:42:03 -0500
Received: from franka.aracnet.com ([216.99.193.44]:20685 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268960AbTBZWmC>; Wed, 26 Feb 2003 17:42:02 -0500
Date: Wed, 26 Feb 2003 14:51:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>, Ion Badulescu <ionut@badula.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: [BUG] 2.5.63: ESR killed my box!
Message-ID: <3420000.1046299866@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302261400160.3156-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302261400160.3156-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wouldn't it be nicer to just fix the write instead? I can see the 
> potential to actually want to change the APIC ID - in particular, if the 
> SMP MP tables say that the APIC ID for the BP should be X, maybe we
> should  actually write X to it instead of just using what is there.

That strikes me as the wrong way around. We *are* booting on this CPU, 
so the MPS tables are wrong. Why reprogram reality to fit the MPS tables?
Also, you don't know what the other CPUs  phys ID's really are if
everything is inconsistent anyway ... if the MPS tables say boot is phys 0,
and phys 1 also exists, and we find we're on phys 1, what now? 

Also, if we kexec from a non-original boot cpu, we come back with that CPU
as the boot CPU, which is correct, but doesn't match the MPS tables .. the
one liner I sent before will fix that.

Wouldn't it be better to just leave the phys apicids as is, and just print
a warning of the MPS tables boot flags don't match up with reality? Seems
far less drastic to me.

> In particular, Mikaels patch will BUG() if the MP tables don't match the 
> APIC ID. I think that's extremely rude: we should select one of the two 
> and just run with it, instead of unconditionally failing.

OK, that's bad. SMP does that currently too, but it's easy to fix without
going to the extent of reprogramming things that we don't really understand
the state of (because we have inconsistent info)

M.

