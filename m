Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319066AbSIDFeu>; Wed, 4 Sep 2002 01:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319069AbSIDFeu>; Wed, 4 Sep 2002 01:34:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:37354 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319066AbSIDFer>;
	Wed, 4 Sep 2002 01:34:47 -0400
Date: Tue, 03 Sep 2002 22:37:20 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>, Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [BUG] 2.5.33 PCI and/or starfire.c broken
Message-ID: <102020607.1031092638@[10.10.2.3]>
In-Reply-To: <20020904051200.GX888@holomorphy.com>
References: <20020904051200.GX888@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's a wee bit less brain-damaged than crackly sound cards with 
> only 24 out of 32 address lines wired. 

True ;-)

> At any rate, the issue is in all
> likelihood that that support file is being circumvented. 

Those functions that need alteration aren't "switched" between
different arches like that. The patch just hardcodes arch specific
crud into general code, and would never be submittable. There was 
some clean way to fix it suggested, but I forget what it was at 
the moment ... will work it out again with Greg.

> It's obviously
> getting wrong information when it asks to read from a given bus as
> there are no PCI devices off of node 0 (as this hasn't worked in a long
> time), so perhaps a disassembly or other fishing around will reveal
> whose pci config space accessors are actually being called here.

Does it really matter who's registers we're reading when using
pointers we know are corrupted garbage? Far better to fix the
pointers than fuss around working what they ended up pointing
at this spin of the bottle ...

IIRC, it's getting mislead by the PCI-PCI bridge itself, which is
always returning the local bus number of 3 no matter which quad 
it's on. It's not the read operations themselves that are borked
(this time), it's the data that the bridge is returning is being
"misinterpreted".

M.

