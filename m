Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWCEWVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWCEWVR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 17:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWCEWVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 17:21:17 -0500
Received: from zcars04e.nortel.com ([47.129.242.56]:33948 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP
	id S1751215AbWCEWVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 17:21:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17419.25684.389269.70457@lemming.engeast.baynetworks.com>
Date: Sun, 5 Mar 2006 17:21:08 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: bug-make@gnu.org, LKML <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net, Art Haas <ahaas@airmail.net>
Subject: Re: kbuild: Problem with latest GNU make rc
In-Reply-To: <20060304214026.GB1539@mars.ravnborg.org>
References: <17413.49617.923704.35763@lemming.engeast.baynetworks.com>
	<20060304214026.GB1539@mars.ravnborg.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
From: "Paul D. Smith" <psmith@gnu.org>
Reply-To: "Paul D. Smith" <psmith@gnu.org>
Organization: GNU's Not Unix!
X-OriginalArrivalTime: 05 Mar 2006 22:21:11.0819 (UTC) FILETIME=[1BE09DB0:01C640A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

%% Sam Ravnborg <sam@ravnborg.org> writes:

  sr> I foresee a lot of mails to lkml the next year or more with this
  sr> issue if kept. People do build older kernels and continue to do so
  sr> the next long time. Especially the embedded market seem keen to
  sr> stay at 2.4 (wonder why), and as such we will see many systems
  sr> that keep older kernel src but never make behaviour.

Well, this behavior doesn't exist in 2.4 kernels, since the kernel build
in 2.4 was very different.  Nevertheless there are plenty of 2.6 kernels
out there :-).

  sr> Suggestion:
  sr> We are now warned about an incompatibility in kbuild and we will
  sr> fix this asap. But that you postpone this particular behaviour
  sr> change until next make release. Maybe you add in this change as
  sr> the first thing after the stable relase so all bleeding edge make
  sr> users see it and can report issues.

I am willing to postpone this change.  However, I can't say how much of
a window this delay will give you: I can say that it's extremely
unlikely that it will be another 3 years before GNU make 3.82 comes out.

  sr> It is not acceptable that the kernel links each time we do a make.
  sr> We keep track of a version number, we do partly jobs as root etc.
  sr> So any updates on an otherwise build tree is a bug - and will be
  sr> reported and has to get fixed.

I've modified the kbuild system to collect .PHONY files into a variable,
PHONY, and then used that in the if_changed* macros.

Using this method I've determined that the new version of GNU make works
exactly like the old version under various tests (build from scratch,
rebuild without any changes, rebuild with simple changes, etc.)

I've submitted a patch to linux-kernel implementing this change, with
an appropriate Signed-off-by line.

-- 
-------------------------------------------------------------------------------
 Paul D. Smith <psmith@gnu.org>          Find some GNU make tips at:
 http://www.gnu.org                      http://make.paulandlesley.org
 "Please remain calm...I may be mad, but I am a professional." --Mad Scientist
