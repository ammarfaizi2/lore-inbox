Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUCCDot (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 22:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbUCCDot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 22:44:49 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:63875 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261615AbUCCDos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 22:44:48 -0500
Date: Tue, 2 Mar 2004 19:44:32 -0800
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: per-cpu blk_plug_list
Message-ID: <20040303034432.GA31277@sgi.com>
Mail-Followup-To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <B05667366EE6204181EABE9C1B1C0EB501F2AB4C@scsmsx401.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB501F2AB4C@scsmsx401.sc.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 01:18:40PM -0800, Chen, Kenneth W wrote:
> blk_plug_list/blk_plug_lock manages plug/unplug action.  When you have
> lots of cpu simultaneously submits I/O, there are lots of movement with
> the device queue on and off that global list.  Our measurement showed
> that blk_plug_lock contention prevents linux-2.6.3 kernel to scale pass
> beyond 40 thousand I/O per second in the I/O submit path.

This helped out our machines quite a bit too.  Without the patch, we
weren't able to scale above 80000 IOPS, but now we exceed 110000 (and
parity with our internal XSCSI based tree).

Maybe the plug lists and locks should be per-device though, rather than
per-cpu?  That would make the migration case easier I think.  Is that
possible?

Thanks,
Jesse
