Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292476AbSBPSTq>; Sat, 16 Feb 2002 13:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292477AbSBPSTh>; Sat, 16 Feb 2002 13:19:37 -0500
Received: from femail34.sdc1.sfba.home.com ([24.254.60.24]:54159 "EHLO
	femail34.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S292476AbSBPSTS>; Sat, 16 Feb 2002 13:19:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: esr@thyrsus.com
Subject: Re: Disgusted with kbuild developers
Date: Sat, 16 Feb 2002 13:20:06 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Dave Jones <davej@suse.de>, Larry McVoy <lm@work.bitmover.com>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020215135557.B10961@thyrsus.com> <20020215232517.FXLQ71.femail38.sdc1.sfba.home.com@there> <20020216013538.A23546@thyrsus.com>
In-Reply-To: <20020216013538.A23546@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020216181917.IQGD2774.femail34.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 February 2002 01:35 am, Eric S. Raymond wrote:
> Rob Landley <landley@trommello.org>:
> > On Friday 15 February 2002 05:04 pm, Eric S. Raymond wrote:
> > > Solutions that involve me doing an arbitrary and increasing amount of
> > > hand-hacking on every release are right out.
> >
> > Um, Eric?  Isn't that what being a maintainer basically means?
>
> The problem isn't that I'm not willing to work hard. I am.  It's that
> the level of handhacking has to be controlled below the threshold that
> makes it impossible.

That's still not the point.  You had great tools to do a job Linus -wasn't 
interested in having done-.  Unsuprisingly, Linus broke them.  Linus wasn't 
trying to make more work for you as 2.5 help file maintainer, he simply 
didn't care about side projects outside of 2.5.

It's still a question of defining the work you're expected to do.  Keeping 
2.4 and 2.5 in sync was a job you invented.  Initially it was easy, later it 
stopped being easy, and eventually it became a very hard problem indeed to 
the point where you had to stop doing it.  But the dependency between the 2.4 
and 2.5 help files was always completely artificial.  That you thought 
maintaining it was expected of you all along was an honest miscommunication, 
but that's water under the bridge now.

> > Back up a bit.  What would be the most minimal, stripped-down version of
> > CML2 you could write?  No eye candy, no complications, no
> > autoconfigurator, no tree view, no frozen symbols.  Just solving the core
> > problem of configuring 2.5 in a more flexible and less buggy way than
> > CML1, with the three interfaces (oldconfig, menuconfig, xconfig) we've
> > got now.
>
> The big problem isn't the code transition.  It's the rulebase transition.

Then why confuse the two?

Eric, "make menuconfig" is now green text on a black background.  The old one 
was black and yellow text on grey boxes with a blue border.  They look 
NOTHING alike.  The tab-through buttons at the bottom have gone away, the 
list now takes up the whole screen horizontally and vertically instead of 
being confined to a curses box, and the rest of the keys you use to do stuff 
are different.  (q does nothing in the old menuconfig, x gives you the option 
to abort, and cursor left and right changes which button is highlighted.  
Looking back, yes "?" pulls up help in CML1 but I didn't need to know that.  
I never used it, I always tabbed over to "help" and hit enter.  And I never 
used "x" to exit, I tabbed over to the "exit" button and used it until I got 
out of the top level menu.  It's all I ever needed to know to make it work...)

I personally don't care about the other configurators since the only one I 
ever use is menuconfig.  And after using CML2 for a while, I'll even grant 
that the old CML1 interface was clunky and the new one is probably an 
improvement.  But that's not the POINT.

It IS a different interface.  For no apparent reason except that you don't 
want to implement the old one.  Pull them up side by side in two different 
windows and try to do the same config in paralell.  The difference is pretty 
darn obvious.

Remember when I asked for a blank line at the top of menuconfig and you went 
"no, that's a waste of screen space" and refused to even consider it?  We 
went back and forth for ten minutes on this issue.  Look at how MUCH of the 
old menuconfig is wasted in drawing boxes and drop shadows: there's only ten 
lines of actual menu.  (Your code doesn't have any blank lines in it either.  
Mine does.  Does this sound like a coding style flame war to you?  Do you see 
how it's an issue on which a judgement call from you might not suddenly 
resolve all debate?)

Your aesthetic judgement of how the interface should look is not the point.  
Can you or can you not make one that looks and acts like the old one?  Yes or 
no?  (Yes it IS a trivial problem relative to the rest of the codebase, but 
it's one that hasn't been addressed.  And considering the UI is what people 
actually see, and it's different, you're giving a horrible first impression 
on the compatability front.)

I don't care if it's "better".  New Coke was "better".  It won all the blind 
taste tests hands down.  The fact CML2 asks the same questions and produces 
exactly the same .config files as the old rulebase is a blind taste test 
issue.  In real life, people aren't blindfolded, and the first thing they're 
seeing is a profoundly different user interface, for no readily apparent 
reason except that you don't like the old one.

Change the colors.  Put in the tabbable buttons.  Waste over half the 
screen space with boxes and drop shadows.  Suppress your gag reflex.  Prove 
it can be done.  Feel free to keep the old green menuconfig in the separate 
tarball with the autoconfigurator and call it "mconfig" or something, just 
try to make it so that when a developer runs "make menuconfig" they can't 
TELL whether they're running cml1 or cml2 (unless a difference they bump into 
is a REALLY obvious and justifiable no-brainer bugfix, like the stupid ).  
And the same for oldconfig and xconfig.  -THAT- is far more likely to get 
merged.

Yes this IS a showstopper issue.  Really.  Honest.  Stop giving objectors 
such an amazingly obvious target...

Rob
