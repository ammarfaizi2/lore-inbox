Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318816AbSICPW6>; Tue, 3 Sep 2002 11:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318818AbSICPW6>; Tue, 3 Sep 2002 11:22:58 -0400
Received: from moremagic.merlins.org ([204.80.101.251]:24995 "EHLO
	mail2.merlins.org") by vger.kernel.org with ESMTP
	id <S318816AbSICPWz>; Tue, 3 Sep 2002 11:22:55 -0400
Date: Tue, 3 Sep 2002 08:27:05 -0700
From: Marc MERLIN <marc_news@merlins.org>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       "Kevin P. Fleming" <kpfleming@cox.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: matti.aarnio@zmailer.org, linux-kernel@vger.kernel.org
Message-ID: <20020903152705.GW6579@merlins.org>
References: <20020903001509.E22256@sventech.com> <20020903050504.GK6579@merlins.org> <1031066044.21409.4.camel@irongate.swansea.linux.org.uk> <20020903001509.E22256@sventech.com> <20020903050504.GK6579@merlins.org> <3D74AABE.5050207@cox.net> <20020903001509.E22256@sventech.com> <20020903050504.GK6579@merlins.org> <20020903090516.B15921@bitwizard.nl>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1031066044.21409.4.camel@irongate.swansea.linux.org.uk> <3D74AABE.5050207@cox.net> <20020903090516.B15921@bitwizard.nl>
User-Agent: Mutt/1.3.28i
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-Operating-System: Proudly running Linux 2.4.14-lvm1.0.1rc4-ext3-0.9.15-servers11-up/Debian woody
X-Mailer: Some Outlooks can't quote properly without this header
Subject: Re: Stupid anti-spam testings...
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[BTW, I didn't specify, please CC me on answers, I'm not on lk anymore]

On Tue, Sep 03, 2002 at 09:05:16AM +0200, Rogier Wolff wrote:
> >    a) can obviously  be faked by spammers,  but I still think  it'd work for
> >       quite  a while:  spammers  who  are smart  enough  already fake  valid
> >       envelope and header froms, so they wouldn't have to add the header
> 
> This would quickly prevent detection of the problems that you
> intended to catch: Someone will blindly add the header, and before
> you know it, they fill in a bad "sender" somewhere....

That's what I just said, if they  bother to add the extra header, they could
just as well fake the envelope from  to point to some yahoo account, without
needing to set the said header.

On Tue, Sep 03, 2002 at 05:27:42AM -0700, Kevin P. Fleming wrote:
> This won't work; sender verify callouts (at least in Exim) are done at 
> MAIL FROM: time, I believe, in addition to after the headers have been 
> delivered.
 
In exim 3 yes, in exim 4, you can do what I explained
(sorry, I should have been specific about which version)

Details on the exim-users list if needed.
 
> I think caching is the way to go, no doubt. If noone else mentions that 
> they're working on it this week, I'll do so on Friday.

Caching is indeed the number 1 solution, a BL 

On Tue, Sep 03, 2002 at 04:14:04PM +0100, Alan Cox wrote:
> Matti, it seems a more productive approach would be to make sure that 
> vger deliberately trips the idiot spam filters into failing. That way
> people will rapidly leave the list or fix their systems.

1) exim callbacks are _not_ spam filters, they almost garantee that you only
   accept mail that you can reply to and/or bounce. If your envelope from
   points to  foohost.domain.tld with some non  routable IP, my only  way to
   tell you that I won't be able to  send you bounces is to refuse your mail
   at SMTP time.
   If you send mail from a non existant account (by mistake), same thing.
   SMTP callbacks just happen to also catch a lot of badly formatted spam,
   but that's not their main goal

2) There aren't many ways you can cause exim callbacks to fail without
   refusing real mail.
   (you can look at the callback rate in your logs and block the IPs, that's
   about it)

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking 
Home page: http://marc.merlins.org/   |   Finger marc_f@merlins.org for PGP key
