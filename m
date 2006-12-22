Return-Path: <linux-kernel-owner+w=401wt.eu-S1752863AbWLVVab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbWLVVab (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 16:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbWLVVab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 16:30:31 -0500
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:3231 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752863AbWLVVaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 16:30:30 -0500
Date: Fri, 22 Dec 2006 22:30:34 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Thomas Meyer <thomas@m3y3r.de>, Linus Torvalds <torvalds@osdl.org>,
       Steve French <sfrench@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WARNING: "test_clear_page_dirty" [fs/cifs/cifs.ko] undefined!
Message-Id: <20061222223034.b29aeb5f.khali@linux-fr.org>
In-Reply-To: <458BEB9D.8030709@m3y3r.de>
References: <458BEB9D.8030709@m3y3r.de>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006 15:28:45 +0100, Thomas Meyer wrote:
> Again current git head:
> 
> I guess this should be fixed by someone!
> 
> WARNING: "test_clear_page_dirty" [fs/cifs/cifs.ko] undefined!
> make[1]: *** [__modpost] Fehler 1
> make: *** [modules] Fehler 2

This is caused by this commit:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fba2591bf4e418b6c3f9f8794c9dd8fe40ae7bd9

>From the log message:
"Some filesystems need to be fixed up for this: CIFS, FUSE, JFS,
ReiserFS, XFS all use the old confusing functions, and will be fixed
separately in subsequent commits (with some of them just removing the
offending logic, and others using clear_page_dirty_for_io())."

The approach seems quite broken to me, the users should have been fixed
_before_ removing the function, so as to avoid compilation failures.
These are a pain for testers, and break git bisect too. Grmbl.

Now that it's done... Steve, can you please take a look and provide a
patch so that cifs builds again?

Thanks,
-- 
Jean Delvare
