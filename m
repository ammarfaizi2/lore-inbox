Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWJIIEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWJIIEU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 04:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWJIIET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 04:04:19 -0400
Received: from ns2.suse.de ([195.135.220.15]:54227 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932325AbWJIIES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 04:04:18 -0400
From: Neil Brown <neilb@suse.de>
To: Czigola Gabor <czigola@elte.hu>
Date: Mon, 9 Oct 2006 10:40:13 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17705.39533.439604.522302@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: root MD array is still in use upon shutdown possible fix
In-Reply-To: message from Czigola Gabor on Friday October 6
References: <Pine.LNX.4.64.0610062006460.25341@kamorka>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday October 6, czigola@elte.hu wrote:
> Hi!
> 
> When my root filesystem is on an MD (RAID5) array, I can't cleanly shut 
> down (trying to change the array ro, even when nothing else than the 
> kernel threads and init and one bash are running, and the root fs is ro 
> remounted), because I've got "md: md0 still in use" kernel messages. 
> Usually it doesn't cause any problems, but it possibly could leave the 
> array in an inconsistent state (resync required after reboot).

When your machine shuts down, all md arrays are automatically switched to
read-only *after* the root filesystem has been unmounted.  You should
get a message 
    md: stopping all md devices.

if you get e.g.
    md: md0 still in use.
*after* that message then there might be a problem.  Otherwise
everything should be fine.

That being said, it is possible that your patch is OK.  I've been
meaning to review the rules for switching an array to read-only for
ages, but it never got to the top of the todo list.  e.g. do you want
to be able to switch an array to read-only when a filesystem is
mounted read-write off it.  If you don't, how do you check?  If you
do, what about in-flight write requests?  Do you need to wait for them
to complete? How? It isn't as straight forward as one might like.

NeilBrown
