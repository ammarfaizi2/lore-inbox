Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVK1MyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVK1MyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 07:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVK1MyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 07:54:11 -0500
Received: from gate.in-addr.de ([212.8.193.158]:32744 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S932075AbVK1MyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 07:54:10 -0500
Date: Mon, 28 Nov 2005 13:53:51 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051128125351.GE30589@marowsky-bree.de>
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com> <20051121101959.GB13927@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051121101959.GB13927@wohnheim.fh-wedel.de>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-11-21T11:19:59, Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

> o Merge of LVM and filesystem layer
>   Not done.  This has some advantages, but also more complexity than
>   seperate LVM and filesystem layers.  Might be considers "not worth
>   it" for some years.

This is one of the cooler ideas IMHO. In effect, LVM is just a special
case filesystem - huge blocksizes, few files, mostly no directories,
exports block instead of character/streams "files".

Why do we need to implement a clustered LVM as well as a clustered
filesystem? Because we can't re-use across this boundary and not stack
"real" filesystems, so we need a pseudo-layer we call volume management.
And then, if by accident we need a block device from a filesystem again,
we get to use loop devices. Does that make sense? Not really.

(Same as the distinction between character and block devices in the
kernel.)

Look at how people want to use Xen: host the images on OCFS2/GFS backing
stores. In effect, this uses the CFS as a cluster enabled volume
manager.

If they'd be better integrated (ie: be able to stack filesystems), we
could snapshot/RAID single files (or ultimately, even directories trees)
just like today we can snapshot whole block devices.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

