Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269247AbTGJM2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 08:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269248AbTGJM2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 08:28:55 -0400
Received: from ns.suse.de ([213.95.15.193]:27914 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269247AbTGJM2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 08:28:54 -0400
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] minor optimization for EXT3
References: <87smpeigio.fsf@gw.home.net.suse.lists.linux.kernel>
	<20030710042016.1b12113b.akpm@osdl.org.suse.lists.linux.kernel>
	<87y8z6gyt3.fsf@gw.home.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 10 Jul 2003 14:43:07 +0200
In-Reply-To: <87y8z6gyt3.fsf@gw.home.net.suse.lists.linux.kernel>
Message-ID: <p73of02pn6s.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> writes:
> +			if (i == start + inodes_per_buffer) {
> +				/* all inodes (but our) are free. so, we skip I/O */

Won't this make undeletion a lot harder? Deleted inodes will now be trashed
at will, so you cannot use their contents anymore. 

Also dtimes in free inodes  can be now lost, can't they? Did you check 
if that causes problems in fsck?  [my understanding was that ext2/3 fsck relies on the 
dtime to make some heuristics when recovering files work better]

Maybe it should be an mount option so that users can trade performance against
better recoverability.

-Andi
