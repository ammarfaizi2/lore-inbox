Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUFQNHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUFQNHR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266480AbUFQNHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:07:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64489 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266479AbUFQNHO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:07:14 -0400
Date: Thu, 17 Jun 2004 14:07:13 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: Alan Cox <alan@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040617130713.GX20511@parcelfarce.linux.theplanet.co.uk>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189FD23FF9@otce2k03.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189FD23FF9@otce2k03.adaptec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 08:53:36AM -0400, Salyzyn, Mark wrote:
> Ideally we would like to have a mechanism to know if the
> DMAable area is limited to a 32 bit address space in order to take
> advantage of the more efficient FIB utilization.

Yes, you're not the only people who want this.  There was a brief
discussion about this a few weeks ago, but I don't think anything's been
implemented yet.

It's a hard problem.  Where's the right tradeoff?  I have a system that
has a memory map that puts the first 3.75GB of memory at 0, then the
next 256MB at 64GB, then continues from 4GB.  If there's only 4GB of
RAM in that system, I'm sure you'd rather use 32-bit descriptors and
anything in that 256MB gets bounce-buffered.

But where's the line?  Who gets to decide?  Is this really per-arch,
or is it per-driver, or is it somewhere else?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
