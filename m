Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbTFCOci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265032AbTFCOci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:32:38 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:48365 "EHLO
	iapetus.localdomain") by vger.kernel.org with ESMTP id S265031AbTFCOcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:32:35 -0400
Date: Tue, 3 Jun 2003 16:46:56 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Edward Hibbert <EH@dataconnection.com>
Subject: Re: [NFS] Disabling Symbolic Link Content Caching in NFS Client
Message-ID: <20030603144656.GA6157@iapetus.localdomain>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Edward Hibbert <EH@dataconnection.com>
References: <CFCD2C778CF1D611B5B400065B04D5C84A736F@KENTON>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFCD2C778CF1D611B5B400065B04D5C84A736F@KENTON>
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 02:33:45PM +0100, Edward Hibbert wrote:
> 
> Our application consists of a number of machines collaborating on a shared
> database over NFS.  We therefore require the ability to force data to be
> sync'd from the client to the backend - and at the moment we do this by
> disabling caching completely, via the noac option and acquiring and
> releasing non-exclusive locks round io calls.
> 
> Any improvements in the granularity of control over NFS client-side caching
> would be very valuable to us.

To disable ac for a single directory for a certain amount of time, see

	http://web.inter.nl.net/users/fvm/nfs-noac/2.4.20-noac-timeout.patch
	http://web.inter.nl.net/users/fvm/nfs-noac/readme:

This patch implements /proc/sys/net/nfs/noac-timeout

When a nonzero value is written, suspend atribute caching for the current
working directory and one level of files inside for the specified number
of seconds. Attribute caching will automatically be enabled when the time
elapses. Writing a zero re-enables attribute caching as well. Reading
yields the number of remaining seconds attribute caching will be disabled.


Maybe an NFS specific ioctl would be cleaner. But the above patch can be
used even from simple scripts.

-- 
Frank
