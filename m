Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286179AbSALMew>; Sat, 12 Jan 2002 07:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286184AbSALMeq>; Sat, 12 Jan 2002 07:34:46 -0500
Received: from theirongiant.weebeastie.net ([203.62.148.50]:38531 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S286179AbSALMec>; Sat, 12 Jan 2002 07:34:32 -0500
Date: Sat, 12 Jan 2002 23:34:23 +1100
From: CaT <cat@zip.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
Subject: Re: netfilter oops (Was: Re: Linux 2.4.18-pre2)
Message-ID: <20020112123423.GD5211@zip.com.au>
In-Reply-To: <20020112110438.GB7198@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020112110438.GB7198@zip.com.au>
User-Agent: Mutt/1.3.25i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 10:04:38PM +1100, CaT wrote:
> Just did a test and it's not masquerading that's causing it. I'll need
> to convert my filesystems to ext3 first because the crashes are not
> going to be healthy for this box (or me... 45gig HD involved on a
> pentium-200) and I'll experiment some more. It may be redirection
> that's doing it.

Ka-ching! Being able to use a fwded net connection without masq was the 
needed clue. I looked at the patches and found this one:

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal
linux-2.4.16/net/ipv4/netfilter/ip_fw_compat_redir.c
linux-2.4.17/net/ipv4/netfilter/ip_fw_compat_redir.c
--- linux-2.4.16/net/ipv4/netfilter/ip_fw_compat_redir.c        Sat Aug 5 06:07:24 2000
+++ linux-2.4.17/net/ipv4/netfilter/ip_fw_compat_redir.c        Thu Dec 27 12:46:11 2001
@@ -206,6 +206,8 @@
                        }
                        list_prepend(&redirs, redir);
                        init_timer(&redir->destroyme);
+                       redir->destroyme.expires = jiffies + 75*HZ;
+                       add_timer(&redir->destroyme);
                }
                /* In case mangling has changed, rewrite this part. */
                redir->core = ((struct redir_core)

As it appeared to deal directly with compatability redirection I removed
this one first and recompiled the kernel. Before, a minute or so of
browsing via a redirected connection (to squid) would make the box go
boom. I've just browsed for 15 minutes to different sites and the box
has not gone down.

Now, if you need the oops then holler and I'll see what I can do about
getting it to you. Writing it down would be a pain so I may opt for the
null-modem cable which may take a week or so for me to get at though.

-- 
SOCCER PLAYER IN GENITAL-BITING SCANDAL  ---  "It was something between
friends that I thought would have no importance until this morning when
I got up and saw all  the commotion in the news,"  Gallardo told a news
conference. "It stunned me."
Reyes told Marca that he had "felt a slight pinch."
