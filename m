Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbUK2PpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUK2PpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbUK2Pm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:42:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36003 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261733AbUK2Pkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:40:35 -0500
Date: Mon, 29 Nov 2004 10:40:07 -0500
From: Dave Jones <davej@redhat.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: pawfen@wp.pl, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: MTRR vesafb and wrong X performance
Message-ID: <20041129154006.GB3898@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Gerd Knorr <kraxel@bytesex.org>, pawfen@wp.pl,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <1101338139.1780.9.camel@PC3.dom.pl> <20041124171805.0586a5a1.akpm@osdl.org> <1101419803.1764.23.camel@PC3.dom.pl> <87is7ogb93.fsf@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87is7ogb93.fsf@bytesex.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 12:12:08PM +0100, Gerd Knorr wrote:
 > > > Please send the full dmesg output and the contents of /proc/mtrr for
 > > > 2.6.10-rc2.
 > > reg02: base=0xe3000000 (3632MB), size=   4MB: write-combining, count=1
 > > vesafb: framebuffer at 0xe3000000, mapped to 0xcc880000, using 1875k,
 > > total 4096k
 > 
 > The BIOS reports 4MB video memory, and vesafb adds an mtrr entry for
 > that.  Looks ok, with the exception that the reported 4MB are probably
 > not correct, otherwise the X-Server wouldn't complain.

vesafb is assuming that the memory used in the current screen mode
xres*yres*depth rounded up to nearest power of 2, is the amount of
ram the card has, which is not just wrong, it's dumb.

 > vesafb in 2.6.10-rc2 has a option to overwrite the BIOS-reported value
 > (vtotal=n, with n in megabytes), that should fix it.

which is an ugly hack for the above problem imo.
vesafb:nomtrr also fixes the problem, and leaves X free
to set things up correctly in my experience.

If vesafb can't get it right, maybe it shouldn't be
attempted to do it in the half-assed way it currently does.

		Dave

