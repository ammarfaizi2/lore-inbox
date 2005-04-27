Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVD0Rmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVD0Rmo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVD0Rkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:40:42 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:34045 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261841AbVD0RkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:40:05 -0400
Subject: Re: [PATCH] private mounts
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lmb@suse.de, mj@ucw.cz, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1DQqQ0-0002PB-00@dorka.pomaz.szeredi.hu>
References: <20050426094727.GA30379@infradead.org>
	 <20050426131943.GC2226@openzaurus.ucw.cz>
	 <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu>
	 <20050426201411.GA20109@elf.ucw.cz>
	 <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu>
	 <20050427092450.GB1819@elf.ucw.cz>
	 <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu>
	 <20050427143126.GB1957@mail.shareable.org>
	 <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu>
	 <20050427153320.GA19065@atrey.karlin.mff.cuni.cz>
	 <20050427155022.GR4431@marowsky-bree.de>
	 <E1DQqQ0-0002PB-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1114623598.4480.181.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 27 Apr 2005 10:39:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-27 at 10:33, Miklos Szeredi wrote:
> > It is certainly an information leak not otherwise available. And with
> > the ability to change the layout underneath, you might trigger bugs in
> > root programs: Are they really capable of seeing the same filename
> > twice, or can you throw them into a deep recursion by simulating
> > infinitely deep directories/circular hardlinks...?
> 
> Circular or otherwise hardlinked directories are not allowed since it
> would not only confuse applications but the VFS as well.
> 
> Hmm, looking at the code it seems that for some reason I removed this
> check from the 2.6 version of FUSE.  Stupid me!
> 
> Thanks for the reminder :)
> 
> > Certainly a useful tool for hardening applications, but I can see the
> > point of not wanting to let unwary applications run into a namespace
> > controlled by a user. Of course, this is sort-of similar to "find
> > -xdev", but I'm not sure whether it is not indeed new behaviour.
> 
> A trivial DoS against any process entering the userspace filesystem is
> just not to answer the filesystem request.
> 
> So it's not just information leak, but also a fine way to _control_
> certain behavior of applications.
> 

I think you need to disallow overmounts on invisible mounts by any user
other than the owner. If not, some other user (including root) can
overmount on your mount and the user will end up with DoS.

RP

> Thanks,
> Miklos
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

