Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbUDMNgR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 09:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263480AbUDMNgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 09:36:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61317 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263407AbUDMNgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 09:36:16 -0400
Date: Tue, 13 Apr 2004 14:36:15 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk>
References: <20040413124037.GA21637@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040413124037.GA21637@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 06:10:37PM +0530, Maneesh Soni wrote:
> Hi,
> 
> As pointed by Al Viro, the current symlinks support in sysfs is incorrect as
> it always sees the old target if target is renamed and obviously does not
> follow the new target. The page symlink operations as used by current sysfs
> code always see the target information at the time of creation. 

a) we ought to take a reference to target when creating a symlink (and drop
it on removal)

b) sysfs_get_target_path() should leave allocation to caller.

c) AFAICS we should simply allocate a page instead of messing with kmalloc().
