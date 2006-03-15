Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWCOBFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWCOBFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 20:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWCOBFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 20:05:34 -0500
Received: from lixom.net ([66.141.50.11]:52102 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S932131AbWCOBFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 20:05:33 -0500
Date: Tue, 14 Mar 2006 18:56:32 -0600
To: Jon Mason <jdmason@us.ibm.com>
Cc: Pavel Machek <pavel@suse.cz>, Muli Ben-Yehuda <mulix@mulix.org>,
       Andi Kleen <ak@suse.de>, Muli Ben-Yehuda <MULI@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 2/3] x86-64: Calgary IOMMU - Calgary specific bits
Message-ID: <20060315005632.GE5170@pb15.lixom.net>
References: <20060314082432.GE23631@granada.merseine.nu> <20060314082552.GF23631@granada.merseine.nu> <20060314230306.GB1579@elf.ucw.cz> <20060315005514.GD7699@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315005514.GD7699@us.ibm.com>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 06:55:15PM -0600, Jon Mason wrote:
> On Wed, Mar 15, 2006 at 12:03:06AM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > +union tce_entry {
> > > +   	u64 te_word;
> > > +	struct {
> > > +		unsigned int  read     :1;   /* read allowed */
> > > +		unsigned int  write    :1;   /* write allowed */
> > > +		unsigned int  hubid    :6;   /* hub id - unused */
> > > +		unsigned int  rsvd     :4;   /* reserved */
> > > +		unsigned long rpn      :36;  /* Real page number */
> > > +		unsigned int  unused   :16;  /* unused */
> > > +	} bits;
> > > +};
> > 
> > I'd say this is going to be pretty flakey.
> 
> Why do you think this would be flakey?  It's nearly identical to the
> tce_entry definition in include/asm-powerpc/tce.h (endien swapped, of
> course).

We're killing structures like that one by one on PPC, I just haven't
gotten around to dealing with tce_entry yet.

The way to do it is to use masking and shifting by hand.


-Olof
