Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131349AbRC0PGN>; Tue, 27 Mar 2001 10:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131351AbRC0PGD>; Tue, 27 Mar 2001 10:06:03 -0500
Received: from blacksun.leftmind.net ([204.225.88.62]:41999 "HELO
	blacksun.leftmind.net") by vger.kernel.org with SMTP
	id <S131349AbRC0PFt>; Tue, 27 Mar 2001 10:05:49 -0500
Date: Tue, 27 Mar 2001 10:05:08 -0500
From: Anthony de Boer - USEnet <abuse@leftmind.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
Message-ID: <20010327100508.A19460@leftmind.net>
In-Reply-To: <20010322124727.A5115@win.tue.nl> <20010322142831.A929@owns.warpcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010322142831.A929@owns.warpcore.org>; from stephenc@theiqgroup.com on Thu, Mar 22, 2001 at 02:28:31PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Clouse wrote:
> We run Oracle on a development box here, and it's always the first to get the
> axe (non-root process using 70-80 MB VM).  ...
> It would be nice to give immunity to certain uids, ...

It would seem to me that the new capabilities stuff _could_ be the answer.

Basically, all "am I root?" checks in the kernel should be becoming cap
flags, the OOM killer already avoids killing root processes, it's already
a tenet that yes you can hose your system doing insane things as root but
that nonroot users should NOT be able to hose a system, so being able to
eg. grant this capability to Oracle or ungrant it from sendmail could let
a sysadmin tell the kernel what must be preserved regardless of its UID.

As a baseline I'd want to see all user processes die before any UID 0
stuff, but being able to retune this would be extremely good.

-- 
Anthony de Boer -- as seen at http://www.leftmind.net/~adb/ -- BOFH, eh?
 / "Just when you think you've got a handle on herding cats, \
 \ along comes a three-legged cat on amphetamines."  -- Skud /
