Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751674AbVIZQoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbVIZQoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 12:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbVIZQoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 12:44:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45253 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751673AbVIZQoR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 12:44:17 -0400
Date: Mon, 26 Sep 2005 17:44:13 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 1/4] NTFS: Fix sparse warnings that have crept in over time.
Message-ID: <20050926164413.GP7992@ftp.linux.org.uk>
References: <Pine.LNX.4.60.0509261427520.32257@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0509261431270.32257@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.58.0509260746130.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509260746130.3308@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 07:57:09AM -0700, Linus Torvalds wrote:
> 	#define MFT_REF_MASK_CPU 0x0000ffffffffffffULL
> 	#define MFT_REF_MASK_LE const_cpu_to_le64(MFT_REF_MASK_CPU)
> 
> instead. That way the type of that thing is well-defined.

Or just make those two different enums.  Basically, gcc is hopelessly
b0rken in version-dependent way when it comes to multi-element enums
that get outside of int range.  Single-element ones at least have
kinda-sorta consistent semantics; anything beyond that and you are
walking into very nasty areas.
