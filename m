Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbTGDSVL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 14:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266093AbTGDSVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 14:21:11 -0400
Received: from holomorphy.com ([66.224.33.161]:35712 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S266085AbTGDSVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 14:21:07 -0400
Date: Fri, 4 Jul 2003 11:36:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
Message-ID: <20030704183649.GE955@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <Pine.LNX.4.53.0307041139150.24383@montezuma.mastecende.com> <13170000.1057335490@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13170000.1057335490@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, zwane wrote:
>> The way i see it is that you can't use NR_CPUS to determine the upper 
>> bound on APIC IDs. e.g. my 3way is normally configured with NR_CPUS = 3 
>> but has APIC IDs of 0, 3 and 4. We need to make a distinction.

On Fri, Jul 04, 2003 at 09:18:12AM -0700, Martin J. Bligh wrote:
> Fair enough. But that would seem to be a simpler operation than this patch.

It is not a simpler operation. It is the patch.

On Fri, Jul 04, 2003 at 09:18:12AM -0700, Martin J. Bligh wrote:
> We break it out in subarch, but it's the same everywhere, which seems
> utterly useless - is probably historical cruft that needs to die.
> But that sounds like a separate issue, and a separate patch to me.

The change is correct. Let it stand.


On Fri, Jul 04, 2003 at 09:18:12AM -0700, Martin J. Bligh wrote:
> Ugh, are you saying the cpumask stuff shrinks masks to < 32 bits if
> NR_CPUS is low enough? If so, I can see more point to the patch, but
> it still seems like violent overkill. Stopping it doing that would
> probably fix it ... I can't imagine it buys you much.

This change is also correct. Let it stand.


On Fri, Jul 04, 2003 at 09:18:12AM -0700, Martin J. Bligh wrote:
> phys_cpu_present_map started off as an unsigned long, and I reused it
> in a fairly twisted way for NUMA-Q. As it's an array that's bounded
> by apic space, using the bios_cpu_apicid method that summit uses
> would be a much cleaner fix, and just leave the old one as a long
> bitmask like it used to be - which is fine for non- clustered apic
> systems, and saves inventing a whole new data type. See the
> cpu_present_to_apicid abstraction.

The precise thing this does is making phys_cpu_present_map an array
bounded by the APIC space. The change is correct. Let it stand.


At some point in the past, zwane wrote:
>> Urgh, it's really hard to determine what these functions really want half 
>> the time. But that change does look wrong.

On Fri, Jul 04, 2003 at 09:18:12AM -0700, Martin J. Bligh wrote:
> Yeah, things taking logical apicids, and turning them into cpu numbers
> presumably shouldn't have to touch that.

The cpu bitmasks change width with NR_CPUS. The APIC ID spaces do not.
They must hence be bitmasks of separate widths. Hence the change is
correct. Let it stand.


-- wli
