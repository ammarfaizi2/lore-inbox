Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWDXEyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWDXEyO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 00:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWDXEyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 00:54:14 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:55442 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750723AbWDXEyO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 00:54:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aI7VDeo3aWBA7j7+0TYuZhtnuIU4mUyQVon9Nj3jEFQ/cRLIT3g0HKLc1nhjMJZHTwziO7bxahuAYUJHq4JtZA45r0cr632q3VKf71lj3sOykG7hGpwjsoSwW3aJMUKYQPHmhApTVTYzMN8NRO43ajnO4vDxNmc6pJzeyexmh3g=
Message-ID: <bda6d13a0604232154r28f23212o55b15a065fe6d648@mail.gmail.com>
Date: Sun, 23 Apr 2006 21:54:13 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Filesystem & mutex
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My filesystem has need of an extra mutex in the extended inode data area.
>From what I understand, the mutex can be initalized in inode_init_once, but
I cannot determine how to free it.

It looks wrong to destroy the mutex by just destroying the slab.
It is wrong to destroy the inode in destroy_inode. Badness when
an inode is reused.

I really don't want to go back to semaphores. The mutex code just *looks* so
much cleaner.
