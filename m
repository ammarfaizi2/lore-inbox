Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVBUPTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVBUPTF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 10:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVBUPTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 10:19:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10924 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262005AbVBUPTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 10:19:00 -0500
Date: Mon, 21 Feb 2005 15:18:52 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Alex Adriaanse <alex.adriaanse@gmail.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Odd data corruption problem with LVM/ReiserFS
Message-ID: <20050221151852.GE14097@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Alex Adriaanse <alex.adriaanse@gmail.com>,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <93ca3067050220212518d94666@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93ca3067050220212518d94666@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2005 at 11:25:37PM -0600, Alex Adriaanse wrote:
> This morning was the first time my backup script took
> a snapshot since upgrading to 2.6.10-ac12 (yesterday I had taken a few
> snapshots myself for testing purposes, this seemed to work fine).
 
a) Activating a snapshot requires a lot of memory;

b) If a snapshot can't get the memory it needs you have to back it
out manually (using dmsetup - some combination of resume, remove & 
possibly reload) to avoid locking up the volume - what you have to do 
depends how far it got before it failed;

c) You should be OK once a snapshot is active and its origin has 
successfully had a block written to it.

Work is underway to address the various problems with snapshot activation
- we think we understand them all - but until the fixes have worked their 
way through, unless you've enough memory in the machine it's best to avoid
them.  

Suggestions: 
  Only do one snapshot+backup at once;
  Make sure logging in as root and using dmsetup does not depend on access 
  to anything in /var or /home (similar to the case of hard NFS mounts with 
  the server down) so you can still log in;

BTW Also never snapshot the root filesystem unless you've mounted it noatime
or disabled hotplug etc. - e.g. the machine can lock up attempting to 
update the atime on /sbin/hotplug while writes to the filesystem are blocked

Alasdair
-- 
agk@redhat.com
