Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262795AbTC0DbT>; Wed, 26 Mar 2003 22:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbTC0DbT>; Wed, 26 Mar 2003 22:31:19 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:54000 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S262795AbTC0DbS>; Wed, 26 Mar 2003 22:31:18 -0500
Date: Wed, 26 Mar 2003 19:53:17 -0800
From: David Brownell <david-b@pacbell.net>
Subject: 2.5.recent: device_remove_file() doesn't
To: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Message-id: <3E8275AD.40603@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that recent kernels don't clean up device
attribute files correctly when they're removed.  Instead,
they're left in the directory with a refcount of zero.

That refcount stays even when the file is recreated later;
and the contents can be read.  Delete them again, and now
the refcount is 65535 ... though now reading the contents
may cause oopsing.

This worked correctly at some point last month:  the file
no longer appeared in sysfs after deletion.

Got Patch?

- Dave


