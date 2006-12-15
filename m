Return-Path: <linux-kernel-owner+w=401wt.eu-S1752039AbWLOACz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbWLOACz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbWLOACz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:02:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40427 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039AbWLOACy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:02:54 -0500
Date: Thu, 14 Dec 2006 19:02:50 -0500
From: Dave Jones <davej@redhat.com>
To: Daniel Drake <dsd@gentoo.org>
Cc: linux list <linux-kernel@vger.kernel.org>
Subject: Re: amd64 agpgart aperture base value
Message-ID: <20061215000250.GB18456@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Daniel Drake <dsd@gentoo.org>,
	linux list <linux-kernel@vger.kernel.org>
References: <4580C954.103@gentoo.org> <20061214132224.GD17565@redhat.com> <4581DFC2.1000304@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4581DFC2.1000304@gentoo.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 06:35:30PM -0500, Daniel Drake wrote:

 > So, you think that the aperture moving to a different location on every 
 > boot is what the BIOS desires? Is it normal for it to move so much?

Beats me. I gave up trying to understand BIOS authors motivations years ago.

 > The current patch drops the upper bits and results in the aperture 
 > always being in the same place, and this appears to work. If the BIOS 
 > did really put the aperture beyond 4GB but my patch is making Linux put 
 > it somewhere else, does it surprise you that things are still working 
 > smoothly?

Does it survive a run of testgart when masking out the high bits?
It could be that you're right, and the upper bits being reported really
are garbage.

 > Is it even possible for the aperture to start beyond 4GB when the system 
 > has less than 4GB of RAM?

The amount of RAM is irrelevant, it can appear anywhere in the address space,
which on 64bit, is pretty darned huge.  The aperture isn't backed by RAM,
it's a 'virtual window' of sorts. When you write to an address in that range, it
gets transparently remapped to somewhere else in the address space.
The window is the 'aperture', where it remaps to is controlled by a translation
table called the GATT (which does live in real memory).

That's pretty much all there is to AGP. It's just a really dumb MMU of sorts.

		Dave

-- 
http://www.codemonkey.org.uk
