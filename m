Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbTAORCK>; Wed, 15 Jan 2003 12:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266810AbTAORCG>; Wed, 15 Jan 2003 12:02:06 -0500
Received: from [66.70.28.20] ([66.70.28.20]:50437 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266837AbTAORCD>; Wed, 15 Jan 2003 12:02:03 -0500
Date: Wed, 15 Jan 2003 18:10:09 +0100
From: DervishD <raul@pleyades.net>
To: Jakob Oestergaard <jakob@unthought.net>, jw schultz <jw@pegasys.ws>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030115171009.GF86@DervishD>
References: <87iswrzdf1.fsf@ceramic.fifi.org> <20030114220401.GB241@DervishD> <20030114230418.GB4603@doc.pdx.osdl.net> <20030114231141.GC4603@doc.pdx.osdl.net> <20030115044644.GA18608@mark.mielke.cc> <20030115082527.GA22689@pegasys.ws> <20030115114130.GD66@DervishD> <20030115131617.GA8621@unthought.net> <20030115162219.GB86@DervishD> <20030115164731.GB8621@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030115164731.GB8621@unthought.net>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jakob :)

> >     If execv doesn't do any magic with the supplied argv array, then
> > this should work.
> Yep, that's what I though.  Can anyone shoot this down?  ;)

    Not me ;)) The only problem would arise if the argv[0] passed to
exec is 511 bytes long but its strlen is low, because exec can choose
to copy the array to a new location (in fact, I think it does it...).

    If you provide a filled argv[0], and soon after the exec you
change it to a proper value, there is only a brief chunk of time
where argv[0] will have long and strange contents. It doesn't matter,
because you can use spaces and anyway this is not important.

[Code snippet... snipped] 
> Can anyone point out a problem in the above? I'd be happy to see it shot
> down, mainly because it's ugly - and I hate programs that mess with
> argv[0].

    I like your code ;))) I don't think it's ugly, on the contrary, I
find it quite elegant ;)) And I hate programs that mess with argv[0],
too. In fact, I'm against that, but I need it... You deserve an
explanation: it's a virtual console only init clone, and has a
builtin getty and login, and a builtin syslogd+klogd, too, all in
less than 17k... Well, due to the 'builtin nature' of this program,
we don't want ps show '/sbin/init' or just 'init' for the klogd
process, for example, or in the login process. We want 'ps' to show
'login' for the login process or 'klogd' for the klog builtin
emulator. That's all.

    By now I just assumed that at least I had four spare characters,
but this is not true anymore when testing, since I provided init=/i
to lilo, for example. And anybody can use that parameter and screw my
init totally, just for the sake of the proc string issue :((

    Your exec solution seems to be the easiest and cleanest one, and
should work, IMHO... I'm going to test right now ;))

    Thanks for your help.

    Raúl
