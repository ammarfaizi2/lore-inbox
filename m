Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269894AbUIDLU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269894AbUIDLU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269907AbUIDLU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:20:27 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:36552 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S269894AbUIDLS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:18:26 -0400
Date: Sat, 4 Sep 2004 12:17:15 +0100
From: Dave Jones <davej@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904111715.GA2785@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@linux.ie>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <41399CA2.3080607@yahoo.com.au> <Pine.LNX.4.58.0409041151200.25475@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409041151200.25475@skynet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 11:54:06AM +0100, Dave Airlie wrote:
 
 > > Just out of interest, what would the scenario be if you do if you could
 > > get a compatible driver?
 > 
 > you just grab a DRI snapshot which contains new userspace and DRM, and
 > install it... it builds the DRM against your current kernel, now if your
 > current kernel has a DRM module built-in which is a different version, you
 > are screwed, snapshot process breaks..

You're also screwed if your vendor has AGPGART compiled into its kernel[1]
and your new card needs an AGPGART update.
Which is a valid thing to do if they want things like i810fb to work.
Or AMD64's IOMMU code. (Which is dependant on the agpgart having a view
on what its up to, otherwise loading the agpgart module later would cause
data corruption as it stomps all over the first half of the aperture where
the IOMMU put its mappings).

For the simple cases of just a PCI ID update, you could just echo the id
into agpgart's relevant sysfs file. But chipsets that need new/altered
code are going to cause a problem.

This is already causing havoc with ATI/NVIDIA/Matrox binary drivers that
ship their own agpgarts. I've seen all manner of oopses, crash reports
that are from two sets of agpgart code fighting it out. Now do you see
why I'm beating on these binary folks to give it up already and use
the in-kernel gart driver ? Without sounding all high and mighty,
they cannot win this game. The rest of the driver can stay binary only
for the rest of time for all I care, but running a modular agpgart
and a built-in agpgart is the fast road to a dead box.

 > It's one of the major successes I feel of the DRI project, those
 > snapshots allowed people with Radeon IGP chipsets to get 3d acceleration
 > long before now (they still can't get it any current distro), same goes
 > for i915 as Keith points out..

It's something I ranted about yesterday on dri-devel in regards to ATI,
I really expected more of opensource developers.  Encouraging end-users
to run ancient kernels is a *BAD* idea. Both from a security/stability
standpoint, and a code maintainability standpoint.

		Dave

[1] Of which Fedora/RHEL is one of these.

