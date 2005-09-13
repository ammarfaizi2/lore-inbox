Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVIMFKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVIMFKK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 01:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVIMFKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 01:10:10 -0400
Received: from mail.cs.umn.edu ([128.101.35.202]:35013 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S1751134AbVIMFKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 01:10:08 -0400
Date: Tue, 13 Sep 2005 00:10:05 -0500
From: Dave C Boutcher <sleddog@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, Andi Kleen <ak@muc.de>,
       James Bottomley <James.Bottomley@steeleye.com>, lxie@us.ibm.com,
       santil@us.ibm.com
Subject: Re: ibmvscsi badness (Re: 2.6.13-mm3)
Message-ID: <20050913051005.GA8771@cs.umn.edu>
Reply-To: boutcher@cs.umn.edu
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, serue@us.ibm.com,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Blanchard <anton@samba.org>, Andi Kleen <ak@muc.de>,
	James Bottomley <James.Bottomley@steeleye.com>, lxie@us.ibm.com,
	santil@us.ibm.com
References: <20050912024350.60e89eb1.akpm@osdl.org> <20050912222437.GA13124@sergelap.austin.ibm.com> <20050912161013.76ef833f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912161013.76ef833f.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 04:10:13PM -0700, Andrew Morton wrote:
> serue@us.ibm.com wrote:
> >
> > Trying to get 2.6.13-mm running on a power5 lpar, I'm
> > having scsi problems.
> 
> You should have cc'ed the scsi mailing list, no?
> 
> > With -mm2, I only get things like:
> > 	sd 0:0:0:0: SCSI error: return code = 0x8000002
> > 	sda: Current: sense key: Aborted Command
> > 	    Additional sense: No additional sense information
> > 	Info fld=0x0
> > 	end_request: I/O error, dev sda, sector 10468770
> > 	sd 0:0:0:0: SCSI error: return code = 0x8000002
> > 	sda: Current: sense key: Aborted Command
> > 	    Additional sense: No additional sense information
> > 	Info fld=0x0
> > 	end_request: I/O error, dev sda, sector 10468778
> > 	sd 0:0:0:0: SCSI error: return code = 0x8000002
> > 	sda: Current: sense key: Aborted Command
> > 	    Additional sense: No additional sense information
> > 	Info fld=0x0
> > 	end_request: I/O error, dev sda, sector 10468786

Well, I know why you get these errors with mm2. mm2 ibmvscsi
allows transferring longer scatterlists between the initiator
and the target than before. However that breaks compatibility
with the older target that was shipped with SLES 9.  Longer
scatterlists ARE supported with the target I recently posted
as an RFC.

I'm thinking we'll have to add a module paramter to limit
scatterlist sizes that defaults to the old behaviour.  Let
me sleep on that and kick it around with Linda tomorrow and
we'll figure out some kind of solution.

As Anton already reported, mm3 has an additional set of
breakages...

-- 
Dave Boutcher
