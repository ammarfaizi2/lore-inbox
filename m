Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbTAOLiw>; Wed, 15 Jan 2003 06:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266233AbTAOLiw>; Wed, 15 Jan 2003 06:38:52 -0500
Received: from [66.70.28.20] ([66.70.28.20]:11794 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266228AbTAOLiv>; Wed, 15 Jan 2003 06:38:51 -0500
Date: Wed, 15 Jan 2003 12:41:30 +0100
From: DervishD <raul@pleyades.net>
To: jw schultz <jw@pegasys.ws>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030115114130.GD66@DervishD>
References: <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com> <87iswrzdf1.fsf@ceramic.fifi.org> <20030114220401.GB241@DervishD> <20030114230418.GB4603@doc.pdx.osdl.net> <20030114231141.GC4603@doc.pdx.osdl.net> <20030115044644.GA18608@mark.mielke.cc> <20030115082527.GA22689@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030115082527.GA22689@pegasys.ws>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi JW :)

> > > right after your envp.  So, writing more info there would blow away
> > > your stack.
> > I can smell the next hack... memmove() the stack down to make room... :-)
> No need.  You can memcpy the environment.  See setenv(3),
> putenv(3) and related library routines.

    I'm afraid that the best solution, well, the one which involves
less code and less problems (no need to relocate the environment or
things like that) is to write to argv[0] a shorter string that the
existing one, and overwrite with nulls the rest of arguments, just in
case the stack layout is not what expected.

    Really, I'm thinking seriously about not rewritting argv[0] at
all. The problem is that may confuse the user when issuing 'ps' or
looking at /proc :((

    Raúl
