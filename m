Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422996AbWBAWtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422996AbWBAWtf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 17:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422995AbWBAWtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 17:49:35 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:56045 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1422991AbWBAWte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 17:49:34 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 1 Feb 2006 22:49:08 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Grant Grundler <iod00d@hp.com>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Akinobu Mita'" <mita@miraclelinux.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 1/12] generic *_bit()
In-Reply-To: <20060201220903.GE16471@esmail.cup.hp.com>
Message-ID: <Pine.LNX.4.64.0602012246330.3680@hermes-2.csi.cam.ac.uk>
References: <20060201193933.GA16471@esmail.cup.hp.com>
 <200602012141.k11LfCg32497@unix-os.sc.intel.com> <20060201220903.GE16471@esmail.cup.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2006, Grant Grundler wrote:
> On Wed, Feb 01, 2006 at 01:41:03PM -0800, Chen, Kenneth W wrote:
> > > Well, if it doesn't matter, why is unsigned int better?
> > 
> > I was coming from the angle of having bitop operate on unsigned
> > int *, so people don't have to type cast or change bit flag variable
> > to unsigned long for various structures.  With unsigned int type for
> > bit flag, some of them are not even close to fully utilized. for example:
> > 
> > thread_info->flags uses 18 bits
> > thread_struct->flags uses 7 bits
> > 
> > It's a waste of memory to define a variable that kernel will *never*
> > touch the 4 MSB in that field.
> 
> Agreed. Good point. But this can be mitigated if the code using "unsigned int"
> (or unsigned byte) first loads the value into a local unsigned long variable.
> That typically translates into a tmp register anyway. Compiler will help
> you find places where that needs to happen.
> 
> Counter point is bit arrays (e.g. bit maps) like cpumask_t are
> typically much larger than 32-bits (typically distro's ship with
> NR_CPUS set to 256 or so).  File system code also likes bit arrays
> for block allocation tables. Searching a bit array using unsigned
> long is 2x faster on 64-bit architectures. I don't want to give
> that up and I'm pretty sure Tony Luck, Paul Mckerras and a few
> others would object unless you can give a better reason.

Err, searching by anything other than bytes is useless for a file system 
driver.  Otherwise you get all sorts of disgustingly horrible allocation 
patterns depending on the endianness of the machine...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
