Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266129AbRGXX6W>; Tue, 24 Jul 2001 19:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266130AbRGXX6C>; Tue, 24 Jul 2001 19:58:02 -0400
Received: from sdsl-66-80-62-153.dsl.sca.megapath.net ([66.80.62.153]:49931
	"EHLO ripple.fruitbat.org") by vger.kernel.org with ESMTP
	id <S266129AbRGXX5n> convert rfc822-to-8bit; Tue, 24 Jul 2001 19:57:43 -0400
Date: Tue, 24 Jul 2001 16:57:00 -0700 (PDT)
From: "Peter A. Castro" <doctor@FRUITBAT.ORG>
To: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
cc: Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
        martizab@libertsurf.fr, rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
In-Reply-To: <3B5CA2EC.2498775@wanadoo.fr>
Message-ID: <Pine.LNX.4.21.0107241641140.27262-100000@gremlin.fruitbat.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 24 Jul 2001, Jerome de Vivie wrote:

> Rik van Riel a écrit :
> > 
> > On Mon, 23 Jul 2001, Larry McVoy wrote:
> > 
> > > b) Filesystem support for SCM is really a flawed approach.
> > 
> > Agreed.  I mean, how can you cleanly group changesets and
> > versions with a filesystem level "transparent" SCM ?
> 
> With label !
> 
> In my initial post, i have explain that labels are used to 
> identify individual files AND are also uses to select for 
> each files of a set, one version (= select a configuration). 
> It works !

.. and essentially you've re-created Rational's ClearCase implementation.
The problem becomes: how will you specify that label for file version
selection?  Will it be part of the filename?  Will it be implied in a
configuration specificier (config spec)?  Will that config spec be global
to the system, local to the user or just that session?  Will it be stored
in a file or part of the filesystems mount parameters?

These are the same problems Rational faced with ClearCase and it's mvfs.
To maintain a config spec design you'll need essentially a database to
contain the labels and their relationship to a given version & branch of
a particular file.  So, suddenly it's not just a filesystem, it's now a
database with external chunks of data.

> > The goal of an SCM is to _manage_ versions and changesets,
> > if it doesn't do that we're back at CVS's "every file its
> > own versioning and to hell with manageability" ...

Really, the whole of the problem needs to be reviewed, not just the
individual parts.  I seem to recall someone implementing a filesystem
that stored the files in a Postgres database that did versioning of files
in a simple way.  I thought that was rather novel, at the time.  You
really need to think out the unifying mechanism first.  The storage of
versions of each file will be an end result.  Think more about how the
user will actually use it and manipulate the selection.

> versioning is yet a first step.
> 
> j.

-- 
Peter A. Castro <doctor@fruitbat.org> or <Peter.Castro@oracle.com>
	"Cats are just autistic Dogs" -- Dr. Tony Attwood

