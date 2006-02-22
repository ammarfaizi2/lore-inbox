Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWBVVUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWBVVUF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWBVVUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:20:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42765 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751282AbWBVVUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:20:04 -0500
Date: Wed, 22 Feb 2006 21:19:44 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Joel Becker <Joel.Becker@oracle.com>, gombasg@sztaki.hu, tytso@mit.edu,
       torvalds@osdl.org, kay.sievers@suse.de, penberg@cs.helsinki.fi,
       gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222211943.GA2875@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Joel Becker <Joel.Becker@oracle.com>, gombasg@sztaki.hu,
	tytso@mit.edu, torvalds@osdl.org, kay.sievers@suse.de,
	penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de,
	rml@novell.com, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
References: <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org> <20060222154820.GJ16648@ca-server1.us.oracle.com> <20060222162533.GA30316@thunk.org> <20060222173354.GJ14447@boogie.lpds.sztaki.hu> <20060222185923.GL16648@ca-server1.us.oracle.com> <20060222115410.1394ff82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222115410.1394ff82.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 11:54:10AM -0800, Andrew Morton wrote:
> Yes, I tend to think that insmod should just block until all devices are
> ready to be used.  insmod doesn't just "insert a module".  It runs that
> module's init function.

Not always possible.  In the case of PCMCIA, we've had to run things
asynchronously because of the #$@$#@ driver model locking issues -
otherwise adding a PCI (cardbus) device while we're in the probe for
the yenta device deadlocked.

I suspect other subsystems also suffered from this, which unfortunately
makes your otherwise good idea a pipedream.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
