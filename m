Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030515AbWBIDOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbWBIDOp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 22:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030528AbWBIDOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 22:14:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22948 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030515AbWBIDOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 22:14:44 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] fix handling of st_nlink on procfs root
References: <E1F6vyO-00009r-3a@ZenIV.linux.org.uk>
	<m17j855om3.fsf@ebiederm.dsl.xmission.com>
	<20060209021749.GM27946@ftp.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Feb 2006 20:14:03 -0700
In-Reply-To: <20060209021749.GM27946@ftp.linux.org.uk> (Al Viro's message of
 "Thu, 9 Feb 2006 02:17:49 +0000")
Message-ID: <m1irrp441w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> writes:

> On Wed, Feb 08, 2006 at 06:04:36PM -0700, Eric W. Biederman wrote:
>> There are some other similar problems still in /proc.
>> 
>> In my pid namespace work I have some managed to clean most of
>> this up, and finally split proc into two filesystems.
>> 
>> The only was I was able to get the union to work was
>> to let lookup return files in an internal mount.
>> 
>> The only problem was that /proc/irq/..  != /proc/
>
> That's not the only problem here, unfortunately.

Well at the moment it seems to be.  Basically a case of everything
seems to work but the semantics are weird and ugly, and not worth
doing if the legacy semantics are not maintained.

>> I will finish all of this up shortly but do you know a good
>> way to do a union mount when we mount proc?
>
> Not transparently; mount(2) should _not_ mount two filesystems at once.
> Note that you'll run into serious problems as soon as you try to mount/umount/
> mount --move the stuff there.  And doing unionfs <spit> approach will cause
> fsckloads of fun issues with lifetimes.

:)

Do you know if there is anything in what autofs does for mounts that
could be reused.

To a certain extent it would work find if I had a mount point and
all of the legacy directories were symlinks to it.

Anyway there are lots of possibilities and I will work something
out before it makes into the stable kernel.

I keep having the feeling that I might just wind up with everything
making sense under proc as I create more namespaces :)

Eric
