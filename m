Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263053AbTCLGDk>; Wed, 12 Mar 2003 01:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbTCLGDk>; Wed, 12 Mar 2003 01:03:40 -0500
Received: from almesberger.net ([63.105.73.239]:10000 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S263053AbTCLGDh>; Wed, 12 Mar 2003 01:03:37 -0500
Date: Wed, 12 Mar 2003 03:14:08 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Daniel Phillips <phillips@arcor.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030312031407.W2791@almesberger.net>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030311184043.GA24925@renegade> <22230000.1047408397@flay> <20030311192639.E72163C5BE@mx01.nexgo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030311192639.E72163C5BE@mx01.nexgo.de>; from phillips@arcor.de on Tue, Mar 11, 2003 at 08:30:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Coincidently, I was having a little think about that exact thing earlier 
> today.  Suppose we call the process of turning an exact delta into a 
> delta-with-context, "softening".

Why not just make all deltas "soft" and just ignore the context in
cases when you're absolutely sure you can ? (Provided that such
cases exist and aren't trivial.)

> A soft changeset can be carried forward in the database automatically as long 
> as there are no conflicts

You probably also want to be able to apply them to different
views, e.g. if I fix X, I may send it off to integration, and
also apply it independently to my projects Y and Z. When X gets
merged into whatever I consider my "mainstream" (again, that's a
local decision, e.g. it may be Linus' tree, plus net/* and anything
related to changes in net/* from David Miller), I may want to get
notified, e.g. if there's a conflict, but also such that I can drop
that part from my fix (which may contain elements that I didn't
push yet).

Not all of this needs to be known to the SCM if the right tagging
tools are available to users. In fact, limiting the number of work
flows inherently supported by the SCM would probably be a
feature :-)

> and generate a new soft changeset against some other version.  A name for the 
> versioned soft changeset can be generated automatically, e.g.:
> 
>    changset.name-from.version-to.version.

Hmm, I'd distinguish three elements in a change set's name:

 - its history (i.e. all changesets applied to the file(s)
   when the change set was created)
 - a globally unique ID
 - a human-readable title that doesn't need to be perfectly
   unique

I think, for simplicity, changesets should just carry their history
with them. This can later be compressed, e.g. by omitting items
before major convergence points (releases), by using automatically
generated reference points, or simply by fetching additional
information from a repository if needed (hairy).

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
