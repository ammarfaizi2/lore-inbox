Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261967AbTCMCdm>; Wed, 12 Mar 2003 21:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262001AbTCMCdm>; Wed, 12 Mar 2003 21:33:42 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:11400 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S261967AbTCMCdk>; Wed, 12 Mar 2003 21:33:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Werner Almesberger <wa@almesberger.net>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Date: Thu, 13 Mar 2003 03:48:17 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030311192639.E72163C5BE@mx01.nexgo.de> <20030312031407.W2791@almesberger.net>
In-Reply-To: <20030312031407.W2791@almesberger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030313024421.9C6DC109407@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12 Mar 03 07:14, Werner Almesberger wrote:
> Daniel Phillips wrote:
> > Coincidently, I was having a little think about that exact thing earlier
> > today.  Suppose we call the process of turning an exact delta into a
> > delta-with-context, "softening".
>
> Why not just make all deltas "soft" and just ignore the context in
> cases when you're absolutely sure you can ? (Provided that such
> cases exist and aren't trivial.)

Just because there's no point in storing context that you don't have to, and 
when you get into more sophisticated operations on deltas, you'd just 
introduce a first step of discarding the context in many cases.

> > A soft changeset can be carried forward in the database automatically as
> > long as there are no conflicts
>
> You probably also want to be able to apply them to different
> views, e.g. if I fix X, I may send it off to integration, and
> also apply it independently to my projects Y and Z. When X gets
> merged into whatever I consider my "mainstream" (again, that's a
> local decision, e.g. it may be Linus' tree, plus net/* and anything
> related to changes in net/* from David Miller), I may want to get
> notified, e.g. if there's a conflict, but also such that I can drop
> that part from my fix (which may contain elements that I didn't
> push yet).

Yes, and if we have the concept of a versioned changeset, your system will 
notice automatically that Linus applied either exactly what you sent him or a 
descendent (i.e., he had to massage it, but his history still recorded the 
fact that he started with your changeset) so your system will know to 
automatically reverse your original version during your next merge with 
Linus.  Um, if Linus is using this new spiffy system of course, you may want 
to substitute "Pavel" in the above.

> > and generate a new soft changeset against some other version.  A name for
> > the versioned soft changeset can be generated automatically, e.g.:
> >
> >    changset.name-from.version-to.version.
>
> Hmm, I'd distinguish three elements in a change set's name:
>
>  - its history (i.e. all changesets applied to the file(s)
>    when the change set was created)
>  - a globally unique ID
>  - a human-readable title that doesn't need to be perfectly
>    unique

Such things as history (if you need it) and globally-unique id can be tucked 
into the header of the changeset.  The unique id is good, means you can let 
names collide.  For the name itself, I personally am mostly interested in the 
catchy moniker I thought up for the patch, um, I mean changeset, the kernel 
version it applies to, and a sequence number in case I generate more than one 
version against the same kernel, so that when I post the changsets on the 
web, people can find the file they need.  Boring huh?

Naming is a matter of taste, and you ought to be able to do it according to 
your own taste, including hooking in your own name-generating script.

> I think, for simplicity, changesets should just carry their history
> with them. This can later be compressed, e.g. by omitting items
> before major convergence points (releases), by using automatically
> generated reference points, or simply by fetching additional
> information from a repository if needed (hairy).

I would not call that hairy, it sounds more like fun.  The hairy part is 
getting the underlying framework to function properly.  Larry is entirely 
correct in pointing out that it's hard, though in my opinion, not nearly as 
hard as kernel development.  Your edit/compile/test cycle is a fraction as 
long for one thing.

Regards,

Daniel
