Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268508AbRGXXMo>; Tue, 24 Jul 2001 19:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268519AbRGXXMa>; Tue, 24 Jul 2001 19:12:30 -0400
Received: from smtprt16.wanadoo.fr ([193.252.19.183]:58768 "EHLO
	smtprt16.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268518AbRGXXMN>; Tue, 24 Jul 2001 19:12:13 -0400
Message-ID: <3B5E0171.A40386CC@wanadoo.fr>
Date: Wed, 25 Jul 2001 01:14:57 +0200
From: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
Organization: CoolSite
X-Mailer: Mozilla 4.74 [fr] (X11; U; Linux 2.4.4-sb i686)
X-Accept-Language: French, fr, en
MIME-Version: 1.0
To: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
CC: linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
        martizab@libertsurf.fr, rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
In-Reply-To: <3B5C91DA.3C8073AC@wanadoo.fr> <20010724090704.A27771@pimlott.ne.mediaone.net> <3B5DACDA.69D0B81A@wanadoo.fr> <20010724150535.B27771@pimlott.ne.mediaone.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Andrew Pimlott a écrit :
> 
> On Tue, Jul 24, 2001 at 07:14:02PM +0200, Jerome de Vivie wrote:
> > Andrew Pimlott a ?crit :
> > > per-user?  So how do I let another developer look at what I'm
> > > working on?  In ClearCase, it's one private version per-view, which
> > > is much more flexible.
> >
> > No.
> 
> So you're saying if I have a file on my UFL, there's no way anyone
> else can see it unless I copy it to another filesystem?

Yes, that's exactly what i want: a working file must be private unless
the developper as decide to share it . An individual developper is not
impacted by external changes (like with the "LATEST" rule in clearcase)
and doesn't interact with other developpers. That's very important in
SCM !


> > > If I have to check in all files at once, it is even more important
> > > that I be able to have multiple "views".  What if, in the middle of
> > > a big change, I make a small fix that I want to check in
> > > independently?
> >
> > It's impossible. If you want to go back, you have to put a label on
> > each step you want and, set the $CONFIGURATION to this label.
> 
> Again, this seems exceedingly restrictive.

Regression is exactly what we try to avoid when we work under SCM. What
is done is done. If you really want, you can labelize after each write 
but your must NOT modify the past !

Labelizing is the same things that doing ci/co but at a coarser grain 
This level must exactly match your needs ( ... and with less overhead).


> > > You just threw away the most useful feature of filesystem
> > > integration: comparing different versions.  How do I do this if
> > > everything is keyed off $CONFIGURATION?
> >
> > With 2 process and shared memory, it should be possible but i haven't
> > though deeper.
> 
> Standard tools, please.  (Can I tell you how painful I would find
> ClearCase if I had to use their diff instead of GNU diff?)


Ok, now i am more oriented throw a userspace SCM. Perhaps i will use a
naming convention a la clearcase (ie: filename@@label ) and, with this
namespace, you will be able to use all your favourite UNIX tools.


> I said, compared to CVS, not ClearCase!  The analog in CVS is
> - cvs checkout
> - cvs update
>
> The only advantages your have are 1) you don't have to specify the
> repository/modules and 2) you're faster.

CVS deals with versionning and not configuration management, so you
can't compare them.

> 
> Also, you have left out at least one important step.  Say I set
> CONFIGURATION=A, do my work, and label it with B.  How do other
> developers know to switch to B?   

Labels are public and i hope there are meeting organized between
developpers !

> What if they're already working
> off A--how do they merge up their private copies?

Like the naming scheme above:
$merge filename@@A   filename@@B


> 
> If you say your system is not intended for concurrent development, I
> think it is not worth doing.  And from what I can see, you're
> building in restrictions that would make concurrent development
> hard.


??????????????????????????
? Where have I said this ?
??????????????????????????


> > Using the same system
> > (labelization) to identify both individual version and configuration
> > is also a neat idea.

> 
> It is neat, but eventually will become a pain in the neck.  You'll
> need a way to come up with a unique label for every checkin, so you
> will inevitably just decide to use incrementing numbers, so pretty
> soon you will end up with files having versions 1, 5, 329, and
> 18473.  Ugh.

The first goal of SCM is to physicaly identify your software . This 
goal is achieve. After, it's up to you to choose a good naming
convention for labels. And yes, it's neat ;-)

regards,

j.

-- 
Jerome de Vivie 	jerome . de - vivie @ wanadoo . fr
