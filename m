Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVKDRTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVKDRTO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVKDRTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:19:14 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:44119 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750741AbVKDRTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:19:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=evrTt8SMOFE4ld3toyVOKBjKH36M+JgFrxdnuioBVSGfv9KM9Ecpr8eIUtnNlfRKKr2Em9Mi9ww+WaHZLouzIbqZjMO4FS3vMf2L53Ax64r0oeQDe9m9e0V4LwWvzi4dp3aWx/9FO/BInfN/se7vuuljkSSvWktOiIWqGNtOq+M=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Fri, 4 Nov 2005 18:18:03 +0100
User-Agent: KMail/1.8.3
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Yasunori Goto <y-goto@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
References: <1130917338.14475.133.camel@localhost> <200511040426.47043.blaisorblade@yahoo.it> <200511040950.59942.rob@landley.net>
In-Reply-To: <200511040950.59942.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511041818.04397.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Note - I've removed a few CC's since we're too many ones, sorry for any 
inconvenience).

On Friday 04 November 2005 16:50, Rob Landley wrote:
> On Thursday 03 November 2005 21:26, Blaisorblade wrote:
> > > I was hoping that since the file was deleted from disk and is already
> > > getting _some_ special treatment (since it's a longstanding "poor man's
> > > shared memory" hack), that madvise wouldn't flush the data to disk, but
> > > would just zero it out.  A bit optimistic on my part, I know. :)
> >
> > I read at some time that this optimization existed but was deemed
> > obsolete and removed.
> >
> > Why obsolete? Because... we have tmpfs! And that's the point. With
> > DONTNEED, we detach references from page tables, but the content is still
> > pinned: it _is_ the "disk"! (And you have TMPDIR on tmpfs, right?)
>
> If I had that kind of control over environment my build would always be
> deployed in (including root access), I wouldn't need UML. :)
Yep, right for your case... however currently the majority of users use tmpfs 
(I hope for them)...

> > I guess you refer to using frag. avoidance on the guest
>
> Yes.  Moot point since Linus doesn't want it.
See lwn.net last issue (when it becomes available) on this issue. In short, 
however, the real point is that we need this kind of support.

> Might be a performance issue if that gets introduced with per-page
> granularity,
I'm aware of this possibility, and I've said in fact "Frag. avoidance will be 
nice to use". However I'm not sure that the system call overhead is so big, 
compared to flushing the TLB entries...

But for now we haven't the issue - you don't do hotunplug frequently. When 
somebody will write the auto-hotunplug management daemon we could have a 
problem on this...
> and how do you avoid giving back pages we're about to re-use? 

Jeff's trick is call the buddy allocator (__get_free_pages()) to get a full 
page (and it will do any needed work to free memory), so nobody else will use 
it, and then madvise() it.

If a better API exists, that will be used.

> Oh well, bench it when it happens.  (And in any case, it needs a tunable to
> beat the page cache into submission or there's no free memory to give back.
I couldn't parse your sentence. The allocation will free memory like when 
memory is needed.

However look at /proc/sys/vm/swappiness or use Con Kolivas's patches to find 
new tunable and policies.
> If there's already such a tuneable, I haven't found it yet.)
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
