Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWCEC0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWCEC0k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 21:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWCEC0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 21:26:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2223 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750715AbWCEC0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 21:26:39 -0500
Date: Sat, 4 Mar 2006 21:26:04 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, ak@suse.de, Ashok Raj <ashok.raj@intel.com>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Message-ID: <20060305022604.GA1289@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, 76306.1226@compuserve.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	ak@suse.de, Ashok Raj <ashok.raj@intel.com>
References: <200603011957_MC3-1-B99B-8FFE@compuserve.com> <20060302010953.GA19755@redhat.com> <20060304164238.37d2ea49.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304164238.37d2ea49.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 04:42:38PM -0800, Andrew Morton wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > >
 > > On Wed, Mar 01, 2006 at 07:55:25PM -0500, Chuck Ebbert wrote:
 > >  > In-Reply-To: <20060301230317.GF1440@redhat.com>
 > >  > 
 > >  > On Wed, 1 Mar 2006 18:03:17, Dave Jones wrote:
 > >  > 
 > >  > > (17:59:38:davej@nemesis:~)$ cat /sys/devices/system/cpu/cpu0/topology/core_siblings
 > >  > > 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001
 > >  > > (17:59:47:davej@nemesis:~)$ cat /sys/devices/system/cpu/cpu1/topology/core_siblings
 > >  > > 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000002
 > >  > > 
 > >  > > Neither of these CPUs are HT / dual-core, so shouldn't these be the same ?
 > >  > 
 > >  > Those are bitmaps. 1 => only bit 0 is set => CPU 0 is all alone.
 > >  > 
 > >  > Did you really build a 256-CPU SMP kernel or is ACPI ignoring CONFIG_NR_CPUS
 > >  > or something?
 > > 
 > > Yes, it's =256.
 > > 
 > 
 > Is that the only way in which to trigger the bug?
 > 
 > If so, I'd be inclined to hold the fix back for 2.6.17.

not had chance to test Ashok's change yet (and probably won't until
at least Monday), but Andi's one-liner to limit x86-64's NR_CPUs
to 255 instead of 256 did the trick, and is a lot less invasive
for 2.6.16

		Dave

