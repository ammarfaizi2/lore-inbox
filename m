Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTFAELc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 00:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTFAELc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 00:11:32 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:36347 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261182AbTFAELa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 00:11:30 -0400
Subject: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
From: Tom Sightler <ttsig@tuxyturvy.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054441433.1722.33.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2003 00:23:53 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.3, required 10,
	AWL, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking for help in identifying what might be causing some very
strange issues I have recently noticed with my Dell laptop running
recent 2.5.69/70 kernels.

The symptoms are a little strange, at least to me, but I'll try to
describe them as short and completely as possible.  Basically, I first
noticed an issue when I was testing a demo version of Crossover Plugin
with some web sites using heavy Shockwave content.  This first noticable
symptom was that, any sound event that corresponded with screen updates
would pop and crackle.  At first I thought it was a problem with my
sound card, but as I being to look at the issue I noticed that the
problem seemed to be caused by the fact that the pluginserver (wine) was
using 100% of the CPU.  I simply reniced this process to -10 and
everything started working fine.  Upon looking a little further it
seemed that the kernel was dynamically boosting the priority of the
process much higher than it probably should be, in the end, not leaving
enough CPU for playing the sounds without skipping.

After doing some other research I found several other programs that
cause what appear to be the same basic symptoms.  For example, viewing a
PDF file from withing Mozilla using the Acrobat plugin causes my X
server (don't know what X) to get a boost and suddenly it takes 100% of
the CPU.

VMware 4 also seems to cause a similar problem, where lots of processes
get boosts leaving very little left for simple things like the
occasional sound.

Would these issues be explained by the scheduler starvation issues that
others have seen?  I thought those had been mostly fixed.

I'm not 100% sure, but I don't remember seeing these problems with
2.5.68-mm2, but I have since tried 2.5.69-mm4 and today 2.5.70-mm3 as
well as 2.5.70 and they both have this same symptom.

Booting the system into 2.4.20 makes all of these symptoms go away.

It doesn't seem reasonable that I should have to play with nice values
and priorities to get things running right.  Is there anything I should
look at tuning?  Other things I may be doing wrong?

I've tried with preemption both enabled and disabled with no effect.

Any help or suggestions would be greatly appreciated.  Overall this
system still works well, and none of these issues keep the system from
being usable.  Overall performance on my laptop is much smoother and
snappier than anything I have seen with 2.4.x, but having to play with
nice levels to get these programs cooperating seems wrong as they're
pretty basic functionality.

Later,
Tom


