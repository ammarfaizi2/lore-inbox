Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270012AbUJHPUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270012AbUJHPUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270008AbUJHPUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:20:13 -0400
Received: from oceanite.ens-lyon.fr ([140.77.1.22]:1422 "EHLO
	oceanite.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S270012AbUJHPTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:19:06 -0400
Message-ID: <4166AFD0.2020905@ens-lyon.fr>
Date: Fri, 08 Oct 2004 17:18:40 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from inside
 kernel
References: <20041008130442.GE5551@lkcl.net> <41669DE0.9050005@didntduck.org> <20041008151837.GI5551@lkcl.net>
In-Reply-To: <20041008151837.GI5551@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  call sys_rename, sys_pread, sys_create, sys_mknod, sys_rmdir
>  etc. - everything that does file access.

If you ever actually call sys_this or sys_that ... from
the kernel, you'll have to do something like this to avoid
copy_from/to_user to fail because the target buffer is not
in kernel space:

mm_segment_t old_fs;
old_fs = get_fs();
set_fs(KERNEL_DS);
<do you stuff here>
set_fs(old_fs);

Just look for set_fs in the kernel source to find examples.
--
Brice Goglin
================================================
Ph.D Student
Laboratoire de l'Informatique et du Parallélisme
CNRS-ENS Lyon-INRIA-UCB Lyon
France
