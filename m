Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263210AbTCNBxv>; Thu, 13 Mar 2003 20:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263216AbTCNBxu>; Thu, 13 Mar 2003 20:53:50 -0500
Received: from cs.columbia.edu ([128.59.16.20]:46802 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S263210AbTCNBxt>;
	Thu, 13 Mar 2003 20:53:49 -0500
Subject: Re: fork/sh/hello microbenchmark performance in chroot
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1047606869.7428.12.camel@zaphod>
References: <1047606184.10046.9.camel@zaphod>
	 <1047606869.7428.12.camel@zaphod>
Content-Type: text/plain
Organization: 
Message-Id: <1047607433.7428.23.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 21:03:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

and a little more followup.  The chroot is basically a machine's fs's
mounted over nfs over an ipsec tunnel

/chroot/"filesystems"

when I run it /chroot/tmp/benchmark/forksh, I get .2s

but when I chroot into the /chroot tree and run /tmp/benchmark/forksh I
get 1s.

If I make the chroot tree just composed of mount -o bind'd fs from the
host machine, I don't see the slow down.

so to recap

plain linux, local filesystems - it's fine
plain linux, nfs over ipsec filesystems - it's fine
chrooted linux, local filesystems - it's fine
chrooted linux, nfs over ipsec filesystems - it's very slow.

thanks,

shaya

On Thu, 2003-03-13 at 20:54, Shaya Potter wrote:
> in a followup, the only thing I can tell difference b/w the 2 runs
> (under strace and inside and outside of the chroot) is that within the
> chroot, after every fork() I see a SIGSTOP on the child.
> 
> anyone have any idea why this is happening?
> 
> On Thu, 2003-03-13 at 20:43, Shaya Potter wrote:
> > I'm trying to play with our a homebrew version of lmbench's fork
> > benchmark which exec's sh to run a "hello world" program.  On normal
> > 2.4.18 (UP 933mhz p3) it runs in about .2s  However, within a chrooted
> > environment I'm looking at 1s.
> > 
> > Anyone knows why this runs significantly slower within a chroot?
> > 
> > thanks,
> > 
> > shaya
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

