Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132359AbRDGB1C>; Fri, 6 Apr 2001 21:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132370AbRDGB0v>; Fri, 6 Apr 2001 21:26:51 -0400
Received: from [166.70.28.69] ([166.70.28.69]:28752 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S132359AbRDGB0j>;
	Fri, 6 Apr 2001 21:26:39 -0400
To: Christopher Turcksin <turcksin@raleigh.ibm.com>
Cc: "Miller, Brendan" <Brendan.Miller@Dialogic.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: How to build modules outside the kernel tree? [Was: Proper way to release binary driver?]
In-Reply-To: <EFC879D09684D211B9C20060972035B1D46A39@exchange2ca.sv.dialogic.com> <m1g0fnwoo0.fsf@frodo.biederman.org> <3ACDE5C5.CEB65D4A@raleigh.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Apr 2001 19:24:54 -0600
In-Reply-To: Christopher Turcksin's message of "Fri, 06 Apr 2001 16:50:29 +0100"
Message-ID: <m1y9tdv6vt.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Turcksin <turcksin@raleigh.ibm.com> writes:

> "Eric W. Biederman" wrote:
> 
> > If what you are after is a way to release a driver that is not a
> > hassle to add to an already working system, you will find a more
> > receptive ear.  I have heard some talk, that it would be a good idea
> > to figure out how to standardize how to compile a kernel driver
> > outside the kernel tree, so it could be trivial enough that anyone
> > could do it.  To date there are enough people around who don't have
> > problems compiling their own kernel that this hasn't become a major
> > issue.
> 
> Eric,
> 
> I am finding myself exactly in this situation, and I've got a feeling
> that this won't be the last time either.
> 
> I expect that every future Linux driver I get involved with will be
> released under GPL. However, I think that the majority of our customers
> will be running a distribution that does not yet support a new driver,
> and even at Linux speeds, it'll take a long enough time that customers
> cannot afford to wait for the next release that includes the driver.
> 
> So the big issue for us appears to be how we support these customers.
> 
> There is no way that we can support customers who have custom kernels,
> but since they are 'in it' enough to compile their own kernel, I guess
> they're able to apply our patch and recompile it. I actually suspect
> that there aren't that many who do this anyway.
>
> Where we find we have a problem is the number of different 'standard'
> kernels out there. We find that we need to support all releases since
> the last year or so for each distribution. And for each of those, we
> find that there are many different kernel versions (some bugfixes, some
> provide half a dozen different kernels with the CDs, aso.). And since we
> do not expect these customers to compile their own kernel, we see no
> option but to provide a precompiled binary driver. The numbers multiply
> quickly and building all of those becomes an interesting problem.
> 
> We had hoped that MODVERSIONS would allow us to provide a single (or at
> most a few) binary driver. Kernels with even minor version numbers are
> supposed to be stable (even if they are buggy) ie. not have wildly
> changing kernel interfaces.
> 
> In practice, that doesn't work. A driver compiled with 2.2.16 doesn't
> load with 2.2.16-5.0 (from RedHat 6.2) (just an example). 

It's a good example of the problems, but a bad example of problems
caused be kernel maintenance.  

RedHat does not run stock linux kernels, but instead seems to patch
the kernel to include work-around for various known bugs and
deficiencies.  What this means is that they are more willing than the
mainstream kernel developers to include changes to the kernel.  A
example that comes to mind are the md drivers that implement software
raid. 

So for solutions (That I know of):

With recent kernels with modules_install a:
 /lib/modules/`uname -r`/build
directory is created, that effectively points to the kernel source
tree the modules were built with.  With the 2.4.x currently this is a
symlink so but it should be o.k.  It needs to be checked that the
distributors are using this directory appropriately, but it looks like
a good thing to support.  Longterm this looks like a solution
to the problem, of how to get kernel headers to match a kernel.  

This should even has a chance to work with people who build their own
kernel.

With Redhat and many derivatives as a fallback there is kernel source in 
/usr/src/linux that does it's best to match the currently running
kernel.

Using either of those locations for the source to kernel headers it
should be possible to build a package that as part of it's install
process compiles appropriate drivers, at least for most of the cases.

I suspect there is enough work in this for someone to create a support
package, that included makefiles and all the rest to assist in
building a drivers on various platforms.  Any takers?

Eric.






