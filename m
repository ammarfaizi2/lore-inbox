Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUANFBN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 00:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266293AbUANFBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 00:01:13 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:10711 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266292AbUANFBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 00:01:12 -0500
Date: Wed, 14 Jan 2004 04:59:45 +0000
From: Dave Jones <davej@redhat.com>
To: Robert Love <rml@ximian.com>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Laptops & CPU frequency
Message-ID: <20040114045945.GB23845@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Robert Love <rml@ximian.com>,
	Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
	linux-kernel@vger.kernel.org
References: <20040111025623.GA19890@ncsu.edu> <20040111025623.GA19890@ncsu.edu> <1073791061.1663.77.camel@localhost> <E1Afj2b-0004QN-00@chiark.greenend.org.uk> <E1Afj2b-0004QN-00@chiark.greenend.org.uk> <1073841200.1153.0.camel@localhost> <E1AfjdT-0008OH-00@chiark.greenend.org.uk> <1073843690.1153.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073843690.1153.12.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 12:54:51PM -0500, Robert Love wrote:
 > On Sun, 2004-01-11 at 12:44, Matthew Garrett wrote:
 > 
 > > Is there any realistic way of noticing this sort of change?
 > 
 > Sure.  That is how Speedstep works, right?  We have an interface for
 > Speedstep, so the kernel knows about it.  We do not have an interface
 > for the proprietary BIOS stuff, I assume, so the kernel is oblivious.

Speedstep support is one way right now. We tell the CPU "switch to this mode"
and it does. What we don't know how to do in cpufreq is detect when someone pulls
the power out, or plugs back in. BIOS SMM magick happens, and it all
gets taken care of transparently without us having a clue that anything
happened.

We *could* hook into the APM 'power source changed' notifiers, (and I
guess ACPI has something similar somewhere). That should take care of things.

 > But if you had the docs, I suppose you could code a solution and tie it
 > into the cpufreq code, just as we have proper support for Speedstep,
 > Longrun, etc.

Of all the implementations I've played with (longhaul/powernow/speedstep-smi)
speedstep is the only one that does funky shit with SMM. The others are quite
dumb (and friendly) in comparison. (Ie, nothing happens on power source change)

		Dave

