Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbVKHBS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbVKHBS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbVKHBS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:18:56 -0500
Received: from ns.suse.de ([195.135.220.2]:60099 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965063AbVKHBSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:18:54 -0500
From: Neil Brown <neilb@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 8 Nov 2005 12:18:42 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17263.64754.79733.651186@cse.unsw.edu.au>
Cc: linas <linas@austin.ibm.com>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@austin.ibm.com,
       linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>
Subject: Re: typedefs and structs [was Re: [PATCH 16/42]: PCI:  PCI Error
	reporting callbacks]
In-Reply-To: message from Steven Rostedt on Monday November 7
References: <20051103235918.GA25616@mail.gnucash.org>
	<20051104005035.GA26929@mail.gnucash.org>
	<20051105061114.GA27016@kroah.com>
	<17262.37107.857718.184055@cargo.ozlabs.ibm.com>
	<20051107175541.GB19593@austin.ibm.com>
	<20051107182727.GD18861@kroah.com>
	<20051107185621.GD19593@austin.ibm.com>
	<20051107190245.GA19707@kroah.com>
	<20051107193600.GE19593@austin.ibm.com>
	<20051107200257.GA22524@kroah.com>
	<20051107204136.GG19593@austin.ibm.com>
	<1131412273.14381.142.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 7, rostedt@goodmis.org wrote:
> 
> This was for the simple reason, too many developers were passing
> structures by value instead of by reference, just because they were
> using a type that they didn't realize was a structure. And to make
> things worse, these structures started to get bigger.
> 

Another reason  for not using typedefs is that if you do, and you want
to refer to the structure in some other include file, you have to
#include the include file that devices the structure.
If you don't use typedefs, you can just say:

   struct foo;

and the compiler will happily wait for the complete definition later
(providing it doesn't need the size in the meanwhile). 
So avoiding typedef means that you can sometimes avoid excess
#includes, which means faster compiling.

NeilBrown
