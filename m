Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSGQUYA>; Wed, 17 Jul 2002 16:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSGQUYA>; Wed, 17 Jul 2002 16:24:00 -0400
Received: from [195.137.34.203] ([195.137.34.203]:37808 "HELO sam.home.net")
	by vger.kernel.org with SMTP id <S316673AbSGQUX6>;
	Wed, 17 Jul 2002 16:23:58 -0400
Date: Wed, 17 Jul 2002 21:39:29 +0100
From: Sam Mason <mason@f2s.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: shreenivasa H V <shreenihv@usa.net>, linux-kernel@vger.kernel.org
Subject: Re: Gang Scheduling in linux
Message-ID: <20020717203929.GA9633@sam.home.net>
References: <20020717201417.GA9546@sam.home.net> <Pine.LNX.4.44.0207182206280.6752-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207182206280.6752-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 10:08:13PM +0200, Ingo Molnar wrote:
>On Wed, 17 Jul 2002, Sam Mason wrote:
>> It's mainly used for programs that needs lots of processing power
>> chucked at a specific problem, the problem is first broken down into
>> several small pieces and each part is sent off to a different processor.
>> When each piece has been processed, they are all recombined and the rest
>> of the calculation is continued.  The problem with this is that if any
>> one of the pieces is delayed, all the processors will be idle waiting
>> for the interrupted piece to be processed, before they can process the
>> next set of pieces.
>well, how does gang scheduling solve this problem? Even gang-scheduled
>tasks might be interrupted anytime on any CPU, by higher-priority tasks,
>thus causing a delay.

The important thing to remember is that this isn't a normal scheduling
method, it's used for VERY specialised software which is assumed to
have (almost) complete control of the machine.  Gang scheduled
processes would have the highest priority possible and would get
executed before any other processes.  This works because the software
knows what it's doing and assumes that the user only ran one bit of
gang scheduled software, if all of these are valid assumptions
everything should work nicely.

Thinking about it, if a process just sets itself to be the highest
priority and constrains it's self to appropriate processors then it
wouldn't surprise me if this was just what you want to do gang
scheduled.


  Sam
