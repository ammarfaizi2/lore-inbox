Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbTEZXCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 19:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTEZXCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 19:02:39 -0400
Received: from aneto.able.es ([212.97.163.22]:14276 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262289AbTEZXCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 19:02:38 -0400
Date: Tue, 27 May 2003 01:15:48 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: AA's 00_backout_gcc_3-0-patch-1
Message-ID: <20030526231548.GA14858@werewolf.able.es>
References: <Pine.LNX.4.55L.0305261929460.30175@freak.distro.conectiva> <20030526225445.GV3767@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030526225445.GV3767@dualathlon.random>; from andrea@suse.de on Tue, May 27, 2003 at 00:54:45 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.27, Andrea Arcangeli wrote:
> On Mon, May 26, 2003 at 07:30:44PM -0300, Marcelo Tosatti wrote:
[...]
> 
> Overall in kernel we disagreed to follow the MUST requrested by the gcc
> developers, we often want to do comparisons of variables out of locks to
> know if we need to take the lock and work on a garbage collection or
> stuff like that and we for sure don't want to mark those variables
> volatile since they must be cached and not spilled all the time, under
> the locks. Linus as well was against using volatile for every piece of
> memory that can change under gcc. The decision is been basically to
> outsmart gcc in choosing if gcc has rights to generate kernel crashing
> code or not. This makes kernel developement even more difficult since
> you've to imagine whatever smart thing gcc can do with your not
> serialized code to know if you're forced to mark the stuff volatile, but
> it'll generate the very best performance.
> 

So you are telling that you are allowed to do something like:

int* a = 0x320;

for (i=1000 samples)
	v[i] = *a;

in kernel code and you trust gcc to not optimize the loop away ??
What is volatile is volatile...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc3-jam1 (gcc 3.2.3 (Mandrake Linux 9.2 3.2.3-1mdk))
