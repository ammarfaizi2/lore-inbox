Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVEUIpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVEUIpo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 04:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVEUIpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 04:45:44 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:24218 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261469AbVEUIpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 04:45:31 -0400
Subject: Re: [RFC][PATCH] rbind across namespaces
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       jamie@shareable.org
In-Reply-To: <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu>
References: <1116627099.4397.43.camel@localhost>
	 <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
	 <1116660380.4397.66.camel@localhost>
	 <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1116665101.4397.71.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 May 2005 01:45:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-21 at 01:09, Miklos Szeredi wrote:
> > Enclosed the simplified patch,
> 
> Looks much better :)
> 
> I still see a problem: what if old_nd.mnt is already detached, and
> bind is non-recursive.  Now it fails with EINVAL, though it used to
> work (and I think is very useful).

I am not getting this comment.  R u assuming that a detached mount
will have NULL namespace?  If so I dont see it being the case.
Or am I missing some subtle point?


> When doing up_write(...) you don't have to keep the order, just check
> if the namespaces are not equal for the second up_write().

Yes. saves atleast 2 lines. 

> 
> And why don't you do this:
> 
> 	if (old_ns < mntpt_ns)
> 		down_write(&old_ns->sem);
> 
> instead of this
> 
> 	if (old_ns < mntpt_ns) {
> 		down_write(&old_ns->sem);
> 	}

Will do. Saves another few lines. :)

I will send out the new patch once I understand your first comment.
RP

> 
> Miklos

