Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbTLEU2m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 15:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264395AbTLEU2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 15:28:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20159 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264386AbTLEU2j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 15:28:39 -0500
Date: Fri, 5 Dec 2003 20:28:38 +0000
From: Matthew Wilcox <willy@debian.org>
To: Erez Zadok <ezk@cs.sunysb.edu>
Cc: Matthew Wilcox <willy@debian.org>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Phillip Lougher <phillip@lougher.demon.co.uk>,
       Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
Message-ID: <20031205202838.GD29469@parcelfarce.linux.theplanet.co.uk>
References: <20031205191447.GC29469@parcelfarce.linux.theplanet.co.uk> <200312051947.hB5Jlupp030878@agora.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312051947.hB5Jlupp030878@agora.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 02:47:56PM -0500, Erez Zadok wrote:
> Thanks for the info, Matthew.  Yes, clearly a scheme that keeps some "holes"
> in compressed files can help; one of our ideas was to leave sparse holes
> every N blocks, exactly for this kind of expansion, and to update the index
> file's format to record where the spaces are (so we can efficiently
> calculate how many holes we need to consume upon a new write).

But the genius is that you don't need to calculate anything.  If the
data block turns out to be incompressible (those damn .tar.bz2s!), you
just write the block in-place.  If it is compressible, you write as much
into that block's entry as you need and leave a gap.  The underlying
file system doesn't write any data there.  There's no need for an index
file -- you know exactly where to start reading each block.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
