Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUEXQrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUEXQrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 12:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbUEXQrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 12:47:36 -0400
Received: from mail.kroah.org ([65.200.24.183]:4076 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264346AbUEXQr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 12:47:27 -0400
Date: Mon, 24 May 2004 09:46:31 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: class_device_find()
Message-ID: <20040524164630.GB1543@kroah.com>
References: <20040523002309.2ec5965e.zap@homelink.ru> <20040524051303.GC27371@kroah.com> <20040524103921.7957533a.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524103921.7957533a.zap@homelink.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 10:39:21AM +0400, Andrew Zabolotny wrote:
> The class_device_find() function returns a pointer to a class_device, but the
> reference counter of that object is not incremented. This looks to me somewhat
> racy, unless there are some details I'm missing.

There were lots of problems with that function, and that's one reason
it's not in the kernel tree :)

> Because in the first case if class_device_get succeeds, but class_id is empty,
> the kobject will remain in a referenced state.

Good catch.  But your fix is not quite correct, we should call
class_device_put() on the class_dev variable before returning -EINVAL
instead.

> I know patches are preferred, but our CVS is down right now and I don't have
> an older copy of class.c.

Patches are preferred.

> And yet one more comment. What is the purpose of class_device_get at the
> beginning and class_device_put at the end of the above function? I think if
> someone calls class_device_rename, then it already holds a reference to the
> class_device, so it can't go away while class_rename() is doing its work. And
> if the caller *doesn't* hold a lock on it, it is simply wrong code since the
> device may easily go away before class_rename() gets the lock.

We are just being safe.

thanks,

greg k-h
