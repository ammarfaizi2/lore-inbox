Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVBUV2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVBUV2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 16:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVBUV2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 16:28:55 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:29368 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262135AbVBUV2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 16:28:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IgXHaEYAY3lOH0JnhTqeAgG4EgyEISHJg+mmLjV1wHeSSMhlTYGT+kKxkneSOeKJjWBmbLncvenC6nLk590vSqHPaaINl0WZP2C3CkdutWWGm28tJCNt/ZKLh2uNZgngj1BprJ6hwcy9K9AeNMVAsyS5QgcIr9j2d9clNrr+Ozg=
Message-ID: <93ca306705022113287f424edb@mail.gmail.com>
Date: Mon, 21 Feb 2005 15:28:51 -0600
From: Alex Adriaanse <alex.adriaanse@gmail.com>
Reply-To: Alex Adriaanse <alex.adriaanse@gmail.com>
To: Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, dm-devel@redhat.com
Subject: Re: Odd data corruption problem with LVM/ReiserFS
In-Reply-To: <20050221151852.GE14097@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <93ca3067050220212518d94666@mail.gmail.com>
	 <20050221151852.GE14097@agk.surrey.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair,

Thanks for the tips.  Do you think it's possible DM's snapshots
could've caused this corruption, or do you think the problem lies
elsewhere?

Alex


On Mon, 21 Feb 2005 15:18:52 +0000, Alasdair G Kergon <agk@redhat.com> wrote:
> On Sun, Feb 20, 2005 at 11:25:37PM -0600, Alex Adriaanse wrote:
> > This morning was the first time my backup script took
> > a snapshot since upgrading to 2.6.10-ac12 (yesterday I had taken a few
> > snapshots myself for testing purposes, this seemed to work fine).
> 
> a) Activating a snapshot requires a lot of memory;
> 
> b) If a snapshot can't get the memory it needs you have to back it
> out manually (using dmsetup - some combination of resume, remove &
> possibly reload) to avoid locking up the volume - what you have to do
> depends how far it got before it failed;
> 
> c) You should be OK once a snapshot is active and its origin has
> successfully had a block written to it.
> 
> Work is underway to address the various problems with snapshot activation
> - we think we understand them all - but until the fixes have worked their
> way through, unless you've enough memory in the machine it's best to avoid
> them.
> 
> Suggestions:
>   Only do one snapshot+backup at once;
>   Make sure logging in as root and using dmsetup does not depend on access
>   to anything in /var or /home (similar to the case of hard NFS mounts with
>   the server down) so you can still log in;
> 
> BTW Also never snapshot the root filesystem unless you've mounted it noatime
> or disabled hotplug etc. - e.g. the machine can lock up attempting to
> update the atime on /sbin/hotplug while writes to the filesystem are blocked
> 
> Alasdair
> --
> agk@redhat.com
>
