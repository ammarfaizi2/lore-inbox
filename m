Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269248AbTGJMhT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 08:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269254AbTGJMhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 08:37:19 -0400
Received: from tmi.comex.ru ([217.10.33.92]:16041 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S269248AbTGJMhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 08:37:17 -0400
X-Comment-To: Andi Kleen
To: Andi Kleen <ak@suse.de>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] minor optimization for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Thu, 10 Jul 2003 16:51:30 +0000
In-Reply-To: <p73of02pn6s.fsf@oldwotan.suse.de> (Andi Kleen's message of "10
 Jul 2003 14:43:07 +0200")
Message-ID: <87vfuagwa5.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87smpeigio.fsf@gw.home.net.suse.lists.linux.kernel>
	<20030710042016.1b12113b.akpm@osdl.org.suse.lists.linux.kernel>
	<87y8z6gyt3.fsf@gw.home.net.suse.lists.linux.kernel>
	<p73of02pn6s.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andi Kleen (AK) writes:

 AK> Alex Tomas <bzzz@tmi.comex.ru> writes:
 >> +			if (i == start + inodes_per_buffer) {
 >> +				/* all inodes (but our) are free. so, we skip I/O */

 AK> Won't this make undeletion a lot harder? Deleted inodes will now be trashed
 AK> at will, so you cannot use their contents anymore. 

AFAIK ext3 doesn't support undeletion at all

 AK> Also dtimes in free inodes  can be now lost, can't they? Did you check 
 AK> if that causes problems in fsck?  [my understanding was that ext2/3 fsck relies on the 
 AK> dtime to make some heuristics when recovering files work better]

freed inodes will be lost. I've checked filesystem by fsck after lots of creations/removals.
it seems OK.

 AK> Maybe it should be an mount option so that users can trade performance against
 AK> better recoverability.

well, I'm not sure we really need it

