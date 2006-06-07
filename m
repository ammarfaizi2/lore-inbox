Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWFGSvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWFGSvn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 14:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWFGSvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 14:51:43 -0400
Received: from mga06.intel.com ([134.134.136.21]:19972 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932182AbWFGSvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 14:51:42 -0400
X-IronPort-AV: i="4.05,217,1146466800"; 
   d="scan'208"; a="47352503:sNHT456064406"
Date: Wed, 7 Jun 2006 11:47:47 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Brendan Trotter <btrotter@gmail.com>
Cc: Keith Owens <kaos@sgi.com>, Andi Kleen <ak@suse.de>,
       Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: NMI problems with Dell SMP Xeons
Message-ID: <20060607114747.A25548@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <200606070920.23436.ak@suse.de> <8446.1149666227@kao2.melbourne.sgi.com> <b1ebdcad0606070818l3024b264k89f6cd37ccb0b6f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <b1ebdcad0606070818l3024b264k89f6cd37ccb0b6f7@mail.gmail.com>; from btrotter@gmail.com on Wed, Jun 07, 2006 at 03:18:57PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 03:18:57PM +0000, Brendan Trotter wrote:
> 
> > I will try forcing send_IPI_allbutself() to use the mask version rather
> > than the broadcast shortcut.  Later tonight ...
> 
> I've been looking into this a little - it appears that Linux tries to
> use one bit per CPU in the local APIC's "logical destination register"
> and that in all cases at least one bit is set for each valid CPU. As
> far as I can tell sending an NMI (or any other broadcast IPI) in
> logical mode with no shorthand and "destination = 0xFF" should work
> fine for both "cluster mode" and "flat mode". In this case I'd also
> suggest that "clear_local_APIC()" clear the destination format
> register (DFR) and the logical destination register (LDR) so that it
> doesn't receive broadcast NMIs if the CPU is taken offline.
> 
I will double-check with the CPU folks, but I don't think this
will do what you want it to do. If you send an NMI IPI with
destination set to 0xff, I think it will interrupt all CPUs,
including the non-started CPUs in the cli;hlt state. If I
remember right, the destination shorthand method simply
sends the interrupt on the bus with destination set to
0xff..

Rajesh
