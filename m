Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbUL1CVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbUL1CVn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 21:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbUL1CVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 21:21:43 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:61835 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262017AbUL1CVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 21:21:40 -0500
Date: Tue, 28 Dec 2004 03:21:39 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-VServer <vserver@list.linux-vserver.org>
Subject: Re: The Future of Linux Capabilities ...
Message-ID: <20041228022139.GA16185@mail.13thfloor.at>
Mail-Followup-To: Ulrich Drepper <drepper@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux-VServer <vserver@list.linux-vserver.org>
References: <20041227014041.GA30550@mail.13thfloor.at> <a36005b5041227152268e68af9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b5041227152268e68af9@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 03:22:32PM -0800, Ulrich Drepper wrote:
> On Mon, 27 Dec 2004 02:40:41 +0100, Herbert Poetzl <herbert@13thfloor.at> wrote:
> >   II)   add 32 (or more) sub-capabilities which depend
> >         on the parent capability to be usable, and add
> >         appropriate syscalls for them.
> > 
> >         example: CAP_IPC_LOCK gets two subcapabilities
> >         (e.g. SCAP_SHM_LOCK and SCAP_MEM_LOCK) which
> 
> I won't try to say anything about III, but I is not really suitable,
> it breaks code currently using capabilities.  Or at least makes them
> less secure.  

let me assure you that III) does neither break the existing code
nor reduce security, for the following reasons:

  a) the per process capability is a requirement for
     _all_ subcapabilities (when the cap is in the cap_mask)

  b) the capability system isn't changed for caps not
     in the cap_mask

  c) reducing a cap by removing a subcapability can only
     increase security not lower it

> With sub-capabilities the interface diverges from the
> POSIX capabilities interfaces, but at least one can keep backward
> compatibilities.

to some extend, yes ...

> An alternative would be to keep the existing capabilities, and add new
> ones for all the cases which need splitting.  If the old value is
> set/reset, all the split-out values are "magically" affected as well. 

I consider the 'magically' part another solution I didn't
list in my previous mail, but it is a kind of variation
from II) where we do not necessarily need subcaps for _all_
aspects of a capability (as a matter of fact it's one less)

> This would help keeping the interfaces in line with POSIX and no
> additions to the userlevel libcap would be needed.  Yes, new cap[gs]et
> syscalls would be needed, but this fact is hidden from the user.

I guess it might be doable, although the 'magically' part
would require to keep masks for all caps which got split
to select the corresponding sub-capabilities ...

thanks,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
