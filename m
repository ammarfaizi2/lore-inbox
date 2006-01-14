Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWANNxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWANNxq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 08:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWANNxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 08:53:46 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:39377 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751410AbWANNxp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 08:53:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hf6Ec7amGTtx7rCQ4pFQrnSmMps+Elb04FNgj5k8pEnuCex8SAYuOgxHKU7B4ZWvG/TiB+YWkS6uJcWgC76/B5UXvg8P3Wwn5hkVUjIwobzuV4Mdv8cV1tOLJln87uV0UHL19D/Qn0iWK2PE4xTrmlj4dzjf1ttU///8yZujfxk=
Message-ID: <3afbacad0601140553u374273bao71c0cb74108354d8@mail.gmail.com>
Date: Sat, 14 Jan 2006 14:53:44 +0100
From: Jim MacBaine <jmacbaine@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/sys/vm/swappiness == 0 makes OOM killer go beserk
Cc: Nick Craig-Wood <nick@craig-wood.com>
In-Reply-To: <20060114110231.06B6F14C6FD@irishsea.home.craig-wood.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5uzvD-8tr-19@gated-at.bofh.it>
	 <20060114110231.06B6F14C6FD@irishsea.home.craig-wood.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/06, Nick Craig-Wood <nick@craig-wood.com> wrote:

> On my home workstation I do a lot of stuff with very large video
> files, so set swappiness to 0 some time ago so using these large files
> would stop all the applications getting pushed out into swap.

My motivation was similar: My desktop usually runs 24 hrs and I leave
large applications which I use from time to time always open. Like
OpenOffice, Firefox, Emacs with large buffers, etc.  In the night, the
machine performs two disk-intensive tasks.  First a backup then
updatedb. And every morning about 650 MB of 1 GB RAM is used for
caches and all my application need to be swapped in before I can use
them.

Of course, the increase of disk cache is reasonable for those tasks,
but honestly, I don't care whether the updatedb process takes 10 or 20
minutes in the night. But I do care if switching between applications
needs >10 seconds in the morning.

Would it be possible to trigger paging in specific applications from
userspace? So I might run something like

echo -n firefox-bin > /proc/sys/vm/page-in
echo -n soffice-bin > /proc/sys/vm/page-in
...

after my nightly cron jobs have filled the memory with disk cache data
that won't be useful anymore, because in my daily work I rarely touch
10% of the filesystem.

Regards,
Jim
