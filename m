Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422815AbWJFS0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422815AbWJFS0u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422819AbWJFS0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:26:50 -0400
Received: from stella.eotvos.elte.hu ([193.225.226.189]:31505 "EHLO
	stella.eotvos.elte.hu") by vger.kernel.org with ESMTP
	id S1422815AbWJFS0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:26:50 -0400
Date: Fri, 6 Oct 2006 20:26:42 +0200 (CEST)
From: Czigola Gabor <czigola@elte.hu>
X-X-Sender: czigola@kamorka
To: linux-kernel@vger.kernel.org
Subject: root MD array is still in use upon shutdown possible fix
Message-ID: <Pine.LNX.4.64.0610062006460.25341@kamorka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-EC-Spam-Score: -2.8
X-EC-Spam-Report: spam=No; required=5.9; autolearn=failed; bayesian_score=0.5;
	stars=;
	scanned=stella.eotvos.elte.hu; Fri, 06 Oct 2006 20:26:46 +0200;
	scanner=SpamAssassin 3.0.3 2005-04-27;
	tests=ALL_TRUSTED;
	blacklisted_at=<dns:elte.hu?type=MX> [10 mx3.mail.elte.hu., 10 mx2.mail.elte.hu.]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When my root filesystem is on an MD (RAID5) array, I can't cleanly shut 
down (trying to change the array ro, even when nothing else than the 
kernel threads and init and one bash are running, and the root fs is ro 
remounted), because I've got "md: md0 still in use" kernel messages. 
Usually it doesn't cause any problems, but it possibly could leave the 
array in an inconsistent state (resync required after reboot).

I made a patch for md.c, based on the thread on "Can't get md array to 
shut down cleanly" started at 2006-07-06 on linux-raid@vger.

The problem is reproducible on kernel v. 2.6.17.5 and 2.6.17.11, this 
patch is made for the latter.

Please check this patch, for me it does work, but I'm not sure, that it 
doesn't break something else. I'm not on the list, please CC me.

Here is the diff for drivers/md/md.c:

2789c2789
< 		if (atomic_read(&mddev->active)>2) {
---
> 		if (atomic_read(&mddev->active)>2 && !ro) {

-- 
Czigola, Gabor
