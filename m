Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132563AbRANMcB>; Sun, 14 Jan 2001 07:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132564AbRANMbv>; Sun, 14 Jan 2001 07:31:51 -0500
Received: from Cantor.suse.de ([194.112.123.193]:5644 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132563AbRANMbl>;
	Sun, 14 Jan 2001 07:31:41 -0500
Date: Sun, 14 Jan 2001 13:31:40 +0100
From: Andi Kleen <ak@suse.de>
To: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>,
        Harald Welte <laforge@gnumonks.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 + iproute2
Message-ID: <20010114133140.A23640@gruyere.muc.suse.de>
In-Reply-To: <20010114124659.A23188@gruyere.muc.suse.de> <Pine.LNX.4.30.0101141309160.16758-100000@jdi.jdimedia.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101141309160.16758-100000@jdi.jdimedia.nl>; from i.palsenberg@jdimedia.nl on Sun, Jan 14, 2001 at 01:13:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 01:13:16PM +0100, Igmar Palsenberg wrote:
> On Sun, 14 Jan 2001, Andi Kleen wrote:
> 
> > On Sun, Jan 14, 2001 at 03:36:55AM -0800, David S. Miller wrote:
> > >
> > > Andi Kleen writes:
> > >  > How would you pass the extended errors? As strings or as to be
> > >  > defined new numbers? I would prefer strings, because the number
> > >  > namespace could turn out to be as nasty to maintain as the current
> > >  > sysctl one.
> > >
> > > Textual error messages for system calls never belong in the kernel.
> > > Put it in glibc or wherever.
> >
> > This just means that a table needs to be kept in sync between glibc and
> > netlink, and if someone e.g. gets a new CBQ module he would need to update
> > glibc. It's also bad for maintainers, because patches for tables of number
> > tend to always reject ;)
> 
> Agree, but textual strings are bad. I want to say :
> 
> if (error) {
> 	perror("RTNETLINK");
> 	return -1;
> 	}
> 
> Using textual strings means you can't use standard functions. An option
> would be to extend the call so that if the userspace app wants to know
> what really went wrong he can ask the kernel.

That will not work. Consider an application that has multiple rtnetlink
sockets open, which each have own errors.

rtnetlink is such a radical interface for unix, adding a few more changes
for a different error reporting system probably does not make much difference.

my problem with keeping the textual error messages out of kernel is that
it means that three entities (kernel module, number table in kernel and 
external string table) need to be kept in sync. In practice that's usually
not the case.

David's /proc/errno_strings would only require keeping kernel table and
module in sync. 
Text errors for rtnetlink would localize it to the module itself. 
I could probably live with David's solution, although I would prefer the full
way. 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
