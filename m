Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbUAUMXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 07:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265934AbUAUMXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 07:23:41 -0500
Received: from ns.suse.de ([195.135.220.2]:19386 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262965AbUAUMXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 07:23:39 -0500
Date: Wed, 21 Jan 2004 13:23:37 +0100
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, vojtech@suse.cz
Subject: mouse configuration in 2.6.1
Message-Id: <20040121132337.7f8d3c79.ak@suse.de>
In-Reply-To: <20040121043608.6E4BB2C0CB@lists.samba.org>
References: <p73r7xwglgn.fsf@verdi.suse.de>
	<20040121043608.6E4BB2C0CB@lists.samba.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jan 2004 15:06:57 +1100
Rusty Russell <rusty@rustcorp.com.au> wrote:

> In message <p73r7xwglgn.fsf@verdi.suse.de> you write:
> > Rusty Russell <rusty@rustcorp.com.au> writes:
> > 
> > > Migrating to module_param() is the Right Thing here IMHO, which actually
> > > takes the damn address,
> > 
> > The main problem is that module_parm renames the boot time arguments and
> > makes them long and hard to remember.
> 
> Um, if the module name is neat, and the parameter name is neat, the
> combination of the two with a "."  between them will be nest.

Unfortunately we have lots of non neat module names and many previous boot
time arguments note their subsystem which adds even more redundancy.

And you're suggesting people to move to module_parm now in the stable
series leads to renaming of module parameters, which breaks previously
working configurations in often subtle ways. Maybe that's acceptable
in a unstable development kernel, but I don't think it is in 2.6.

How about adding a "setup option alias" table and require that everybody
changing an existing __setup to module_parm adds an alias there?

> > E.g. the new argument needed to make the mouse work on KVMs is
> > mindboogling, could be nearly a Windows registry entry.
> 
> I have no idea what you are talking about. 8(

psmouse_base.psmouse_noext

(brought to you by the department of redundancy department)

The "new" and "improved" version is apparently:

psmouse_base.psmouse_proto=bare

which is even worse.

And 2.6.0 -> 2.6.1 silently changing to that without any documentation anywhere,
silently breaking my mouse. And debugging it requires a lot of reboots
because we have regressed to Windows state where every mouse setting change
requires a reboot :-/

Sorry Rusty. You are probably the wrong target for the flame, but a combination
of probably well intended changes including module_parm brought a total usability 
disaster here.

-Andi
