Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbTBJHYq>; Mon, 10 Feb 2003 02:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbTBJHYq>; Mon, 10 Feb 2003 02:24:46 -0500
Received: from ishtar.tlinx.org ([64.81.58.33]:14278 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id <S264644AbTBJHYh>;
	Mon, 10 Feb 2003 02:24:37 -0500
From: "LA Walsh" <law@tlinx.org>
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@transmeta.com>, <linux-security-module@wirex.com>
Subject: RE: [BK PATCH] LSM changes for 2.5.59
Date: Sun, 9 Feb 2003 23:34:10 -0800
Message-ID: <048601c2d0d6$cda31130$1403a8c0@sc.tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <3E471F21.4010803@wirex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed Apr 11 2001 - 18:28:50 PDT
> Crispin Cowan, Ph.D (Chief Scientist, WireX) claims:
> 
> Because Linus asked for access control support, not audit logging 
> support, it is not surprising that logging models don't fit so well.

Oh really?  On Wed Apr 11 2001 - 18:28:50 PDT
From: Crispin Cowan (crispin@wirex.com) told us:

	"Linus ...observes that there are many different security 
	approaches, each with their own advocates.  He doesn't want 
	to arbitrate which of them should be "the" Linux security 
	approach, and would rather that Linux can support any of 
	them.

	That is the purpose of this project:  to allow Linux to 
	support a variety of security models"

---
	You recognize that as your writing?  Perhaps with the context of
the full post, below, it will help.  Even more so,  Linus's emails that
defined the "charter" are also included below.  

	Maybe I'm delusional, but you are contradicting yourself.  In
common terms, this is called lying.  Either Linus didn't say he wanted
something "truly generic" (his words), and you made up the email from
Linus or you are trying to change what he said to suite your current
purposes.  You suckered in more than a few people with promises from below and then changed things cause you and other lsm members
were too 
afraid that the right thing wouldn't fly with "the kernel programmers".

	Security isn't just an afterthought you can patch on and cross
your fingers and hope it won't break.  It has to be designed in.  
Lsm came closest to that when we put the code on the table (2001, not 1991)
to fundamentally redesign linux security for today's needs.  Instead, we
end up with dribbled in patches of mediocrity that put us one step
closer to the byzantine, "Microsoftesque" OS model.  

	By some basic, unwritten, design short-comings (not present in the original plan), you have something that is neither
"simple" nor
"generic".  

	Complete text is written below if anyone cares to see how much
lsm has strayed and compromised away from the original charter.

Special.
-l

-------------------------------------------------------------------

From: Crispin Cowan (crispin@wirex.com)
Date: Wed Apr 11 2001 - 18:28:50 PDT 

--------------------------------------------------------------------------------


Greetings.  Thanks for your patience at the lack of traffic on the first day of
this list.  Subscriptions grew rapidly from nil to 202 in the last 24 hours, and
has now tapered off.  I held back posting introductory materials so that I
wouldn't have to post them three or four times :-)

Naturally, everyone is curious what this project is about in general:  why use a
generic security module interface?  And in particular, what has changed in Linus'
view of security extensions.  Rather than attempt to speak for Linus, I will
quote what he said in a private forum, and we can proceed from there.

It is Linus' comments that spurred me to want to start this undertaking.  He
observes that there are many different security approaches, each with their own
advocates.  He doesn't want to arbitrate which of them should be "the" Linux
security approach, and would rather that Linux can support any of them.

That is the purpose of this project:  to allow Linux to support a variety of
security models, so that security developers don't have to have the "my dog's
bigger than your dog" argument, and users can choose the security model that
suits their needs.

Crispin

--
Crispin Cowan, Ph.D.
Chief Scientist, WireX Communications, Inc. http://wirex.com
Security Hardened Linux Distribution:       http://immunix.org

  ------------------------------------------------------------------------

Linus Torvalds wrote:

> On Fri, 6 Apr 2001, Peter G. Neumann wrote:
> >
> > No mention of security or reliability.  Is that an omission of
> > Edupage or of the gurus?
>
> I think it's another commentary on security not being "interesting".
>
> We had a NSA person give a talk about selinux, and I personally wouldn't
> mind having a better infrastructure in place in the kernel for things like
> that. HOWEVER, my problem as a system maintainer is that I don't see
> people agreeing about the right solution.
>
> The embedded people don't really want security management (or rather, to
> them, the simple "root is all"  approach is fine, and takes up less space
> than more complex schemes with the selinux kind of security managers etc).
>
> And even the security people aren't really sure which _sort_ of security
> support they want (or rather - they all KNOW which kind of security
> management they want, but there are as many different opinions as there
> are people).
>
> So I'm not interested in any one particular approach, TE/DTE/MLS or
> whatever. I can't even discuss the difference intelligently anyway (or
> even play at it), but what I can tell is that there is no "one right way".
> And that's without even getting into the issue of what the policy should
> be for them.
>
> Which means that what _I_ would require from something that gets
> integrated into Linux is either:
>
>  - true simplicity. "euid == 0" is this. capabilities are an approximation
>    of this, and it turns out that almost nobody even uses capabilities
>    just because they are complex enough to administer that they are of
>    dubious value in many cases. The notion of an extended "suid" bit (with
>    an ELF header of capabilities) has been bandied around for a long time,
>    and the fact is that it would be a total maintenance nightmare. And
>    that's the _simple_ case.
>
>    This is where Linux is now, and this is where we'll remain, unless we
>    get the alternative:
>
>  - truly generic. No "MLS" vs "TE" vs "uid==0" vs "capability" at ALL.
>    Something where the "uid == 0" version of security is just one case
>    (which the embedded people might use), or where SELinux would be just a
>    matter of loading the SELinux module and installing _that_ security
>    model.
>
> Quite frankly, nobody seems to be interested in actually trying to do the
> latter. Everybody has their _own_ particular flavour that they want to
> push, and don't realize that I cannot accept that as a maintainer.
>
> I would, for example, be willing to entertain the notion of having a
> (global or per-process or whatever) pointer to a "security checks"
> structure:
>
>         struct security_checks_struct {
>                 int (*execve)(struct task_struct *tsk,struct binprm *new);
>                 int (*file_open)(struct file *);
>                 int (*raise_capability)(...
>                 ...
>                 ... selinux had about 140 points they wanted to hook into  ..
>                 ... others probably have a few more.
>                 ...
>         };
>
> and then just have a opaque per-security-model security ID thing scattered
> around in critical places (the obvious being the thread structure, files,
> directory cache, inodes, etc). And instead of having _any_ policy at all,
> the kernel would just call the security procedure. Which might choose to
> fail (-EFASCIST) or might choose to return success but silently downgrade
> the security of the process that does the action, or whatever.
>
> Please understand that from _my_ perspective as a technical OS guy, I
> don't actually care about what the policy is, or who makes it up. I only
> care about not painting Linux into a corner. And I care about it being
> efficient and _conceptually_ simple (it doesn't matter to me if any
> particular security decision is really hard to make or not).
>
> I can live with the overhead of a function pointer access. As Don Knuth
> said: every problem in computer science can be solved with an added level
> of indirection. I'm not interested in the fight between different security
> people. I want the indirection that gets _me_ out of that picture, and
> then the market can fight out which policy and implementation actually
> ends up getting _used_.
>
>                 Linus

  ------------------------------------------------------------------------

Linus Torvalds wrote:

> On Sat, 7 Apr 2001, David Wagner wrote:
>
> > > I would, for example, be willing to entertain the notion of having a
> > > (global or per-process or whatever) pointer to a "security checks"
> > > structure:
> > >
> > >     struct security_checks_struct {
>         ...
> > > and then just have a opaque per-security-model security ID thing scattered
> > > around in critical places (the obvious being the thread structure, files,
> > > directory cache, inodes, etc).
> >
> > Let me suggest a few design issues for consideration:
> >
> >   - State.
>
> Absolutely. This is the "opaque per-security-model security ID thing". You
> absolutely _have_ to have state for a lot of interesting security models.
> In fact, even simple capabilities are "state" - the only common stateless
> security model is the "euid == 0" one, where the "state" is actually just
> super-imposed on the user ID (ie it's really stateful too, it's just that
> the state is shared with "non-security" issues).
>
> >   - Passive vs. active filtering.
>
> Again, passive filtering doesn't actually work. UNIX already has one
> mandated way of active filtering, namely the execve() case for suid
> executables. I would absolutely prefer to see that as just another case of
> filtering, not as some special case.
>
> Which implies that all the other functions might as well also do active
> changes to the security model. Things like "uhhuh, he opened a file that
> was marked secure, we must thus mark the whole process secure and make
> sure that all current and future file descriptors are trusted".
>
> Just returning an error code is not enough. Active side effects are a
> natural and important part of many security models.
>
> >   - Composition of policies.
> >     How are policy extensions combined?  Can we have wuftpd restricted
> >     according to SELinux policy, sendmail according to Janus policy, ...
>
> This is problematic.
>
> The problem is the "security ID". If you allow concurrent security
> policies, they need to have ways of agreeing on the meaning of the
> security ID, or the system needs to support the notion of multiple
> concurrent security ID's (and associate them with the right policy). And
> THAT is hard. It's probably hard enough to not be worth it, and most
> people who want the flexibility would be probably be willing to code up
> the "supercase" in the security manager, instead of trying to mix security
> models dynamically.
>
> This is especially true as the interactions could be "interesting", and
> probably very hard indeed to validate.
>
> In short, my personal opinion would be a big NO, simply from a system
> design standpoint. With one small modifier:
>
> I did suggest a "per-process" security pointer. The reason is that even if
> the system doesn't actually enforce any policy, there obviously _has_ to
> be a default policy. The policy could be anything, from "allow everything"
> to "allow nothing", although the latter would make it really hard to
> bootstrap a system ;)
>
> For obvious reasons, the natural "default policy" is the one that Linux
> already has: capabilities. As that is "nearly stateless" (and can be
> considered essentially stateless if you just leave the current capability
> bits in the process space and do not try to move them into the new "opaque
> security ID" part of the process), that default policy can co-exist with
> any other policy by virtue of not ever actually touching the "opaque
> security ID".
>
> And allowing that co-existence (by having the security action stucture
> pointer be per-process) makes it _much_ easier to have a graceful
> transition to the new scheme. As an example:
>
>  - the system comes up in "legacy" mode with the capabilities (but you
>    might as well think of it as "root user can do anything", because that
>    is hot 99.999% of people end up using the capabilities).
>
>  - the "security environment" is started. Unlike all existing models, this
>    "security environment" doesn't actually have to have _any_ practical
>    compatibility at all with the legacy mode, as those things can be
>    handled ourside the security environment using the proper legacy tools.
>
>  - the system manager might choose, for example, to leave the
>    old-fashioned getty system for the local console, using the default
>    capability system. This way the manager might log in at the system
>    console (but nowhere else), and be completely _outside_ the secure
>    area.
>
> Imagine the implications: your "security manager" doesn't need to actually
> worry about system management at all, because you might have the policy
> that all system management _must_ be done at the physical system console.
> As such, your security policies may not even have the _notion_ of allowing
> for "raised capabilities", and as such there is absolutely no way anybody
> could get higher capabilities than those they started with.
>
> Most traditional security systems need to have _some_ way of getting
> higher privileges for true system management. By using the above
> "per-process security management" setup, you kind of get it for free. You
> might run all your services inside a security model that simply does not
> _have_ a way out. Not for management, not for anything. Because management
> is done completely ourside the security model.
>
> Useful? Sounds useful to me. It also sounds simple to implement, and gives
> you perfect backwards compatibility without the security manager having to
> even worry about it - because the security manager wouldn't even be
> involved in the legacy stuff.
>
> >   - What to interpose on?
> >     Here are a few suggestions for possibilities: interposition on all
> >     system calls; interposition on all VFS calls; on sockets.  What else?
>
> Not at a system call level. It gets too intrusive, and too many people
> (including me) start to worry a _lot_ if you lose even one cycle in the
> system call path. Linux system calls are lightweight, and I like them that
> way.
>
> Also note that the traditional notion of "accounting system calls" is just
> _stupid_. It's the wrong abstraction level. Some system calls do many
> things (think "getxuid()"). Other system calls give direct user-space
> access to objects, so you can only see that you had access to the object,
> you can't actually see _what_ the user did anyway (think "mmap").
>
> You interpose on well-defined abstraction levels. Anything else is a waste
> of time, and useless. Why should you care if the user does a system call:
> sometimes the user can do the same thing by hand, and the system call is
> nothing but a convenience. The extreme case of this would be the whole
> TCP/IP stack: the user _could_ just open a raw packet socket and do its
> own TCP/IP stack totally in user mode. Or think about "gettimeofday()":
> it could be a system call on some architectures, and avaiable in user mode
> on others.
>
> And even when you have meaningful system calls like "write", why interpose
> on that. Nobody cares if you write to /dev/null, while if you write to
> /etc/passwd people might take a second look. You need to get in at the
> _meaningful_ level.
>
> And the system call interface is meaningless in itself. I suspect the only
> reason people focus on hooking into system calls is that it tends to be
> "easy", and a simpel specification - you can ask a summer intern to add
> the hook to monitor every system call. That doesn't make it meaningful.
>
> So add the hooks at the proper level - and make sure they really _are_
> necessary, because people start worrying about performance if you have too
> many function calls, even if they would default to being an immediate
> return in the common case. A cycle here and a cycle there adds up. I'm
> willing to add better security infrastructure, but that doesn't mean that
> I'd be willing to be stupid.
>
> (I know about accounting. And I disagree. What the HELL is the point in
> accounting how many system calls some process made? What does that tell
> you? It tells you _nothing_. Yet every single OS for some reason has hooks
> to accound system calls. That's STUPID.)
>
> Interesting objects to add security ID's to: processes, files, pathnames
> ("dentry" in Linux-speak), inodes (which includes a lot of different cases
> like sockets etc), routes, devices, etc. But _not_ system calls. You add
> the hooks to the actual places that look up (and especially modify) the
> data structures you've tagged.
>
> I'd be surprised if there are many more than 5-10 different object types
> you'd need to tag, and more than maybe 200 places where you'd need to
> intercept then. Total infrastrucure patch size should be on the order of a
> few thousand lines.
>
> (Remember: I'm not interested in the actual security _manager_, which may
> of course be arbitrarily complex in itself. The code _there_ to keep track
> of whatever security tags etc could be hairy and much bigger. But once it
> is encapsulated well enough, that part is no longer an issue from a system
> design perspective).
>
>                 Linus


--------------------------------------------------------------------------------

