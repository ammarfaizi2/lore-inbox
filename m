Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130883AbRBTVUl>; Tue, 20 Feb 2001 16:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130899AbRBTVUc>; Tue, 20 Feb 2001 16:20:32 -0500
Received: from windsormachine.com ([206.48.122.28]:29447 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S130881AbRBTVUT>; Tue, 20 Feb 2001 16:20:19 -0500
Message-ID: <3A92DF84.E39E415C@windsormachine.com>
Date: Tue, 20 Feb 2001 16:20:04 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Jackson <jeremy.jackson@sympatico.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <01022020011905.18944@gimli> <96uijf$uer$1@penguin.transmeta.com> <3A92DCE0.BEE5E90E@sympatico.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the way i'm reading this, the problem is there's 65535 files in the directory
/where/postfix/lives.  rm * or what have you, is going to take forever and
ever, and bog the machine down while its doing it.  My understanding is you
could do the rm *, and instead of it reading the tree over and over for every
file that has to be deleted, it just jumps one or two blocks to the file that's
being deleted, instead of thousands of files to be scanned for each file
deleted.

Jeremy Jackson wrote:

> > In article <01022020011905.18944@gimli>,
> > Daniel Phillips  <phillips@innominate.de> wrote:
> > >Earlier this month a runaway installation script decided to mail all its
> > >problems to root.  After a couple of hours the script aborted, having
> > >created 65535 entries in Postfix's maildrop directory.  Removing those
> > >files took an awfully long time.  The problem is that Ext2 does each
> > >directory access using a simple, linear search though the entire
> > >directory file, resulting in n**2 behaviour to create/delete n files.
> > >It's about time we fixed that.
>
> In the case of your script I'm not sure this will help, but:
> I've seen /home directories organised like /home/a/adamsonj,
> /home/a/arthurtone, /home/b/barrettj, etc.
> this way (crude) indexing only costs areas where it's needed,
> without kernel modification. (app does it)  What other placed would we
> need indexing *in* the filesystem?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

