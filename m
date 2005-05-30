Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVE3THB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVE3THB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVE3THB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:07:01 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:56760 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261696AbVE3TGw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:06:52 -0400
Subject: Re: [RFC][PATCH] rbind across namespaces
From: Ram <linuxram@us.ibm.com>
To: Mike Waychison <mikew@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jamie Lokier <jamie@shareable.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <42936CA4.1020905@google.com>
References: <1116627099.4397.43.camel@localhost>
	 <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
	 <1116660380.4397.66.camel@localhost>
	 <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu>
	 <20050521134615.GB4274@mail.shareable.org>
	 <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu> <429277CA.9050300@google.com>
	 <E1DaSCb-0003Tw-00@dorka.pomaz.szeredi.hu> <4292D416.5070001@waychison.com>
	 <E1DaUj1-0003eq-00@dorka.pomaz.szeredi.hu> <42935FCB.1010809@google.com>
	 <E1DadFv-0004Te-00@dorka.pomaz.szeredi.hu> <42936807.2000807@google.com>
	 <E1DaddR-0004Ws-00@dorka.pomaz.szeredi.hu>  <42936CA4.1020905@google.com>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1117479979.4359.62.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 30 May 2005 12:06:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-24 at 11:04, Mike Waychison wrote:
> Miklos Szeredi wrote:
> >>So you'd say 'mount /dev/foo /proc/self/fd/4' if 4 was an fd pointing to 
> >>a directory in another namespace?
> >>
> >>That does require proc_check_root be removed.  :\
> > 
> > 
> > Or just make an exception to self?
> > 
> > proc_check_root() could begin with:
> > 
> > 	if (current == proc_task(inode))
> > 		return 0;
> > 
> > For all other tasks it would still be effective.
> > 
> 
> Yes, I think something like that is workable :)
> 
> (we still have to fix up all the namespace->sem locking.  I have yet to 
> review Ram's patch.)

Yes. This patch is not fully ready yet. It still has to take care of
using the correct namespace sems for operations like umount/move etc.

Have been recently busy with shared subtree coding. Will work on this
to remove all the assumptions in the code that think 'a process can
access only its own namespace'. 
RP
> 
> Mike Waychison
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

