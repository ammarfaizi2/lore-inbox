Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265232AbUFRPRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUFRPRc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUFRPQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:16:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55216 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265223AbUFRPQB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:16:01 -0400
Date: Fri, 18 Jun 2004 16:15:58 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Chris Mason <mason@suse.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] __bd_forget should wait for inodes using the mapping
Message-ID: <20040618151558.GX12308@parcelfarce.linux.theplanet.co.uk>
References: <1087523668.8002.103.camel@watt.suse.com> <20040618021043.GV12308@parcelfarce.linux.theplanet.co.uk> <1087563810.8002.116.camel@watt.suse.com> <20040618142207.GW12308@parcelfarce.linux.theplanet.co.uk> <1087570031.8002.153.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087570031.8002.153.camel@watt.suse.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 10:47:11AM -0400, Chris Mason wrote:
> During writeback, we need to answer the question: "are there dirty pages
> attached to this inode", and the only way to answer it is via the
> address space.
> 
> If bdev inodes don't want other inodes using their address space, they
> shouldn't be setting the i_mapping on other inodes.  Since they are, the
> bdev code needs to be aware that someone else might be using it.

Scheduled for 2.7.1; for now users of ->i_mapping (the fewer of them remain,
the better) have to be aware of bdev.

And yes, ->i_mapping flips on "normal" bdev inodes will go away - we set
->f_mapping on open directly.
