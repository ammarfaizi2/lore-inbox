Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVAGVIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVAGVIP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVAGVHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:07:23 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:3779 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261603AbVAGVDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:03:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TQIPS67usQPAsZ67roTY5ViyKQT9Yie3N4t3oO+qDgAQiH3PY3f6UtieDkTmyJxiapGJWg1iGNy567hiIQwaEFAxUNP3MoDwzzSx40wYgSY+iyveDXDzTwv+ljlYMuR+eLtbIFcIctXJtC6dvLG5FdhznVt/p9N+bmKVui9rktA=
Message-ID: <4d8e3fd305010713032aeaa75c@mail.gmail.com>
Date: Fri, 7 Jan 2005 22:03:40 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: grsecurity 2.1.0 release / 5 Linux kernel advisories (fwd)
Cc: linux-kernel@vger.kernel.org,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
In-Reply-To: <Pine.LNX.4.61.0501071954130.361@student.dei.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.61.0501071954130.361@student.dei.uc.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Linus,
the below email seems to be very intersting.

Any comment ?


On Fri, 7 Jan 2005 19:54:43 +0000 (WET), Marcos D. Marado Torres
<marado@student.dei.uc.pt> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> - --
> /* *************************************************************** */
>    Marcos Daniel Marado Torres      AKA        Mind Booster Noori
>    http://student.dei.uc.pt/~marado   -          marado@student.dei.uc.pt
>    () Join the ASCII ribbon campaign against html email, Microsoft
>    /\ attachments and Software patents.   They endanger the World.
>    Sign a petition against patents:  http://petition.eurolinux.org
> /* *************************************************************** */
> 
> - ---------- Forwarded message ----------
> Date: Fri, 7 Jan 2005 13:18:53 -0500
> From: Brad Spengler <spender@grsecurity.net>
> To: full-disclosure@lists.netsys.com, bugtraq@securityfocus.com,
>     dailydave@lists.immunitysec.com
> Subject: grsecurity 2.1.0 release / 5 Linux kernel advisories
> 
> Let's try this again, since web archives don't like multipart
> attachments.
> 
> grsecurity 2.1.0 release / Linux Kernel advisories
> - --------------------------------------------------------------------
> 
> Table Of Contents:
> 1) grsecurity 2.1.0 announcement and changelog
> 2) Linux Kernel advisory introduction
> 3) 2.4/2.6 random poolsize sysctl handler integer overflow
> 4) 2.6 scsi ioctl integer overflow and information leak
> 5) 2.2/2.4/2.6 moxa serial driver bss overflow
> 6) 2.4/2.6 RLIMIT_MEMLOCK bypass and (2.6) unprivileged user DoS
> 7) Attachments, including patches for all vulns, a POC for #3, and a
>    working exploit for #6
> 
> 1) grsecurity 2.1.0 announcement and changelog
> 
> I'm happy to announce the release of grsecurity 2.1.0.  It is being
> released initially for the 2.4.28 and 2.6.10 kernels and will be ported
> immediately to the next kernel versions when released.  It can be
> downloaded at http://www.grsecurity.net.  We are still actively seeking
> sponsorship, so if you benefit from using grsecurity and like the
> changes you see in 2.1.0, please consider sponsoring the future
> development and maintenance of the project.
> Changes in this release include:
> 
> * New configuration file for full learning: /etc/grsec/learn_config
> * Learning heuristics have been optimized to better detect temporary
>   file usage and reduce appropriately.
> * Learning heuristics have been modified to weight against reducing
>   certain additional important directories.
> * User/group ID transitions have been added to the learning system.
>   Any subject transitioning to less than 3 different users or 3
>   different groups that has CAP_SETUID or CAP_SETGID will have ID
>   transitions added.  This is useful to automatically secure
>   applications that only transition to one or few users/groups like
>   nobody/nogroup.
> * /proc/<pid>/* accesses are automatically rewritten as /proc by grlearn
>   before being cached and written to disk
> * The inherit-based learning usable through the learning configuration
>   file is usable through a regular policy as well simply by adding "i"
>   instead of "l" to a subject for learning.
> * Inheritance is preserved whenever possible across uid/gid changes when
>   the role resulting from the uid/gid change is no different from that
>   before the change.
> * A complete ~95-99% efficient LFU-hash hybrid caching system has been
>   added that greatly reduces the number of full object lookups by
>   caching the result.  The cache essentially mimics the filesystem
>   around where applications are operating: nearly equivalent to having
>   an object for every file and directory on the system, but without the
>   wasted memory.  The cache is invalidated on creates and deletes that
>   cause a change in policy (through policy re-creation) and on renames
>   of directories or symlinks.
> * Memory usage for non-full learning has been significantly reduced and
>   all memory leaks have been plugged.
> * A new object mode has been added for hardlinks for more fine-grained
>   permissions.  See the sample policy file for information on what
>   permissions are required to create a hardlink.  Its corresponding
>   audit flag has been added as well.
> * Destruction of unused shared memory feature added and included in
>   the sysctl framework of grsecurity.  This feature was ported from
>   Openwall (http://www.openwall.com/linux).
> * A new option was added to the sysctl feature that enables at boot all
>   features enabled in the kernel configuration, while allowing them to
>   be changed via the sysctl interface until grsec_lock is set.
> * Policy statistics have been added to gradm that provide useful,
>   security-relevant information on the policy you are loading into the
>   kernel.  You can view these statistics when enabling the system by
>   running gradm -V -E.
> * Interactive performance of full-learning has improved by ~15% by
>   reducing the number of context switches caused by grlearn doing small
>   disk writes by using a write buffer (writing more once instead of
>   less 1000 times) and keeping track of log entry lengths for quicker
>   string matching.  A signal handler was added to grlearn so that when
>   learning is stopped, the write buffer is flushed to disk.
> * Kernel headers are no longer used for gradm
> * Updates from the PaX project (http://pax.grsecurity.net)
> * Bugfixes for things mentioned on the list, etc
> 
> When patching your kernel for the 2.4.28 and 2.6.10 kernels, since they
> contain several vulnerabilities, make sure to also apply the secfix
> patches located on the website.
> 
> 2) Linux Kernel advisory introduction
> 
> Let me begin by giving you a timeline:
> 
> December 15th: I send Linus a mail with a subject line of
> "RLIMIT_MEMLOCK bypass with locked stack"
> December 27th: The PaX team sends Linus a mail with a subject line of
> "2.6.9+ mlockall/expand_down DoS by unprivileged users"
> January 2nd: The PaX team resends the previous mail to Linux and Andrew
> Morton
> 
> Between December 15th and today, Linus has committed many changes to
> the kernel.  Between January 2nd and today, Andrew Morton has committed
> several changes to the kernel.  3 weeks is a sufficient amount of time
> to be able to expect even a reply about a given vulnerability.  A patch
> for the vulnerability was attached to the mails, and in the PaX team's
> mails, a working exploit as well.  Private notification of
> vulnerabilities is a privilege, and when that privilege is abused by not
> responding promptly, it deserves to be revoked.
> 
> Using 'advanced static analysis': "cd drivers; grep copy_from_user -r ./* |
> grep -v sizeof", I discovered 4 exploitable vulnerabilities in a matter
> of 15 minutes.  More vulnerabilities were found in 2.6 than in 2.4.
> It's a pretty sad state of affairs for Linux security when someone can
> find 4 exploitable vulnerabilities in a matter of minutes.  Since there
> was no point in sending more vulnerability reports when the first hadn't
> even been responded to, I'm including all four of them in this mail, as
> well as a POC for the poolsize bug.  The other bugs can have POCs
> written
> for just as trivially.  The poolsize bug requires uid 0, but not any
> root capabilities.  The scsi and serial bugs depend on the permissions
> of their respective devices, and thus can possibly be exploited as
> non-root.  The scsi bug in particular has a couple different attack
> vectors that I haven't even bothered to investigate.  Some of these bugs
> have gone unfixed for several years.
> 
> The PaX team discovered the mlockall DoS. It has been fixed in PaX for
> 2 years.  I have attached their mail and exploit code.
> 
> I'd really like to know what's being done about this pitiful trend of
> Linux security, where it's 10x as easy to find a vulnerability in the
> kernel than it is in any app on the system, where isec releases at
> least one critical vulnerability for each kernel version.  I don't see
> that the 2.6 development model is doing anything to help this (as the
> spectrum of these vulnerabilities demonstrate), by throwing
> experimental code into the kernel and claiming it to be "stable".
> Hopefully now these vulnerabilities will be fixed in a timely manner.
> 
> 3) 2.4/2.6 random poolsize sysctl handler integer overflow
> 
> In drivers/char/random.c:
> 
> at poolsize_strategy():
> >        int     len;
>         ^ signed integer
> >
> >        sysctl_poolsize = random_state->poolinfo.POOLBYTES;
> >
> >        /*
> >
> >        /*
> >         * We only handle the write case, since the read case gets
> >         * handled by the default handler (and we don't care if the
> >         * write case happens twice; it's harmless).
> >         */
> >        if (newval && newlen) {
> >                len = newlen;
>                 ^ unsigned int converted to signed
> >                if (len > table->maxlen)
>                 ^ comparison of two signed integers
> >                        len = table->maxlen;
> >                if (copy_from_user(table->data, newval, len))
>                 ^ copy_from_user with len possibly > table->maxlen
> 
> 4) 2.6 scsi ioctl integer overflow and information leak
> 
> In drivers/block/scsi_ioctl.c:
> 
> at sg_scsi_ioctl():
> >        struct request *rq;
> >        int err, in_len, out_len, bytes, opcode, cmdlen;
>         ^ in_len, out_len are signed int
> >        char *buffer = NULL, sense[SCSI_SENSE_BUFFERSIZE];
> >
> >        /*
> >         * get in an out lengths, verify they don't exceed a page worth of data
> >         */
> >        if (get_user(in_len, &sic->inlen))
>         ^ in_len is user-controlled
> >                return -EFAULT;
> >        if (get_user(out_len, &sic->outlen))
>         ^ out_len is user-controlled
> >                return -EFAULT;
> >        if (in_len > PAGE_SIZE || out_len > PAGE_SIZE)
>         ^ signed int only has upper bound checked
> >                return -EINVAL;
> >        if (get_user(opcode, sic->data))
> >                return -EFAULT;
> >        bytes = max(in_len, out_len);
> ...
> >        rq->cmd_len = cmdlen;
> >        if (copy_from_user(rq->cmd, sic->data, cmdlen))
> >                goto error;
> >
> >        if (copy_from_user(buffer, sic->data + cmdlen, in_len))
>                 ^ copy_from_user with size possibly > PAGE_SIZE
> >                goto error;
> ...
> >                if (copy_to_user(sic->data, buffer, out_len))
>                 ^ copy_to_user with size possibly > PAGE_SIZE
> >                        err = -EFAULT;
> 
> 5) 2.2/2.4/2.6 moxa serial driver bss overflow
> 
> In drivers/char/moxa.c:
> 
> >static unsigned char moxaBuff[10240];
> 
> In MoxaDriverIoctl():
> 
> >        if(copy_from_user(&dltmp, argp, sizeof(struct dl_str)))
> >                return -EFAULT;
>                 ^ dltmp.len is user-controlled
> >        if(dltmp.cardno < 0 || dltmp.cardno >= MAX_BOARDS)
> >                return -EINVAL;
> >
> >        switch(cmd)
> >        {
> >        case MOXA_LOAD_BIOS:
> >                i = moxaloadbios(dltmp.cardno, dltmp.buf, dltmp.len);
>                 ^ called with no length checking
> >                return (i);
> >        case MOXA_FIND_BOARD:
> >                return moxafindcard(dltmp.cardno);
> >        case MOXA_LOAD_C320B:
> >                moxaload320b(dltmp.cardno, dltmp.buf, dltmp.len);
>                 ^ called with no length checking
> >        default: /* to keep gcc happy */
> >                return (0);
> >        case MOXA_LOAD_CODE:
> >                i = moxaloadcode(dltmp.cardno, dltmp.buf, dltmp.len);
>                 ^ called with no length checking
> 
> In moxaloadbios():
> 
> >static int moxaloadbios(int cardno, unsigned char __user *tmp, int len)
> >{
> >        void __iomem *baseAddr;
> >        int i;
> >
> >        if(copy_from_user(moxaBuff, tmp, len))
>                 ^ copy_from_user with no length checking
> >                return -EFAULT;
> 
> In moxaloadcode():
> 
> > static int moxaloadcode(int cardno, unsigned char __user *tmp, int len)
> > {
> >        void __iomem *baseAddr, *ofsAddr;
> >        int retval, port, i;
> >
> >        if(copy_from_user(moxaBuff, tmp, len))
>                 ^ copy_from_user with no length checking
> >                return -EFAULT;
> 
> In moxaload320b():
> 
> >static int moxaload320b(int cardno, unsigned char __user *tmp, int len)
> >{
> >        void __iomem *baseAddr;
> >        int i;
> >
> >        if(len > sizeof(moxaBuff))
>                 ^ signed int has only upper-bound checked
> >                return -EINVAL;
> >        if(copy_from_user(moxaBuff, tmp, len))
>                 ^ copy_from_user with len possibly > sizeof(moxaBuff)
> >                return -EFAULT;
> 
> 6) 2.4/2.6 RLIMIT_MEMLOCK bypass and (2.6) unprivileged user DoS
> 
> Taken from the mail from the PaX team to Linus and Andrew Morton:
> 
> the 'culprit' patch is how the default RLIM_MEMLOCK and the privilege
> to call mlockall have changed in 2.6.9. namely, the former has been
> reduced to 32 pages while the latter has been relaxed to allow it for
> otherwise unprivileged users if their RLIM_MEMLOCK is bigger than the
> currently allocated vm. which is normally good enough, except as you
> now know there's a path that can increase the allocated vm without
> checking for RLIM_MEMLOCK.
> 
> i'm attaching a small i386-specific demonstration, use the makefile to
> create the small self-contained executable, e.g., 'make alloc=0x100000'
> to have it allocate 1MB of stack and lock all of it. for demonstrating
> the full effect of locking down arbitrary amounts of memory, you'll have
> to set your stack rlimit to infinity (ulimit -s unlimited) and allocate
> as much memory as your memory overcommit policy allows (this may mean
> that you'll have to run multiple instances, if you have lots of memory).
> 
> surprisingly, in my tests the kernel survived pretty well, it just crawled
> to a snail's speed as every mapped page access required disk i/o ;-). i
> didn't play with overcommit policies nor any special workloads, so there
> may very well be worse effects with that much locked memory. in any case,
> this may warrant 2.6.10.1 because as soon as the fix goes into -bk, anyone
> reading the logs can easily figure it out and reproduce the 'exploit'.
> 
> the attached patch is the excerpt from PaX that survives the exploit, so
> i think it's good to go.
> 
> 7) Attachments
> 
> expoits_and_patches.tgz can be downloaded at:
> http://grsecurity.net/~spender/exploits_and_patches.tgz
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
> Comment: Made with pgp4pine 1.76
> 
> iD8DBQFB3ukImNlq8m+oD34RAlwFAJ9IpoQRMmdhsPjdJlH8Mxct3yGZTwCeOuaD
> n855Y0P+FCBVUSaEDl17hmo=
> =6g/V
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Paolo
