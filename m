Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266986AbSKLVup>; Tue, 12 Nov 2002 16:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266992AbSKLVty>; Tue, 12 Nov 2002 16:49:54 -0500
Received: from holomorphy.com ([66.224.33.161]:3773 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266985AbSKLVsu>;
	Tue, 12 Nov 2002 16:48:50 -0500
Date: Tue, 12 Nov 2002 13:53:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       hohnbaum@us.ibm.com
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <20021112215305.GZ23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
	hohnbaum@us.ibm.com
References: <E18BaIc-0006Zs-00@holomorphy> <20021112205241.GS23425@holomorphy.com> <3DD172B8.8040802@us.ibm.com> <20021112213504.GV23425@holomorphy.com> <20021112213906.GW23425@holomorphy.com> <177250000.1037141189@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177250000.1037141189@flay>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Also, every PCI bridge in my box has a bus number of 3 so the lookup
>> table will produce wrong answers every time.

On Tue, Nov 12, 2002 at 02:46:29PM -0800, Martin J. Bligh wrote:
> Isn't that the local bus number though? The topology functions take
> global bus numbers, which should be unique ...
> M.

That bus number mangling scheme is an instance of an approach vetoed
over a year ago by Dave Miller and others, and does not work for bridges
because arch code does not get the opportunity to mangle the bus number
during bridge discovery.

The inheritance of ->sysdata is the proper method, used by Alpha, PPC,
ARM, and others, and has been generally acknowledged as the acceptable
solution to the PCI domain/segment problem.


Bill
