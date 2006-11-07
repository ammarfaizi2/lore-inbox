Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753068AbWKGUSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbWKGUSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbWKGUSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:18:12 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:30403 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1753068AbWKGUSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:18:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CNraNV1afI5jiMwLfzE0IP4Jxg2wJJo2/4Ge2mIGjDmhd/3R8URZ0LaaFCCultiJjAtemePD4jJnb74gsc1wZF95jUOQQTVLgOp8TyJx8b75C6HNXlZ6GpXCtz+LQJifg7fV1Es4GoFhqUgl2jWgkm0EjJBw2ZFdZXtQ2TVLli4=
Message-ID: <170fa0d20611071218t3c145ef9i5413e432597d78a5@mail.gmail.com>
Date: Tue, 7 Nov 2006 15:18:08 -0500
From: "Mike Snitzer" <snitzer@gmail.com>
To: "device-mapper development" <dm-devel@redhat.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Ingo Molnar" <mingo@elte.hu>, "Eric Sandeen" <sandeen@sandeen.net>,
       "Srinivasa DS" <srinivasa@in.ibm.com>
Subject: Re: [dm-devel] [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
In-Reply-To: <20061107183459.GG6993@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061107183459.GG6993@agk.surrey.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/06, Alasdair G Kergon <agk@redhat.com> wrote:
> From: Srinivasa Ds <srinivasa@in.ibm.com>
>
> On debugging I found out that,"dmsetup suspend <device name>" calls
> "freeze_bdev()",which locks "bd_mount_mutex" to make sure that no new mounts
> happen on bdev until thaw_bdev() is called.  This "thaw_bdev()" is getting
> called when we resume the device through "dmsetup resume <device-name>".
> Hence we have 2 processes,one of which locks "bd_mount_mutex"(dmsetup
> suspend) and another(dmsetup resume) unlocks it.

Srinivasa's description of the patch just speaks to how freeze_bdev
and thaw_bdev are used by DM but completely skips justification for
switching from mutex to semaphore.  Why is it beneficial and/or
necessary to use a semaphore instead of a mutex here?

Mike
