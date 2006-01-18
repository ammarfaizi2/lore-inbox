Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWARQP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWARQP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbWARQP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:15:27 -0500
Received: from rtr.ca ([64.26.128.89]:16070 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030373AbWARQP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:15:27 -0500
Message-ID: <43CE6997.6090005@rtr.ca>
Date: Wed, 18 Jan 2006 11:15:19 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Cynbe ru Taren <cynbe@muq.org>, linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <43CE1E52.3030907@aitel.hist.no>
In-Reply-To: <43CE1E52.3030907@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
 >
 > As other have showed - "mdadm" can reassemble your
 > broken raid - and it'll work well in those cases where
 > the underlying drives indeed are ok.  It will fail
 > spectacularly if you have a real double fault though,
 > but then nothing short of raid-6 can save you.

No, actually there are several things we *could* do,
if only the will-to-do-so existed.

For example, one bad sector on a drive doesn't mean that
the entire drive has failed.  It just means that one 512-byte
chunk of the drive has failed.

We could rewrite the failed area of the drive, allowing the
onboard firmware to repair the fault internally, likely by
remapping physical sectors.  This is nothing unusual, as all
drives these days ship from the factory with many bad sectors
that have already been remapped to "fix" them.  One or two
more in the field is no reason to toss a perfectly good drive.

Mind you, if it's more than just one or two bad sectors,
then the drive really should get tossed regardless. And the case
can be made that even for the first one or two bad sectors,
a prudent sysadmin would schedule replacement of the whole drive.

But until the drive is replaced, it could be repaired and continued
to be used as added redundancy, helping us cope far more reliably
with multiple failures.

Sure, nobody's demanding double-fault protection -- where the SAME
sector of data fails on multiple drives, and nothing can be done
to recover it then.  But we really could/should handle the case
of two *different* unrelated single-faults, at least when those
are just soft failures of unrelated sectors.

Just need somebody motivated to actually fix it,
rather than bitch about how impossible/stupid it would be.

Cheers
