Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbTAOIRB>; Wed, 15 Jan 2003 03:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265851AbTAOIRB>; Wed, 15 Jan 2003 03:17:01 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:7184 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S265863AbTAOIQk>; Wed, 15 Jan 2003 03:16:40 -0500
Date: Wed, 15 Jan 2003 00:25:27 -0800
From: jw schultz <jw@pegasys.ws>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030115082527.GA22689@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com> <87iswrzdf1.fsf@ceramic.fifi.org> <20030114220401.GB241@DervishD> <20030114230418.GB4603@doc.pdx.osdl.net> <20030114231141.GC4603@doc.pdx.osdl.net> <20030115044644.GA18608@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115044644.GA18608@mark.mielke.cc>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 11:46:44PM -0500, Mark Mielke wrote:
> On Tue, Jan 14, 2003 at 03:11:41PM -0800, Bob Miller wrote:
> > On Tue, Jan 14, 2003 at 03:04:18PM -0800, Bob Miller wrote:
> > > Or you can copy your all your args and env to a temporary place and
> > > then re-build your args and env with the new argv[0] in it's place.
> > > But you must be carefull that your new argv[0] length plus the 
> > > length of all remaining args, envp and pointers is not greater than
> > > the system defined size for this space.
> > In thinking about this more this will NOT work.  The user stack starts
> > right after your envp.  So, writing more info there would blow away
> > your stack.
> 
> I can smell the next hack... memmove() the stack down to make room... :-)

No need.  You can memcpy the environment.  See setenv(3),
putenv(3) and related library routines.

Once you've parsed your argv who cares if you overwrite it,
put a double NULL at the end, set argc = 1 and argv[1] =
NULL.  If argv[argc] - argv[0] + strlen(argv[argc] is
shorter than what you overwrite it with you won't even need
to relocate the environment block if you wish to preserve
that.  Just don't leave any loose ends to confuse /proc and
the ps utils.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
