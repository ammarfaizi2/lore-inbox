Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267664AbUBSCUV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 21:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267674AbUBSCUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 21:20:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3024 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267664AbUBSCUO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 21:20:14 -0500
Date: Thu, 19 Feb 2004 02:20:09 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] How should delete_resource() handle children?
Message-ID: <20040219022009.GP11824@parcelfarce.linux.theplanet.co.uk>
References: <20040210193349.GI13351@parcelfarce.linux.theplanet.co.uk> <20040218174800.0a3183ec.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218174800.0a3183ec.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 05:48:00PM -0800, Randy.Dunlap wrote:
> Ideally (or if nothing depends on the current behavior), I think it
> should just be an error (return -EINVAL), not a BUG_ON().  I.e.,
> releasing a resource should be an explicit action.

-EBUSY, perhaps?

> Do we know of cases where parents are removed but children need to
> remain?  Examples?

I don't know of any in-tree.  I was originally just looking at this code
while writing adjust_resource() and insert_resource() and noticed this
corner case.

But now, I was thinking about using the resource management code to handle
the PCI hotplug resource management (which currently is done independently
by each hotplug driver).  Since the drivers can be loaded independently
of everything under them, they'd need to use insert_resource() and
remove_resource() to avoid disturbing the child resources.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
