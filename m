Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267260AbTBQOkh>; Mon, 17 Feb 2003 09:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbTBQOjc>; Mon, 17 Feb 2003 09:39:32 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:7121
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267260AbTBQOjV>; Mon, 17 Feb 2003 09:39:21 -0500
Date: Mon, 17 Feb 2003 09:47:40 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH][2.5] Don't schedule tasks on offline cpus
In-Reply-To: <Pine.LNX.4.44.0302171513380.24394-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.50.0302170941040.18087-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0302171513380.24394-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, Ingo Molnar wrote:

> 
> On Mon, 17 Feb 2003, Zwane Mwaikambo wrote:
> 
> > We don't want to allow a cpu going offline to keep doing scheduler work
> > so let it exit early, otherwise we'd keep pulling in tasks every timer
> > tick.
> 
> i'd rather have all the hotplug CPU code to do this kind of stuff
> completely out of line. Start up a max-RT-priority housekeeping task and
> just clean the runqueue and deregister the CPU in one atomic pass - look
> at how the migration threads do similar stuff. No need to contaminate
> various codepaths with 'is this CPU online' checks.

Ok for this we'll have to move the task migration down till after the cpu 
has gone completely offline ie dead, then pull the tasks off the dead 
runqueue. I'm not aware of any ill effects of such a move.

	Zwane
-- 
function.linuxpower.ca
