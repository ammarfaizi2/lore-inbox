Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVDYBh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVDYBh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 21:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVDYBh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 21:37:27 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:43904 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262412AbVDYBhK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 21:37:10 -0400
Date: Mon, 25 Apr 2005 02:35:45 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@sheen.jakma.org
To: "David A. Wheeler" <dwheeler@dwheeler.com>
cc: Linus Torvalds <torvalds@osdl.org>, Sean <seanlkml@sympatico.ca>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       David Woodhouse <dwmw2@infradead.org>, Jan Dittmer <jdittmer@ppp0.net>,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Git-commits mailing list feed.
In-Reply-To: <426C4168.6030008@dwheeler.com>
Message-ID: <Pine.LNX.4.62.0504250212200.14200@sheen.jakma.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>      
 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>      
 <426A4669.7080500@ppp0.net>       <1114266083.3419.40.camel@localhost.localdomain>
       <426A5BFC.1020507@ppp0.net>       <1114266907.3419.43.camel@localhost.localdomain>
       <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>      
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>      
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1>
 <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org>
 <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org> <426C4168.6030008@dwheeler.com>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2005, David A. Wheeler wrote:

> It may be better to have them as simple detached signatures, which 
> are completely separate files (see gpg --detached). Yeah, gpg 
> currently implements detached signatures by repeating what gets 
> signed, which is unfortunate, but the _idea_ is the right one.

Hmm, what do you mean by "repeating what gets signed"?

> Yes, and see my earlier posting.  It'd be easy to store signatures in
> the current objects directory, of course.  The trick is to be able
> to go from signed-object to the signature;

Two ways:

1. An index of sigs to signed-object.

(or more generally: objects to referring-objects)

2. Just give people the URI of the signature, let them (or their
    tools) follow the 'parent' link to the object of interest

> this could be done just by creating a subdirectory using a variant 
> of the name of the signed-object's file, and in that directory 
> store the hash values of the signatures.  E.G.:

> 00/
>    3b128932189018329839019          <- object to sign
>    3b128932189018329839019.d/
>    0143709289032890234323451
> 01/
>    43709289032890234323451          <- signature

You could hack it in to the namespace somehow I guess. I'm not sure 
hacking it in would be a good thing though.

I think it might be more useful just to provide a general index to 
lookup 'referring' objects (if git does not already - I dont think it 
does, but I dont know enough to know for sure). So you could ask 
"which {commit,tag,signature,tree}(s) refer(s) to this object?" - 
that general concept will always work. If you wanted to make the 
implementation of this index use some kind of sub directory as in the 
above, fine..

See also method 2 above. Which would be more efficient for tools if, 
within a project, some developers sign their 'updates' and some 
dont.. (you never need to check whether there's a signature or not - 
you'll know it from the URI automatically).

> There are LOTS of reasons for storing signatures so that they can 
> be checked later on, just like there are lots of reasons for 
> storing old code... they give you evidence that the reputed history 
> is true (and if you doubt it, they give you a way to limit the 
> doubt).

Indeed.

Anyway, we shall see what Linus does. :)

(But I do hope at least that signatures are /not/ included inline 
using BEGIN PGP.. in the object that is signed.)

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
To err is human, to purr feline.
To err is human, two curs canine.
To err is human, to moo bovine.
