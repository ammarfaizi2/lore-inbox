Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWFHAp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWFHAp2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 20:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWFHAp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 20:45:28 -0400
Received: from mga05.intel.com ([192.55.52.89]:28606 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932516AbWFHAp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 20:45:28 -0400
X-IronPort-AV: i="4.05,218,1146466800"; 
   d="scan'208"; a="48690869:sNHT53940537"
Date: Wed, 7 Jun 2006 17:41:35 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Brendan Trotter <btrotter@gmail.com>, Keith Owens <kaos@sgi.com>,
       Andi Kleen <ak@suse.de>, Ashok Raj <ashok.raj@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: NMI problems with Dell SMP Xeons
Message-ID: <20060607174135.A27195@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <200606070920.23436.ak@suse.de> <8446.1149666227@kao2.melbourne.sgi.com> <b1ebdcad0606070818l3024b264k89f6cd37ccb0b6f7@mail.gmail.com> <20060607114747.A25548@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060607114747.A25548@unix-os.sc.intel.com>; from rajesh.shah@intel.com on Wed, Jun 07, 2006 at 11:47:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 11:47:47AM -0700, Rajesh Shah wrote:
> On Wed, Jun 07, 2006 at 03:18:57PM +0000, Brendan Trotter wrote:
> > 
> > > I will try forcing send_IPI_allbutself() to use the mask version rather
> > > than the broadcast shortcut.  Later tonight ...
> > 
> > I've been looking into this a little - it appears that Linux tries to
> > use one bit per CPU in the local APIC's "logical destination register"
> > and that in all cases at least one bit is set for each valid CPU. As
> > far as I can tell sending an NMI (or any other broadcast IPI) in
> > logical mode with no shorthand and "destination = 0xFF" should work
> > fine for both "cluster mode" and "flat mode". In this case I'd also
> > suggest that "clear_local_APIC()" clear the destination format
> > register (DFR) and the logical destination register (LDR) so that it
> > doesn't receive broadcast NMIs if the CPU is taken offline.
> > 
> I will double-check with the CPU folks, but I don't think this
> will do what you want it to do. If you send an NMI IPI with
> destination set to 0xff, I think it will interrupt all CPUs,

I was wrong - a (reasonably modern) CPU will indeed not take the
NMI IPI if its LDR is clear and the IPI was sent in logical mode.
However, the CPU folks weren't expecting it to be used this way,
so they aren't sure yet if this is guaranteed to work this way
on all CPUs. 

Rajesh
