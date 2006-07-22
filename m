Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWGVHll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWGVHll (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 03:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWGVHll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 03:41:41 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:32138 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751338AbWGVHll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 03:41:41 -0400
Subject: Re: [RFC/PATCH] revoke/frevoke system calls
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andrew Morton <akpm@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, tytso@mit.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, tigran@veritas.com,
       viro@zeniv.linux.org.uk
In-Reply-To: <20060721235931.e8336001.akpm@osdl.org>
References: <Pine.LNX.4.58.0607201504040.18901@sbz-30.cs.Helsinki.FI>
	 <20060721171922.602706f9.akpm@osdl.org>
	 <Pine.LNX.4.58.0607220918070.13537@sbz-30.cs.Helsinki.FI>
	 <20060721235931.e8336001.akpm@osdl.org>
Date: Sat, 22 Jul 2006 10:41:39 +0300
Message-Id: <1153554099.5589.9.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 22 Jul 2006 09:22:37 +0300 (EEST)
Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> > There are alternatives, playing games with ->f_op, creating fake struct 
> > file, and doing IS_REVOKED if-else in the paths, but I think this is by 
> > far the simplest way to do it. So in the Andrew scale of sads, how 
> > sad is it, exactly?-)

On Fri, 2006-07-21 at 23:59 -0700, Andrew Morton wrote:
> Sad enough.  Certainly worth an if-else to fix.

Actually, we can fix it with file->f_light thing Tigran is doing:

http://developer.osdl.org/dev/fumount/kernel2/patches/2.6.12/1/forced-unmount-2.6.12-1.patch

On Fri, 2006-07-21 at 23:59 -0700, Andrew Morton wrote:
> Why is this approach so different from Tigran's, I wonder.

Not so different. I am blocking fork until I can revoke all open file
descriptors (i.e. substitute with NULL) whereas Tigran is dropping
tasklist_lock and retrying. I am not doing get_bad_file() because I
don't think we really need it. Tigran's mmap takedown code looks pretty
much what I want too.

On Fri, 2006-07-21 at 23:59 -0700, Andrew Morton wrote:
> iirc, one of the things we added file.f_mapping for was revokation, but
> this patch doesn't use it.  Please ask Al Viro about this.

I searched fsdevel archives but couldn't find anything on that. Al?

				Pekka

