Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264845AbTIDUPs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264848AbTIDUPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:15:48 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:29400 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S264845AbTIDUPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:15:42 -0400
From: James Clark <jimwclark@ntlworld.com>
Reply-To: jimwclark@ntlworld.com
To: Albert Cahalan <albert@users.sf.net>
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Date: Thu, 4 Sep 2003 21:14:45 +0100
User-Agent: KMail/1.5
References: <1062637356.846.3471.camel@cube>
In-Reply-To: <1062637356.846.3471.camel@cube>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309042114.45234.jimwclark@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for this (and the few other) sensible appraisal of my 'proposal'. 

I'm very surprised by the number of posts that have ranted about Open/Close 
source, GPL/taint issues etc. This is not about source code it is about 
making Linux usable by the masses. It may be technically superior to follow 
the current model, but if the barrier to entry is very high (and it is!) then 
the project will continue to be a niche project. A binary model doesn't alter 
the community or the benefits of public source code. I agree that it is an 
extra interface and will carry a performance hit - I think this is worth it. 
Windows has many faults but drivers are often compatible across major 
releases and VERY compatible across minor releases. It is no accident that it 
has 90% of the desktop market. If we are going to improve this situation this 
issue MUST be confronted.

I am currently collating the arguments for and (mostly) against the idea. If I 
don't get flamed in the meantime I may come back with more...

James



On Thursday 04 Sep 2003 2:02 am, you wrote:
> > Following my initial post yesterday please find attached my
> > proposal for a binary 'plugin' interface:
>
> There was one, called UDI. It was rejected.
>
> > I believe that sometimes the ultimate goals of stability and
> > portability get lost in the debate on OSS and desire to allow
> > anyone to  contribute.
>
> If "stability" means "no changes", then don't upgrade
> for a few years.
>
> If "stability" means "no crashes", then a binary
> interface is harmful. Extra layers mean extra bugs,
> and the layers make debugging more difficult.
>
> Portability??? Linux beats every other OS for that.
>
> > 3. Design 'plugin' interface to be extensible as possible
> > and then rarely remove support from interface. Extending
> > interface is fine but should be done in a considered way
> > to avoid interface bloat. Suggest interface supports
> > dependant 'plugins'
>
> Removal of crud is important. We keep things simple,
> fast, and small.
>
> > 4. Allow 'plugins' to be bypassed at boot - perhaps a
> > minimal 'known good' list
>
> This works already. Put "init=/bin/bash" on the kernel
> command line (at the lilo, grub, or syslinux prompt) and
> you will bypass all of the start-up scripts. That will
> cause you to skip any modules (drivers, plugins, whatever)
> that would be loaded by your boot scripts.
>
> > 5. Ultimately, even FS 'plugins' could be created
> > although IPL would be required to load these.
>
> IPL is some old IBM mainframe term. In the Linux and
> UNIX world we call it boot, bootstrap, start-up, etc.
>
> We can already make our filesystem a loadable module.
> Your boot loader (lilo, grub, or syslinux) has the
> ability to load an "initrd". This gives you something
> kind of like a ramdisk, but without the wasted space.
> The scripts on the initrd can then load drivers for
> your disk (IDE, SCSI, etc.) and filesystem (ext2, ext3,
> reiserfs, reiser4, jfs, xfs, etc.). After the drivers
> are loaded, there's a mount() syscall, a pivit_root()
> syscall... and soon enough the initrd is gone and you
> have the real root filesystem mounted.
>
> > 1. Make Linux easier to use
>
> I doubt it. There would be a promise of binary
> compatibility that wouldn't be possible to maintain.
> Microsoft fails often enough; notice how Win98
> broke SCSI drivers that people were using.
>
> Without such a promise, people don't grow to depend
> on an interface that ultimately can't be supported.
>
> > 2. The ability to replace even very core Kernel
> > components without a restart.
>
> That's a fantasy, more-or-less. Binary patches can
> be done on a case-by-case basis at great expense.
> Novell did it sometimes. Microsoft didn't even try.
>
> > 3. Allow faulty 'plugins' to be fixed/replaced in
> > isolation. No other system impact.
>
> Linux supports this as well as can be. Any driver
> (module, plugin, whatever) has the ability to crash
> your system BY DEFINITION of having the necessary
> power to control your hardware.
>
> > 4. 'Plugins' could create their own interfaces as
> > load time. This would remove the need to pre-populate /dev.
>
> We have this as an option; we call it devfs.
> It has a problem: permission changes will not
> persist across a reboot.
>
> > 5. Remove need for joe soap user to often recompile Kernel.
>
> Already done: buy a CD-ROM from Red Hat
>
> > 6. Remove link between specific module versions
> > and Kernel versions.
>
> It's partly done (optional), and partly not desireable.
>
> > 7. Reduce need for major Kernel releases. Allow effort
> > to concentrate on improving Kernel not maintaining
> > ever increasing Kernel source that includes support
> > for the 'Kitchen Sink'
>
> No. It's damn nice to have all the source code in one
> place, all updated together, supporting whatever old
> hardware one may have.
>
> It's only recently (2.5.xx kernel series) that Linux
> dropped support for the PC-XT hard drive interface.
> Know what that is? It was introduced around 1981 maybe.
> Support was only dropped because all the disks have died.
>
> > 8. Make core Kernel more stable. Less releases and
> > less changes mean less bugs. It would be easy to
> > identify offending 'plugin' by simply starting up
> > the Kernel with it disabled.
>
> We can do this now. It's not a kernel issue though.
> Starting up with things disabled is a feature of
> your boot scripts, which are provided by your Linux
> distribution. See your Red Hat documentation, or
> your SuSE documentation, etc.
>
> > 9. Remove need for modules to be maintained in
> > sync with each Kernel thus  freeing 'module' developers
> > to add improved features or work on new projects.
>
> Then nobody would maintain them.

