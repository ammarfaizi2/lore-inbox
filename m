Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316765AbSFCN7O>; Mon, 3 Jun 2002 09:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSFCN7N>; Mon, 3 Jun 2002 09:59:13 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:37893 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316765AbSFCN7G>;
	Mon, 3 Jun 2002 09:59:06 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: If you want kbuild 2.5, tell Linus
Date: Mon, 03 Jun 2002 23:58:51 +1000
Message-ID: <3434.1023112731@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

I regret having to do this but Linus has left me with no other options.

Short form (read all of the long form before replying)

If you want a kernel build system that is :-

    Faster.
    Is easier to use for all cases.
    Easier to debug.
    Is fully documented.
    Has better error checking.
    Fully supports host programs and boot loaders as well as the kernel.
    Supports read only source tree.
    Supports separate source and object trees.
    Provides the data that Rusty needs to standardize boot and module parameters.
    Supports compilation of third party code.
    Copes with timestamp skew.
    Positions us for correct module symbol versions.
    Is automatic.
    Above all else, is 100% accurate.

Then tell Linus that you want kbuild 2.5.

Don't tell me, I already know.  Tell Linus, he is the bottleneck.

OTOH if you are happy with a kernel build system that is :-

    Slower.
    Is harder to use for special cases.
    Has almost no debugging facilities.
    Has out of date documentation.
    Has limited error checking.
    Has incomplete tracking for host programs and boot loaders.
    Might support read only source tree, one day.
    Might support separate source and object trees, one day.
    Might provide the data that Rusty needs, one day.
    Will not support compilation of third party code.
    Will never cope with timestamp skew.
    Is stuck with incorrect module symbol versions.
    Relies on manual intervention.
    Above all else, is demonstrably inaccurate.

Then do nothing and live with the restrictions of the existing kernel
build system.

It is a sad day when a fully tested and documented system that is
faster and, above all, more accurate, cannot get into the kernel.
Linus is judging kbuild 2.5 on its popularity and on personalities, not
on its technical merits.

======================================================================

Long form (read all of the long form before replying)

Q01.  Really 100% accurate?
A01.  Yes.  If not, it is a bug which I will fix.

      Many of the problems in the existing build system are in the too
      hard basket, errors are ignored because they are too difficult to
      fix.  Every known error in the existing build system has been
      corrected in kbuild 2.5.

Q02.  Really faster than the existing system?
A02.  Yes.  kbuild 2.5 provides more features, provides more
      information, is more robust and it still manages to be faster
      than the existing build system.  For sample timings, see

      http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-21/1208.html
      http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-21/1236.html

Q03.  How do I use kbuild 2.5?
A03.  Go to http://sourceforge.net/project/showfiles.php?group_id=18813
      and download at least three patches.  You need the latest -core
      patch, plus the common and architecture dependent patches for the
      kernel you are working on.  The current version of kbuild 2.5 is
      Release 3.0, that may change.

      Read the start of each patch for any special instructions.  In
      general you apply -core, -common and $(ARCH) patches in that
      order to a clean kernel to get kbuild 2.5 support.

      After applying the patches, I suggest you read the copious notes
      in Documentation/kbuild/kbuild-2.5.txt.  For the impatient :-

      Build in the same tree as the source.

        cd source/tree
        make -f Makefile-2.5 oldconfig installable

      Build in a separate object tree.

        export kbuild_OBJTREE=/full/path/to/object/tree
        export kbuild_SRCTREE_000=/full/path/to/source/tree
        make -f $kbuild_SRCTREE_000/Makefile-2.5 oldconfig installable

      Add -jN as required.  Unlike the existing build system, kbuild
      2.5 is parallel safe.

      If you do not specify any target on the command line, the default
      is 'installable', i.e. build a complete system ready to install.
      If you have already built the config, just do

        make -f $kbuild_SRCTREE_000/Makefile-2.5

Q04.  Why are there multiple patches?
A04.  The -core code implements all the hard work of kbuild 2.5.  The
      core is independent of the kernel, it will even run on 2.4
      kernels.

      The -common patch is specific to a particular kernel.  It
      contains all the architecture independent makefile changes, plus
      some bug fixes to code that is shared between the existing build
      system and kbuild 2.5.

      The arch dependent patches are tied to a particular architecture,
      they contain all the architecture dependent makefile changes.

      You can mix and match the latest core code with any of the kernel
      specific patches.

Q05.  How do I build for multiple architectures?
A05.  Download and apply the arch specific patches that you need.
      There is no overlap between arch patches so it is always safe to
      apply patches for more than one architecture.

      If there is no arch specific patch for the kernel version you
      want, try the arch patch for the next kernel version down.  Arch
      specific patches do not change very often and you can sometimes
      get away with using an older arch patch on the later kernels.

      Hint: kbuild 2.5 supports separate source and object trees.  This
            lets you build for i386 in one object tree and build for
            sparc64 in a second object tree, all from the same (read
            only) source tree.  You can even run both builds at the
            same time.  The only restriction is that you cannot use the
            same object directory for two different architectures.

Q06.  Why do I have to use make -f Makefile-2.5?
A06.  Compatibility glue with the existing build system.  As currently
      structured, kbuild 2.5 does not replace the existing build
      system.  Instead it coexists with the existing system.  This
      allows parallel testing of the two build systems, and is useful
      for architectures that are not up to the latest kernel yet.

      Eventually kbuild 2.5 will replace the existing system and all
      the compatibility glue will disappear.  At that time, the
      makefiles get renamed from Makefile-2.5 to Makefile.

      The fact that make *config says 'now run make dep' is also
      compatibility glue.  kbuild 2.5 has no make dep processing but it
      uses some existing configuration code.

Q07.  Why is [b]zImage part of the config?
A07.  In the current system, installation is a poor relation of the
      build system.  Each architecture has their own install targets
      with their own special rules.  None of the install targets check
      that what is being installed was built correctly.

      In kbuild 2.5 the install target is a fully supported part of the
      build.  Not only is [b]zImage (and all the other targets) part of
      the config, the config also supports installation to somewhere
      other than /, plus optional rules for installing the config and
      System.map at the same time as the kernel and modules.  This
      significantly improves support for cross compilation.

      A nice side effect of putting all the install information in
      .config is that building a new kernel is as simple as

        cp previous_config .config
        make ... defconfig installable && sudo make install

Q08.  Why support third party code?
A08.  Like it or not, significant chunks of the kernel code are not in
      the kernel tree.  This ranges from non-GPL code through new
      versions of drivers and filesystems to entire architectures that
      are not yet ready for inclusion in the kernel.

      The current build system does not support third party code.  Each
      developer has to supply their own build instructions, then users
      have to manually follow those instructions.  This is a continual
      source of questions and a significant source of unnecessary bug
      reports.

      kbuild 2.5 has full and official support for compiling from
      multiple source trees.  Simply follow the kernel directory
      structure for the third party code, set one kbuild variable and
      the third party code is treated as any other bit of kernel code.

      This support simplifies the maintenance effort for developers who
      are working with multiple large patches.  By separating each
      patch into its own sparse source tree and logically pulling them
      together at build time, each patch can be kept separate but used
      in a single kernel.  It removes the need to have multiple copies
      of the base kernel tree, each with a different patch applied and
      removes the need to copy changes between trees.

Q09.  What is the timestamp problem?
A09.  'make' relies on timestamps never going backwards.  This is
      reasonable for small projects which do not use source
      repositories, it is not valid for large projects building over
      NFS, spread over multiple trees and using SCM systems.

      When you build over NFS there is always the possibility of
      timestamp skew between the source and build machines.  Time
      synchronization helps but cannot totally remove the problem.

      A larger problem is the increasing use of source repositories for
      the kernel.  When a file is checked out of a repository, many SCM
      systems reset the timestamp to when the file was checked in.
      Standard 'make' processing gets totally confused by this, which
      results in an incorrect build.

      Another source of timestamp skew is the support for third party
      code which is compiled outside the kernel tree.  A user can
      switch from kernel+other trees to just the kernel tree.  If there
      was any overlap between the trees then removing the other tree
      exposes the older kernel files, in effect the timestamps go
      backwards.

      The desire to overcome the timestamp problem is one of the main
      reasons behind the use of a kbuild database.  kbuild 2.5 records
      all the timestamps and detects any timestamp change, either
      forwards or backwards.

      There is a good reason that all the projects that are trying to
      replace make have given up on using timestamps as the only way of
      checking what has changed.  Nobody believes that timestamp alone
      is accurate on large projects.

Q10.  What special cases are a problem for the existing system?
A10.  Almost any subsystem that is split over multiple directories is a
      problem.  The existing system is heavily tied to the notion that
      everything is in one directory.  It is difficult to build a
      module from objects in multiple directories without detailed
      knowledge of the kbuild internals.  Makefiles have to specify
      under what conditions the sub directories are entered, then this
      information is repeated in each sub directory.  Each makefile
      that depends on another directory must ensure that the other
      directory is fully processed before this directory can complete
      its processing.

      All host programs and boot loaders are special cases in the
      existing system.  They do not get command tracking nor full
      dependency tracking, so changes that affect these objects can be
      overlooked.

      None of this is a problem in kbuild 2.5.  Removing the recursive
      make and building a global makefile automatically exposes all the
      dependencies and removes all the manual controls that are
      scattered through the existing system.  Host programs and boot
      loaders are fully fledged members of the build community, and get
      all the command and dependency tracking that the kernel gets.

Q11.  What extra debugging does kbuild 2.5 have?
A11.  The kbuild 2.5 database contains _all_ the information about the
      kernel build.  This includes the inter dependencies of files, how
      objects are linked, the commands used to build each object etc.
      There is a program to dump that database in text format for easy
      debugging.

      The various pre-processing programs have verbose modes so you can
      see exactly what they are doing and why.  They also have norun
      modes for debugging without making changes.

      .tmp_vmlinux_order lists the entire set of objects that go into
      vmlinux, in the order that they are linked.  No more guessing
      about which object will initialize first.

      In addition to .tmp_vmlinux_order, there are equivalent listings
      for host programs and boot loaders, as well as modules.

      .tmp_select lists everything that was selected, together with
      extra flags, how individual objects are to be linked, which
      objects export symbols etc.  It is the mapping from .config to
      what will be built and how.

Q12.  Why change all the makefiles to a new syntax?
A12.  Primarily to get away from relying on make for all the
      processing.  make can never cope with timestamps going backwards,
      that problem has to be solved outside make and the program that
      solves this problem needs all the information.

      This will be the last time that the makefile syntax has to
      change.  A fundamental problem with the existing system is that
      we are not really using makefiles.  Instead we use magic
      variables which are interpreted by Rules.make.

      Every time that there is a major change to Rules.make, every
      Makefile has to be changed to suit.  The really annoying part is
      that _what_ we want to do has never changed, only _how_ it is
      done has changed, but that still requires global changes.  What
      we want to do is build objects as modules or built in and link
      them in a defined order, all dependent on config settings.  The
      bulk of kernel developers should not have to care about _how_ the
      kernel is built, but the current system forces them to know the
      internal details of kbuild.

      Over the years there have been at least four different ways of
      specifying what is to be done.  Each time this occurred,
      everybody had to learn a new way of writing Makefiles and all
      Makefiles had to be changed.  The most recent example is Kai's
      changes from 2.5.15 to 2.5.19.  That 'clean up' to Rules.make
      required changes to 392 Makefiles.  If you continue with the
      existing build system and try to handle separate source and
      object trees then yet more makefile changes will be required.

      kbuild 2.5 Makefile.in files take a completely different
      approach.  They define _what_ you want to do and leave it up to
      the core code to work out _how_ to do it.  In other words, we
      finally have a clean interface between the developers who want to
      write makefiles and the kbuild group who support them.

      No more global syntax changes when the kbuild logic is changed!

      To prove my point, the core code in kbuild 2.5 has had three
      major releases, getting faster each time.  None of those releases
      required changes to the Makefile.in files, the only changes were
      to handle new kernel files and directories.

Q13.  Why still use make?
A13.  I looked at all the make replacements that I could find.  None of
      them could cope with the unusual kernel requirements.  The kernel
      has a two level dependency, rebuilding depends on both file
      changes and config changes.  Plus we want to rebuild only the
      affected files.

      Many of the replacements required new tools such as Perl or
      Python.  The kernel build is heavily constrained on what tools it
      requires, I did not want to add yet another one.  Don't let the
      fact that kbuild 2.5 contains yacc and lex files fool you, the
      generated C code is shipped so only the kbuild maintainers
      require the extra tools, not kbuild users.

      It turns out that once you build a global makefile and take care
      of the timestamp problem and the two level dependencies in the
      pre-processing code, make does a good job on the actual build.
      It is fast and accurate in its own domain, as long as you give it
      all the data.

Q14.  kbuild 2.5 does not support modversions.
A14.  The existing modversion code is not being used for the job it was
      invented to handle, unfortunately it does not work correctly for
      what people are using modversions for.  Module symbol versions
      were originally invented to stop users loading SMP modules into
      UP kernels and vice versa, and it does that well.  But people
      have gone one step too far and now use modversions to decide if
      kernel ABIs have changed.

      Alas modversions is not 100% accurate and anything less than 100%
      accurate is asking for trouble when loading modules into kernels
      with different configs.  Modversions do not detect all the ABI
      changes, e.g. there is no way to detect if spin lock debugging is
      active or not in the ABI hash.  Build a module with spin lock
      debugging, load it into a kernel without spin lock debugging and
      watch it oops, but according to modversions they are compatible.

      Another problem with modversions is they rely on users manually
      running make dep after config changes or applying patches.  We
      know that they do not do this, http://www.tux.org/lkml/#s8-8 gets
      lots of references.  The standard answer to modversion problems
      is "delete everything and rebuild", how Microsoft is that?

      The re-calculation of modversions can be automated (we know which
      files export symbols) but that just brings us up against the next
      problem.  There is no way to tell which code consumes an exported
      symbol.  The only thing to do if _any_ module symbol version has
      changed is to rebuild _all_ modules.  Highly unsatisfactory.

      Given all those problems, I have designed a safe method of
      handling ABI detection for modules.  That method runs at the back
      end of a build instead of at the start, it is the only way to
      keep the data up to date.  It hooks nicely into kbuild 2.5 but
      not the existing build system.  For obvious reasons, I will not
      start on the new modversion code until kbuild 2.5 is in and
      stable.  If kbuild 2.5 goes in then I will have a clean
      modversions system before before kernel 2.5 becomes 2.6.  If
      kbuild 2.5 does not go in then we are stuck with the existing
      broken modversions.

Q15.  Why do we need a flag day?
A15.  kbuild 2.5 can coexist with the existing build system but
      eventually it must either die or replace the existing system.

      Given the need for a new syntax to handle timestamps, separate
      source and object trees, compiling third party source and the
      change from recursive to non-recursive, there is no sensible way
      to phase in the makefile changes.  The conversion to the new
      Makefile.in syntax must be global.

      OTOH, there were 329 Makefile changes between 2.5.15 and 2.5.19
      (i.e. all makefiles were changed), so why worry about one more?
      Especially when this will be the last global change to makefiles
      for kbuild.

Q16.  Can kbuild 2.5 be split into separate patches?
A16.  Not in any sensible way.  It is already split into core, common
      and arch code.  There is no point in adding the core code without
      the Makefile.in files from the common and arch patches, there is
      nothing for the core code to work on.  Adding the common and arch
      patches without the core code to process them is equally
      pointless.

      There are some minor bug fixes to shared build code could be done
      separately, some have already been submitted.  However that does
      nothing about my real problem - Linus does not want to look at
      kbuild 2.5.  The bug fixes have already been fed back to 2.4.

      Some people have suggested splitting the asm-offset changes.
      That ends up being more work, the clean Makefile.in rules for
      asm-offset have to be retrofitted to the clumsy method used in
      the existing system.  Remember that these are a mixture of target
      compiles and host commands, kbuild 2.5 supports that cleanly, the
      existing system does not.

Q17.  Can we do the changes in smaller steps?
A17.  Once you accept the need for a new syntax, a database to handle
      timestamps and dependencies correctly and the pre-processing
      programs to do all the work, any further work on the existing
      build system is a complete waste of time.  Why fiddle with the
      existing syntax and Rules.make when it will all be replaced?

Q18.  What about tags/rpm/other miscellaneous targets?
A18.  I have put my foot down on what goes into kernel build and what
      does not go in.  It is the job of kbuild to build and install the
      kernel, it is not kbuild's job to run the packaging manager of
      the day.

      kbuild 2.5 provides an extensive infrastructure which can be used
      by other scripts to perform additional processing that is not
      related to the kernel build.  This is another advantage of making
      the install a fully supported target instead of a partial add on.
      One of the install options is "run a post-install script", that
      script gets all the install information and can do whatever the
      user wants.

      I do not object to Redhat, Debian, Slackware etc. supplying
      sample scripts to run their packaging code, but these scripts
      will not be permanently hooked into kbuild 2.5.  Instead the user
      can take a copy, modify as required then run the modified script
      during install.  No more tweaking the kernel install rules to do
      something special for your system.

      Tags, ctags, cscope etc. fall into the same category.  These
      targets will be converted to sample scripts which each user can
      modify to suit their own requirements.

Q19.  What about 2.4 kernels?
A19.  Because kbuild 2.5 can coexist with the existing build system,
      there is nothing to stop people using kbuild 2.5 on 2.4 kernels,
      it was developed that way.  Some people are already using kbuild
      2.5 on 2.4 kernels for the reliability and speed.

      There are no plans to replace the kernel build system in 2.4
      kernels with kbuild 2.5.  It is too big a change for a stable
      kernel.  Bug fixes from kbuild 2.5 have already been fed back to
      the 2.4 build system.

Q20.  Only one person understands kbuild 2.5.
A20.  Pure FUD.  Lots of people understand the Makefile.in syntax, I
      get bug fixes all the time and multiple people have worked on the
      arch specific patches.  The kbuild 2.5 syntax is fully
      documented, which is more than can be said for the existing
      syntax.

      There are only a few people who bother with the core code, but
      that has always been true of the kernel build system.  Only the
      kbuild maintainers care what the core code does, everybody else
      just writes build rules.  The core code is fully documented,
      complete with database design, notes on what the various flags do
      and even a schema diagram.

Q21.  The core patch is too big.
A21.  Since when has code size mattered?  Does that mean that
      drivers/acpi should be removed?  Or sound?  Both are much bigger
      than the kbuild 2.5 core patch.

      You will also see people saying that kbuild 2.5 is "30,000 lines
      of C code".  This is more FUD from people who have not actually
      looked at the patch.  core-15 breaks down into

                                                Lines  Words  Bytes
      Documentation                             8372   67342  300084
      Generated C code (no need for yacc/lex)   5591   25514  169830
      Makefiles (will replace existing files)   1678    8942   67906
      Support scripts                            219    1125    7374
      Database engine                           3139   13148   89169
      Pre-processing code                       9026   38059  239812

      Those figures include the patch headers, so the real numbers are
      even smaller.

      It is the pre-processing code that does the real work - 9,000
      lines of C, yacc and lex.  And that includes lots of comments in
      the code, in addition to the separate documentation files.

Q22.  Are all the kbuild problems being fixed by Kai's work?
A22.  No.  Kai is cherry picking the easy fixes out of other people's
      work but he is completely ignoring the big problems.

      Kai has said that he will not support compilation for third party
      code.  kbuild 2.5 already does this.

      Kai thinks he knows how to do non-recursive make, but no code has
      appeared.  kbuild 2.5 already does this.

      Kai thinks he might be able to do separate source and object
      trees but is not sure.  kbuild 2.5 already does this.

      Kai has not considered extracting the data that Rusty needs to
      standardize the parameter handling for boot time and module load.
      kbuild 2.5 already does this.

      There is no way to solve the timestamp problem without radical
      syntax changes and extra code to do all the checking.  kbuild 2.5
      already does this.

      All Kai has done is duplicate the work I did months ago on the
      makefile clean up.  And BTW, introduced build errors while doing
      so.  The build errors that Kai introduced have been corrected in
      kbuild 2.5.

Q23.  Why rebuild the makefile every time?
A23.  Phase1 has to run every time to find out if files have been added
      or deleted.  Before saying that phases 2, 3 and 4 can be
      automatically skipped if "nothing has changed", contemplate the
      difference between

        export KBUILD_SRCTREE_000=...
        export KBUILD_SRCTREE_010=...
        make ...

      and

        export KBUILD_SRCTREE_000=...
        make ...

      Meditate upon the meaning of

        make ... emu10k1-DEBUG=1

      with respect to sound/oss/emu10k1/Makefile.in.

      Then come up with a 100% safe algorithm to determine if phases 2,
      3 and 4 can be skipped.  If it is not 100% safe, it does not go
      into kbuild 2.5.

      Users who 'know' that nothing has changed can use
      NO_MAKEFILE_GEN=1.   Their decision, their responsibility.

Q24.  Why not explain all this to Linus?
A24.  I have tried, damn it!

      I started with a presentation of kbuild 2.5 at the 2.5 Kernel
      Developer's Conference.  After that presentation I spoke to Linus
      and he agreed that kbuild 2.5 would go into the kernel at the
      start of the 2.5 cycle.  When 2.5 was split off, I sent Linus
      multiple mails saying that kbuild 2.5 Release 1.0 was ready.  He
      completely ignored those mails, except for one comment "we have
      more important things to do, like bio".

      I thought that Linus's agreement meant something, obviously it
      does not.

      After speeding up the core code, Release 2.0 was issued.  More
      mails to Linus over several weeks were ignored, except for a
      brief note under another thread entirely.

        "I'm hoping we can get there in small steps, rather than a big
        traumatic merge. I'd love to just try to merge it piecemeal.

        Especially as I don't find the existign system so broken."

      Several private mails then followed before I got a response.
      Linus gave private excuses which he has not repeated in public,
      suffice it to say that those reasons do not hold up.  I tried
      explaining why the existing system is broken, but he ignored me.

      Since then Linus has started taking patches from Kai, without
      caring that they make no attempt at fixing the big problems.  It
      is infuriating that Linus's latest mail on the topic said

        "Kai has already shown that he can merge with me easily"

      I have done all the right steps, many times.  The reason I cannot
      merge with Linus is because he ignores my mails!

      Linus does not think that kernel build is important.  He knows
      how to build a kernel and does not have to handle the bug reports
      from people who get it wrong.

      If you think that the bug fixes and new features in kbuild 2.5
      are worthwhile then tell Linus.  Otherwise live with all the bugs
      of the existing system and miss the advanced features of kbuild
      2.5.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8+3YZi4UHNye0ZOoRAuQ4AKCGz2Li0hYtq5/QWdxrntMs+jGEAQCfUEj4
V23uljc1Bz3ZURYLYZRJGdM=
=R2/z
-----END PGP SIGNATURE-----

