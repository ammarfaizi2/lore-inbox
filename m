Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286962AbSA1WNq>; Mon, 28 Jan 2002 17:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSA1WNi>; Mon, 28 Jan 2002 17:13:38 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:8328
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S286942AbSA1WN1>; Mon, 28 Jan 2002 17:13:27 -0500
Message-Id: <200201282213.g0SMDcU25653@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: A modest proposal -- We need a patch penguin
Date: Mon, 28 Jan 2002 09:10:56 -0500
X-Mailer: KMail [version 1.3.1]
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        davej@suse.de (Dave Jones), esr@thyrsus.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch Penguin Proposal.

 1) Executive summary.
 2) The problem.
 3) The solution.
 4) Ramifications.

 -- Executive summary.

Okay everybody, this is getting rediculous. Patches FROM MAINTAINERS are 
getting dropped on the floor on a regular basis. This is burning out 
maintainers and is increasing the number of different kernel trees (not yet a 
major fork, but a lot of cracks and fragmentation are showing under the 
stress). Linus needs an integration lieutenant, and he needs one NOW.

We need to create the office of "patch penguin", whose job would be to make 
Linus's life easier by doing what Alan Cox used to do, and what Dave Jones is 
unofficially doing right now. (In fact, I'd like to nominate Dave Jones for 
the office, although it's Linus's decision and it would be nice if Dave got 
Alan Cox's blessing as well.)

And if we understand this position, and formalize it, we can make better use 
of it. It can solve a lot of problems in linux development.

 -- The problem.

Linus doesn't scale, and his current way of coping is to silently drop the 
vast majority of patches submitted to him onto the floor. Most of the time 
there is no judgement involved when this code gets dropped. Patches that fix 
compile errors get dropped. Code from subsystem maintainers that Linus 
himself designated gets dropped. A build of the tree now spits out numerous 
easily fixable warnings, when at one time it was warning-free. Finished code 
regularly goes unintegrated for months at a time, being repeatedly resynced 
and re-diffed against new trees until the code's maintainer gets sick of it. 
This is extremely frustrating to developers, users, and vendors, and is 
burning out the maintainers. It is a huge source of unnecessary work. The 
situation needs to be resolved. Fast.

If you think I'm preaching to the choir, skip to the next bit called "the 
solution". If not, read on...

The Linux tree came very close to forking during 2.4. We went eleven months 
without a development tree. The founding of the Functionally Overloaded Linux 
Kernel project was a symptom of an enormous unintegrated patch backlog 
building up pressure until at least a small fork was necessary. Even with 2.5 
out, the current high number of seperate development trees accepting 
third-party is still alarmingly high. Linus and Marcelo have been joined by 
Dave Jones, Alan Cox, Andrea Arcangeli, Michael Cohen, and others, with 
distributors maintaining their own significantly forked kernel trees as a 
matter of course. Developers like Andrea, Robert Love and Rik van Riel either 
distribute others' relatively unrelated patches with their patch sets, or 
base their patches on other, as yet unintegrated patches for extended periods 
of time.

Discussion of this problem was covered by kernel traffic and Linux Weekly 
News:

http://kt.zork.net/kernel-traffic/kt20020114_150.html#5
http://lwn.net/2002/0103/kernel.php3 (search for "patch management").

During 2.4, the version skew between Alan Cox's tree and Linus's tree got as 
bad as it's ever been. Several of the bug fixes in Alan's tree (which he 
stopped maintaining months ago) still are not present in 2.4.17 or 2.5. Rik 
van Riel has publicly complained that Linus dropped his VM patches on the 
floor for several months, a contributing factor to the 2.4 VM's failure to 
stabilize for almost a -YEAR- after its release. (This is a bad sign. Whether 
Rik's or Andrea's VM is superior is a side issue. Alan Cox, and through him 
Red Hat, got Rik's VM to work acceptably by integrating patches from that 
VM's maintainer. The fact Linus didn't do as well is a symptom of this larger 
problem. The kind of subsystem swapping so major it requires a new maintainer 
should not be necessary during a stable series.)

Speaking of Andrea Arcangeli, he's now integrating third-party patches into 
his own released development trees, because 2.5 isn't suitable to do 
development against and 2.4 doesn't have existing work (like low latency) 
he's trying to extend.

Andre Hedrick just had to throw a temper tantrum to get any attention paid to 
his IDE patches, and he's the official IDE maintainer. Eric Raymond tells me 
his help file updates have now been ignored for 33 consecutive releases 
(again, he's the maintainer), and this combined with recent major changes 
Linus unilaterally made to 2.5's help files (still without syncing with the 
maintainer's version before doing so) has created a lot of extra and totally 
unnecessary work for Eric, and he tells me it's made the version skew between 
2.4 and 2.5 almost unmanageable.

Andrew Morton's lock splitting low latency work has no forseeable schedule 
for inclusion, despite the fact it's needed whether or not Robert Love's 
preemption patch goes in. Ingo Molnar's O(1) scheduler did go in, but that 
was largely a case of good timing: it came right on the heels of a public 
argument about why Linus had not accepted patches to the scheduler for 
several years. The inclusion of code like JFS, XFS, and Daniel Phillips' ext2 
indexing patch are left up to distributions to integrate and ship long before 
they make it into Linus's tree. (Remember the software raid code in 2.2?) 
These are just the patches that have persisted, how much other good work 
doesn't last because its author loses interest after six months of the silent 
treatment? The mere existence of the "Functionally Overloaded Linux Kernel" 
(FOLK) project, to collect together as many unintegrated patches as possible, 
was a warning sign that things were not going smoothly on the patch 
integration front.

The release of 2.5 has helped a bit, but by no means solved the problem. Dave 
Jones started his tree because 2.4 fixes Marcello had accepted were not 
finding their way into 2.5. Even code like Keith Owens' new build system and 
CML2, both of which Linus approved for inclusion at the Kernel summit almost 
a year ago and even tentatively scheduled for before 2.5.2, are still not 
integrated with no clear idea if they ever will be. (Yes Linus can change his 
mind about including them, but total silence isn't the best way to indicate 
this. Why leave Keith and Eric hanging, and wasting months or even years of 
their time still working on code Linus may not want?)

The fact that 2.5 has "pre" releases seems suggestive of a change in mindset. 
A patch now has to be widely used, tested, and recommended even to get into 
2.5, yet how does the patch get such testing before it's integrated into a 
buildable kernel? Chicken and egg problem there, you want more testing but 
without integration each testers can test fewer patches at once.

There has even been public talk of CRON jobs to resubmit patches to Linus 
periodically for as long as it takes him to get around to dealing with them. 
Linus has actually endorsed this approach (provided that re-testing of the 
patches against the newest release before they are remailed is also 
automated). This effort has spawned a mailing list. That's just nuts. The 
fact that Linus doesn't scale isn't going to be solved by increasing the 
amount of mail he gets. When desperate measures are being seriously 
considered, we must be in desperate times.

-- The solution.

The community needs to offload some work from Linus, so he can focus on what 
he does that nobody else can. This offloading and delegation has been done 
before, with the introduction of subsystem maintainers. We just need to 
extend the maintainer concept to include an official and recognized 
integration maintainer.

During 2.1, when Linus burned out, responsibility for various subsystems were 
delegated to lieutenants to make Linus' job more manageable. Lieutenants are 
maintainers of various parts of the tree who collect and clean up patches, 
and make the first wave of obvious decisions ("this patch doesn't apply", 
"this bit doesn't compile", "my machine panicked", "look, it's not SMP safe") 
before sending tested code off to Linus. Linus still spends a lot of his time 
reading and auditing code, but by increasing the average quality of the code 
Linus looks at, the maintainers make his job easier. The more work 
maintainers can do the less Linus has to.

So what tasks does Linus still personally do? He's an architect. He steers 
the project, vetoing patches he doesn't like and suggesting changes in 
direction to the developers. And he's the final integrator, pulling together 
dispirate patches into one big system.

The job of architect is something only Linus can do. The job of integrator is 
something many people can do. Alan Cox did it for years. Dave Jones is doing 
it now, and Michael Cohen has yet another tree. Every Linux distributor has 
its own tree. Integrating patches so they don't conflict and porting them to 
new versions is hard work, but not brain surgery.

Linus is acting as a central collection point for patches, and patches are 
getting lost on their way to that collection point. Patches as big as UML and 
EXT3 were going into Alan Cox's tree during 2.4, and now new patches are 
going into Dave Jones's tree to be tested out and queued for Linus.

Integration is a task that can be delegated, and it has been. In Perl's 
model, Larry Wall is the benevolent dictator and architect, but integration 
work is done by the current holder of the "patch pumpkin". In Linux, Alan Cox 
used to be the de facto holder of the patch penguin, and now Dave Jones is 
maintaining a tree which can accept and integrate patches, and then feed them 
on to Linus when Linus is ready.

This system should be formalized, we need the patch penguin to become 
official. The patch penguin seems to have passed from Alan Cox to Dave Jones. 
If we recognize this, we can make much better use of it.

 --- Ramifications.

The holder of the patch penguin's job would be to accept patches from people 
other than linus, make them work together in a publicly compilable and 
testable tree, and feed good patches on to Linus. This may sound simple and 
obvious, but it's currenlty not happening and its noticeable by its absence.

The purpose of the patch penguin tree is to make life easier, both for Linus 
and the developer community. With a designated patch collector and 
integrator, Linus's job becomes easier. Linus would still maintain and 
release his own kernel trees (the way he did when Alan Cox regularly fed him 
patches), and Linus could still veto any patch he doesn't like (whether it 
came from the patch penguin, directly from a subsystem maintainer, or 
elsewhere). But Linus wouldn't be asked to act as the kernel's public CVS 
tree anymore. He could focus on being the architect.

The bulk of the patch penguin's work would be to accept, integrate, and 
update patches from designated subsystem maintainers, maintaining his own 
tree (seperate from linus's) containing the integrated collection of pending 
patches awaiting inclusion in Linus's tree. Patches submitted directly to the 
patch penguin could be redirected to subsystem maintainers where appropriate, 
or bounced with a message to that effect (at the patch penguin's option). 
This integration and patch tracking work is a fairly boring, thankless task, 
but it's work somebody other than Linus can do, which Linus has to do 
otherwise. (And which Linus is NOT doing a good job at right now.)

The rest of the patch-penguin holder's job is to feed Linus patches. The 
patch penguin holder's tree would fundamentally be a delta against the most 
recent release from Linus (like the "-ac patches" used to be). If Linus takes 
several releases to get around to looking at a new patch, the patch penguin 
would resynchronize their tree with each new Linus release, doing the fixups 
on the pending patch set (or bullying the source of each patch into doing 
so). It would be the patch penguin's job to keep up with Linus, not the other 
way around. When a change happens in Linus's tree that didn't come from the 
patch penguin, the patch penguin integrates the change into their tree 
automatically.

The holder of the patch penguin would feed Linus good patches, by Linus's 
standards. Not just tested ones, but small bite-sized patches, one per email 
as plain text includes, with an explanation of what each patch does at the 
top of the mail. (Just the way Linus likes them. :) Current pending patches 
from the patch penguin tree could even be kept at a public place (like 
kernel.org) so Linus could pull rather than push, and grab them when he has 
time. The patch penguin tree would make sure that when Linus is ready for a 
patch, the patch is ready for Linus.

The patch penguin tree can act as a buffer between Linus and the flood of 
patches from the field. When Linus is not ready for a patch yet, he can hold 
off on taking it into his tree, and doesn't have to worry about the patch 
being lost or out of date by the time he's ready to accept it. When Linus is 
focusing on something like the new block I/O code, the backlog of other 
patches naturally feeds into the patch penguin tree until Linus is ready to 
look at them. People won't have to complain about dropped patches, and Linus 
doesn't have to worry that patches haven't been tested enough before being 
submitted to him. Users who want to live on the really bleeding edge have a 
place to go for a kernel that's likely to break. Testers can find bugs en 
masse without having to do integration work (which is in and of itself a 
source of potential bugs).

Linus would still have veto power. He gets to reject any patch he doesn't 
like, and can ask for the integration lieutenant to back that patch out of 
the patch penguin tree. That's one big difference between the patch penguin 
tree and Linus's tree: the patch penguin tree is provisional. Stuff that goes 
in it can still get backed out in a version or two. Of course Linus would 
have to explicitly reject a patch to get it out of the patch penguin tree, 
meaning its developer stops fruitlessly re-submitting it to Linus, and maybe 
even gets a quick comment from Linus as to WHY it was unacceptable so they 
can fix it. (From the developer's point of view, this is a good thing. They 
either get feedback of closure.)

Linus sometimes needs time off. Not just for vacations, but to focus on 
specific subsections, like integrating Jens Axobe's BIO patches at the start 
of 2.5. Currently, these periods hopelessly stall or tangling development. 
But in Linus's absence, the patch penguin could continue to maintain a delta 
against the last Linus tree, and generate a sequence of small individual 
patches like a trail of bread crumbs for Linus to follow when he gets back. 
Linus could take a month off, and catch back up in a fraction of that time 
when he returned. (And if Linus were to get hit by a bus, the same 
infrastructure would allow the community to select and support a new 
architect, which might help companies like IBM sleep better at night.) And if 
Linus rejected patches halfway through the bread crumb trail requiring a lot 
of shuffling in later patches, well, that's more work for the patch penguin, 
not more work for Linus.

One reason Linus doesn't like CVS is he won't let other people check code 
into his tree. (This is not a capricious decision on Linus's part: no 
architect can function if he doesn't know what's in the system. Code review 
of EVERYTHING is a vital part of Linus's job.) With a patch penguin tree, 
there's no more pressure on Linus to use CVS. The patch penguin can use CVS 
if he wants to, and if he wants to give the subsystem maintainers commit 
access to the patch penguin tree, that's his business. The patch penguin's 
own internal housekeeping toolset shouldn't affect the patches he feeds on to 
Linus one way or the other.

Again, Linus likes stuff tested by a wide audience before it's sent to him. 
With a growing list of multiple trees maintained by Dave Jones, Alan Cox, 
Michael Cohen, Andrea Arcangeli, development and testing become fragmented. 
With a single patch penguin tree, the patches drain into a common pool and 
the backlog of unintegrated patches can't build up dangerous amounts of 
pressure to interfere with development. A single shared "pending" tree means 
the largest possible group of potential testers.
