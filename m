Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319057AbSIDFOv>; Wed, 4 Sep 2002 01:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319060AbSIDFOu>; Wed, 4 Sep 2002 01:14:50 -0400
Received: from holomorphy.com ([66.224.33.161]:26531 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319057AbSIDFOr>;
	Wed, 4 Sep 2002 01:14:47 -0400
Date: Tue, 3 Sep 2002 22:12:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Greg KH <greg@kroah.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com
Subject: Re: [BUG] 2.5.33 PCI and/or starfire.c broken
Message-ID: <20020904051200.GX888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Greg KH <greg@kroah.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	linux-kernel@vger.kernel.org, colpatch@us.ibm.com
References: <20020904035649.GC18800@holomorphy.com> <99179272.1031089797@[10.10.2.3]> <20020904050401.GA4019@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020904050401.GA4019@kroah.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 09:49:58PM -0700, Martin J. Bligh wrote:
>> It's confused by having a PCI-PCI bridge on a quad other than 0,
>> where the global and local PCI bus numbers don't line up. Rip
>> the card out, or get the horrible kludge I did for 2.4, and use 
>> that.

On Tue, Sep 03, 2002 at 10:04:01PM -0700, Greg KH wrote:
> Might I suggest you port that "kludge" to the new 2.5 pci code, as the
> whole goal of those large PCI changes was due to some NUMA changes that
> you and Matt wanted to get into the main kernel.
> Remember, you have your own file to play with now, so put all the
> brain-damaged NUMA crap into it :)

It's a wee bit less brain-damaged than crackly sound cards with only 24
out of 32 address lines wired. At any rate, the issue is in all
likelihood that that support file is being circumvented. It's obviously
getting wrong information when it asks to read from a given bus as
there are no PCI devices off of node 0 (as this hasn't worked in a long
time), so perhaps a disassembly or other fishing around will reveal
whose pci config space accessors are actually being called here.

Cheers,
Bill
