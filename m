Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264719AbUEEQ2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264719AbUEEQ2H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 12:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264722AbUEEQ2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 12:28:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54489 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264719AbUEEQ2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 12:28:05 -0400
Date: Wed, 5 May 2004 17:28:03 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-RFC] code for raceless /sys/fs/foofs/*
Message-ID: <20040505162802.GN17014@parcelfarce.linux.theplanet.co.uk>
References: <16536.61900.721224.492325@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16536.61900.721224.492325@laputa.namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 05:53:16PM +0400, Nikita Danilov wrote:
> Hello,
> 
> attached patch adds code necessary to safely export per-super-block
> information in /sys/fs and /proc/fs.
> 
> Common problem with exporting file system information in procfs or sysfs
> is a race between method that inputs/outputs data and concurrent umount
> of the super-block involved.
 
Aside of the implementation questions (will comment later), there is an
interface problem here.  We end up allowing anyone who has sysfs mounted
(in chroot jail, in limited namespace, etc.) to pin down _any_ reiser4
superblock, whether they have the thing itself mounted or not.
