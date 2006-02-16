Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWBPGdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWBPGdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 01:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWBPGdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 01:33:11 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:58708 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751362AbWBPGdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 01:33:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vZrJDH/ecijXgoLNfbTpEaHWabDgTjz3WDRvdTX7We1Os5WKswSCaQH1ixeF7/ECXRag2JXVlc1x6O5fP7CjEkLcf7kssI9m4yOK2k3xtyrLawC/iayfYY6GUOSwvCcLo/gp8m67XuEIvpACDIk6VVvOEgryt3z5buBPv+PH8jU=  ;
Message-ID: <43F41641.5080601@yahoo.com.au>
Date: Thu, 16 Feb 2006 17:05:53 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: NeilBrown <neilb@suse.de>, Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Nick Piggin <npiggin@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix over-zealous tag clearing in radix_tree_delete
References: <20060216144112.11116.patches@notabene> <1060216034301.11136@suse.de>
In-Reply-To: <1060216034301.11136@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown wrote:
> Against 2.6.16-rc2-mm1.  For inclusion in 2.6.16 please.
> 
> ### Comments for Changeset
> 
> If a tag is set for a node being deleted from a radix_tree,
> then that tag gets cleared from the parent of the node, even
> if it is set for some siblings of the node begin deleted.
> 
> This patch changes the logic to include a test for any_tag_set similar
> to the logic a little futher down.  Care is taken to ensure that
> 'nr_cleared_tags' remains equals to the number of entries in the
> 'tags' array which are set to '0' (which means that this tag is not
> set in the tree below pathp->node, and should be cleared at
> pathp->node and possibly above.
> 
> Acked-by: Nick Piggin <npiggin@suse.de>
> Signed-off-by: Neil Brown <neilb@suse.de>
> 

Linus FYI, I was able to modify the radix tree test harness to catch
the bug and can no longer trigger it after the fix. Resulting code
passes all other harness tests as well of course.

Should be applied ASAP. However, unlike Andrew I don't think this is
a filesystem corrupting bug (maybe he was talking about NFS?).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
