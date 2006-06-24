Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933081AbWFXMoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933081AbWFXMoO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 08:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933085AbWFXMoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 08:44:14 -0400
Received: from thunk.org ([69.25.196.29]:44747 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S933081AbWFXMoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 08:44:13 -0400
Date: Sat, 24 Jun 2006 08:43:54 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: UML failing w/o SKAS enabled
Message-ID: <20060624124354.GA7290@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060622213443.GA22303@thunk.org> <20060623024222.GA8316@ccure.user-mode-linux.org> <20060623210714.GA16661@thunk.org> <20060623214623.GA7319@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623214623.GA7319@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 05:46:23PM -0400, Jeff Dike wrote:
> On Fri, Jun 23, 2006 at 05:07:14PM -0400, Theodore Tso wrote:
> > Well, because my host kernel is running a completely stock 2.6.17
> > kernel and so I don't have the SKAS patch applied.  If the goal is to
> > abandon tt mode, it would be really nice if the SKAS patch gets
> > integrated into mainline first....
> 
> UML has a form of skas which runs on stock hosts.  defconfig will give
> you a CONFIG_MODE_SKAS, !CONFIG_MODE_TT UML which will run on an
> unmodified host.

It might be good to explicitly state that in the Kconfig
documentation, in particular in the documentation for CONFIG_MODE_TT.
Note that the entry for CONFIG_MODE_SKAS still mentions the need for
an external patch, and I tried searching 2.6.17-mm1's x86 config
options to see if the SKAS patch had been applied, and I couldn't find
anything, so I assumed that SKAS still required the out-of-tree patch.
If the situation is changed, 

config MODE_SKAS
        bool "Separate Kernel Address Space support" if MODE_TT
        default y
        help
        This option controls whether skas (separate kernel address space)
        support is compiled in.  If you have applied the skas patch to the
        host, then you certainly want to say Y here (and consider saying N
        to CONFIG_MODE_TT).  Otherwise, it is safe to say Y.  Disabling this
        option will shrink the UML binary slightly.

Also, just as a suggestion, it might be a good idea to update the UML
HOWTO in Documentation/uml/UserModeLinux-HOWTO.txt (or at least the
November 18, 2002 date), and also the SKAS page at:

	http://user-mode-linux.sourceforge.net/skas.html

Regards,

							- Ted
