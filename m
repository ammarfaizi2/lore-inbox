Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292150AbSBBAPN>; Fri, 1 Feb 2002 19:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292152AbSBBAOy>; Fri, 1 Feb 2002 19:14:54 -0500
Received: from femail19.sdc1.sfba.home.com ([24.0.95.128]:33154 "EHLO
	femail19.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S292150AbSBBAOe>; Fri, 1 Feb 2002 19:14:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Rik van Riel <riel@conectiva.com.br>,
        Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Subject: Bitkeeper change granularity (was Re: A modest proposal -- We need a patch penguin)
Date: Fri, 1 Feb 2002 19:15:42 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Larry McVoy <lm@work.bitmover.com>, Keith Owens <kaos@ocs.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0202010926080.17106-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0202010926080.17106-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020202001433.TBFE18525.femail19.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 February 2002 06:30 am, Rik van Riel wrote:
> On Fri, 1 Feb 2002, Horst von Brand wrote:
> > I wonder how your commercial customers develop code then. Either each
> > programmer futzes around in his/her own tree, and then creates a patch
> > (or some such) for everybody to see (then I don't see the point of
> > source control as a help to the individual developer), or everybody
> > sees all the backtracking going on everywhere (in which case the
> > repository is a mostly useless mess AFAICS).
>
> If the object is to minimise confusion by not showing
> back-tracked changes, why not simply allow the user
> to mark changesets with a "visibility":
>
> 1) hidden, for stuff which shouldn't be seen by default,
>    like backed out changes, etc..
> 2) small, individual development steps to achieve a new
>    feature
> 3) normal, the normal commits
> 4) major (tagged versions ?)
>
> This way the user can select how detailed the overview
> of the versions should be.

A workaround, not a fix.

First of all, not everybody's got a 100 gigabyte drive, cable modem, and 
Athlon 900 yet.  You're talking about potentially taking accidental cruft 
from everybody who uses bitkeeper in 5 years.  Some countries still pay for 
data by the byte, and big servers like kernel.org still care about bandwidth 
issues a lot.

Yeah data storage and transfer, and the memory and CPU power to churn through 
it, is getting cheaper all the time.  But we're talking about expending 
resources shoveling information that even the original developer considers 
completely pointless to maintain and propogate.  Your bitkeeper repositories 
could become enormous.  The amount of proagated state would at least by 
multiplied by the number of developers working on the tree who use bitkeeper, 
meaning spreading the use of bitkeeper would have distinct downsides.  The 
result is that maintainers/lieutenants/linus would almost certainly want to 
take a clean patch rather than a bitkeeper cruftball, on the size and 
cleanliness issue alone.

Secondly, it makes Linus's code review job a LOT harder to have unnecessary 
data in his change sets.  And of course you could say "Linus would never have 
to look at that info", but you'd be wrong.  Stupid example: Somebody patches 
a file to include a copy of decss (or encryption code, or the copyrighted 
ramblings of the lawsuit-happy cult of scientology) and then adds another 
patch to revert it before making a small fix to the file.  The bitkeeper 
change now includes legally questionable code in its back-history, a hot 
potato we probably REALLY don't want to be involved with.

You don't have to worry about malicious use to see a problem.  For-profit 
intellectual property companies generally want to be really clear about what 
code they export.  Think about proprietary drivers that get "cleaned up" 
before being released under the GPL, with the removal code licensed from 
third parties, or patented, or still-proprietary code.  If they can't 
collapse changesets, they simply can't use bitkeeper change sets when 
communicating source code with anyone outside their organization.  Ever.  End 
of story.  Who knows what code might slip through otherwise?  They have to 
audit the entire revision history rather than just the patch they mean to 
send.  That's a nightmare.  The lawyers would never approve ANYTHING for 
release, except as a patch file.

So Linus wouldn't want it, for-profit companies wouldn't want to give it to 
Linus, developers on the end of a 56k modem wouldn't want it, and it could 
potentially cost sites kernel.org a lot of extra bandwidth and data storage 
charges.  This is in exchange for a the possibility that some future 
archeologist or grad student might want to mine the history for anecdotes to 
put in the biography of some developer.

(I'm writing a history book, by the way.  I know all about having 10x as much 
detail as you are ever going to use, because I -AM- the researcher.  Go visit 
the charles babbage institute at the university of minnesota sometime.  It's 
great, but it's not actually all that useful unless you really are looking 
for something specific...)

Another random anecdote on the subject...

http://groups.google.com/groups?selm=789312483snz%40unseen.demon.co.uk

> Also, when viewing a changeset/version of a certain
> priority, bitkeeper could optionally "fold in" the
> hidden changesets between the last changeset and the
> one the user wants to view.
>
> Would this be a workable scheme ?

Depends on your definition of "workable".  It's certainly an improvement, but 
it's still not a fix for the fundamental design assumption in bitkeeper.  
When I do NOT want to propagate my internal state to the rest of the world, I 
seem to have no choice in the matter except by NOT using bitkeeper to 
transfer the data.

I agree that the ability to at least hide stuff would be an improvement.  And 
it should be easily implementable in combination with a checkpoint/tagging 
mechanism (it's just a view issue), but it's still working around a fault in 
bitkeeper that it has no real infrastructure for collapsing together change 
sets in a way that intentionally loses information when that really is what 
you want to do.  The most it could do is hide the problem.

> (keeps the bitkeeper repository intact, can reduce
> the confusion)

Yeah.  But the point is that people often honestly do not want to keep the 
bitkeeper repository intact.

Think about partitioning into different repositories, to do development in 
different branches.  If people don't want to be able to partition their data, 
bitkeeper wouldn't have the concept of multiple repositories on the same 
machine, would it?  You can partition data when you store it, but not 
partition it when you propagate it.  (The concept here is "this info does not 
leave my tree".  This is a concept people really do want.)

It's possible this could be handled by doing ALL new development work in a 
seperate repository, and then ONLY exporting patches from that repository and 
never doing bitkeeper repository merges.  But it's still working around a 
design flaw in bitkeeper.  The way bitkeeper is designed forces you to retain 
cruft you don't want, and actively tries to prevent you from being able to 
get rid of any of it.  I.E. there are things you can do with "diff" and 
"patch", fairly easily, which are not possible to do without bypassing 
bitkeeper.

I can see the mindset that went into that, but I disagree with it.

> regards,
>
> Rik

Rob

(P.S.  You know, If larry gave us the code to bitkeeper, I'm sure we could 
add the features we wanted.... :)

(P.P.S.  Yeah, I know the story on that one, just tweaking his nose...)
