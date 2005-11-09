Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbVKIAin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbVKIAin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbVKIAin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:38:43 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:46598 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S1030472AbVKIAin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:38:43 -0500
To: linas <linas@austin.ibm.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs
References: <20051107175541.GB19593@austin.ibm.com>
	<20051107182727.GD18861@kroah.com>
	<20051107185621.GD19593@austin.ibm.com>
	<20051107190245.GA19707@kroah.com>
	<20051107193600.GE19593@austin.ibm.com>
	<20051107200257.GA22524@kroah.com>
	<20051107204136.GG19593@austin.ibm.com>
	<1131412273.14381.142.camel@localhost.localdomain>
	<20051108232327.GA19593@austin.ibm.com>
	<B68D1F72-F433-4E94-B755-98808482809D@mac.com>
	<20051109003048.GK19593@austin.ibm.com>
From: Douglas McNaught <doug@mcnaught.org>
Date: Tue, 08 Nov 2005 19:37:20 -0500
In-Reply-To: <20051109003048.GK19593@austin.ibm.com> (linas@austin.ibm.com's message of "Tue, 8 Nov 2005 18:30:48 -0600")
Message-ID: <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linas <linas@austin.ibm.com> writes:

> On Tue, Nov 08, 2005 at 06:57:11PM -0500, Kyle Moffett was heard to remark:

>> That technique tends to cause more problems than it solves.  If I  
>> write the following code:
>> 
>> struct foo the_leftmost_foo = get_leftmost_foo();
>> do_some_stuff(the_leftmost_foo);
>> 
>> How do I know what it is going to do?  
>
> It depends on how do_some_stuff() was declared. If its declared as
>
>    do_some_stuff (struct foo &x)
>
> then it will be a pass by reference.

Yeah, but if you're trying to read that code, you have to go look up
the declaration to figure out whether it might affect 'foo' or not.
And if you get it wrong, you get silent data corruption.

I'd rather pass a pointer explicitly and crash with a segfault if
someone passes NULL--at least then it's pellucidly clear what went
wrong.

-Doug
