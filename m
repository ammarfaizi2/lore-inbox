Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267440AbUG2VGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267440AbUG2VGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267435AbUG2VFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:05:43 -0400
Received: from lakermmtao01.cox.net ([68.230.240.38]:21985 "EHLO
	lakermmtao01.cox.net") by vger.kernel.org with ESMTP
	id S267437AbUG2VEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:04:20 -0400
In-Reply-To: <20040729142556.GC17942@fieldses.org>
References: <Xine.LNX.4.44.0407290116340.13892-100000@dhcp83-76.boston.redhat.com> <D92C5330-E15C-11D8-9EC8-000393ACC76E@mac.com> <20040729142556.GC17942@fieldses.org>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DBCAE8F8-E1A2-11D8-885A-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: James Morris <jmorris@redhat.com>,
       lkml List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Preliminary Linux Key Infrastructure 0.01-alpha1
Date: Thu, 29 Jul 2004 17:04:19 -0400
To: "J. Bruce Fields" <bfields@fieldses.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 29, 2004, at 10:25, J. Bruce Fields wrote:
> Could you summarize the differences?

- David Howells' patch has a lot of special cases, a keyring isn't just
another registered keytype, whereas I use a flexible enough keytype
system that "keyrings" are normal keys with a key->type pointer to
struct key_type keyring_type = { ... };

- David Howells' patch isn't built to really allow processes to safely
share keys with each other, whereas I have a separate type called
"struct key_handle" that can be copied and still properly revoked.
(All the copies of the handle are revoked when the handle itself  is
revoked, but not the one that created said handle)

> I'd really like to start looking at these patches and figure out how
> we'd use them for NFS/rpcsec_gss, but this is made more difficult by
> the fact that there are now 2 or 3 different pieces of code floating
> around now that all claim to do PAG/keyring stuff.

Right now it's still kind of like the scheduler stuff, it's easy to 
write
your own version, so there are a couple people maintaining their
own code to try out new ideas.  Personally I am not quite happy
with the architecture of some parts of David Howells' code, and I
wanted more architectural freedom so I started my own patch. In
a couple weeks or so I'll be done fooling around in my own little
world trying out ideas and maybe have some reasonably decent
patches.

I'll be gone next week, but I hope to continue this discussion
when I get back.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


