Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422821AbWHYCI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422821AbWHYCI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 22:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422816AbWHYCI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 22:08:29 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:1708 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751625AbWHYCI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 22:08:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jbD7aNcxhkvz7jwV7+L6fzjYNoRYjyDSdT5OgCTv1/6kmnlA0Swg4tUcDvh/z9vs6ZsmpY4c2ZMlmYRAVsiEzixFOGrdRQDEXpyoPYg2c4qj0x1gOxclWsubBG4y1aBXPD2c55D4Jn11ZiGaRoZd0eTwZs7TSLfwEfrFdqDI80o=
Message-ID: <4ae3c140608241908v7a181b38yedc16183ddf44960@mail.gmail.com>
Date: Thu, 24 Aug 2006 22:08:20 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Why generic_fillattr() is not protected with a lock?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed that almost all local disk file systems use the default
vfs_getattr()->generic_fillattr() to get file attributes. However,
vfs_getattr()->generic_fillattr() is not protected by a lock. Is this
problematic?

Suppose process A is getting file attributes, after it read the
"mtime" and before it read the i_size, the process is scheduled out,
and another process B cuts in, change the file, and cause the change
on file size. After A is switched back, it goes ahead to read the rest
fields. Now it will have an old "mtime" but a new "i_size".

Is this scenario possible? If so, will this cause serious problem to
the file system?

Thanks,
Xin
