Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTENJtd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 05:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbTENJtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 05:49:32 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:50593 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261783AbTENJtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 05:49:31 -0400
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, Jeff Garzik <jgarzik@pobox.com>,
       dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PAG support only
References: <18809.1052905491@warthog.warthog>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 14 May 2003 19:01:51 +0900
In-Reply-To: <18809.1052905491@warthog.warthog>
Message-ID: <buok7ctu9rk.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@warthog.cambridge.redhat.com> writes:
> So you'd rather have:
> 
> 		if (pag > 0)
> 			return vfs_join_pag(pag);
> 		else if (pag == 0)
> 			return vfs_leave_pag();
> 		else if (pag == -1)
> 			return vfs_new_pag();
> 		else
> 			return -EINVAL;
>
> Than:
>
> 		if (pag > 0)		return vfs_join_pag(pag);
> 		else if (pag == 0)	return vfs_leave_pag();
> 		else if (pag == -1)	return vfs_new_pag();
> 		else			return -EINVAL;
>
> When the former is _far_ less readable at a glance?

Keep in mind that `readable' also means that someone used to the
kernel's coding style, but not to your particular portion, should
naturally be able to follow the code with as little trouble as possible.
While I agree that your second example is more clear once one sees
what's going on (and it's certainly prettier in some sense), the `shape'
is unusual, so it takes some adaptation on the part of the reader to
make this jump, and that's something to be avoided if possible.

My personal feeling is that (1) there are exceptional cases where the
rules should be broken, and (2) but not that many.

These exceptional cases usually stick out like a sore thumb, and if
there's any doubt, it's probably not one.

-Miles
-- 
We live, as we dream -- alone....
