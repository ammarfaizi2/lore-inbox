Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVAIX4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVAIX4S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 18:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVAIX4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 18:56:17 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:59558 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261984AbVAIX4L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 18:56:11 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: YhLu <YhLu@tyan.com>
Subject: Re: 256 apic id for amd64
Date: Sun, 9 Jan 2005 15:56:05 -0800
User-Agent: KMail/1.7.1
Cc: Mikael Pettersson <mikpe@csd.uu.se>, ak@muc.de, Matt_Domsch@dell.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
References: <3174569B9743D511922F00A0C943142307291365@TYANWEB>
In-Reply-To: <3174569B9743D511922F00A0C943142307291365@TYANWEB>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501091556.06060.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 January 2005 06:53 pm, YhLu wrote:
> I mean keep the bsp physical apic id using 0.
>
> YH

If you mean that Linux will require that the boot processor (BSP) will 
always have physical APIC ID == 0, then it is already too late for 
i386.  I've posted a message to the root of this thread on some example 
boxes with weird APIC numbering schemes that are in our lab.

I don't trust every single BIOS writer to _always_ make the BSP physical 
APIC ID 0 for x86-64 either.  Why do you wish to require this anyway?

It is far safer to make no assumptions about APIC numbering and just 
accept whatever the BIOS gives us in the MPS and/or ACPI tables.  A few 
simple arrays indexed by CPU number will reveal the physical and 
logical APIC IDs whenever we need them.

So, why should Linux care about any CPU's physical APIC ID?


> -----Original Message-----
> From: Mikael Pettersson [mailto:mikpe@csd.uu.se]
> Sent: Friday, January 07, 2005 6:38 PM
> To: YhLu; ak@muc.de
> Cc: Matt_Domsch@dell.com; discuss@x86-64.org; jamesclv@us.ibm.com;
> linux-kernel@vger.kernel.org; suresh.b.siddha@intel.com
> Subject: Re: 256 apic id for amd64
>
> On Fri, 7 Jan 2005 22:12:00 +0100, Andi Kleen wrote:
> >On Fri, Jan 07, 2005 at 01:14:24PM -0800, YhLu wrote:
> >> After keep the bsp using 0, the jiffies works well. Werid?
> >
> >Probably a bug somewhere.  But since BSP should be always
> >0 I'm not sure it is worth tracking down.
>
> I hope by "0" you're referring to a Linux kernel defined
> software value and _not_ what the HW or BIOS conjured up!
>
> Case in point: I was involved a while ago in tracking down
> and fixing a local APIC enumeration bug in the x86-32 (i386)
> kernel code, where the kernel failed miserably on some
> dual K7 boxes because (a) only one CPU socket was populated,
> (b) the BIOS assigned that CPU a non-zero ID, and (c) the
> kernel (apic.c) had a bug which triggered when BSP ID != 0.
>
> Never trust a BIOS to DTRT.
>
> /Mikael

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
