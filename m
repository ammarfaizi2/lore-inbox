Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWFQN3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWFQN3X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 09:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWFQN3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 09:29:23 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:29588 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751577AbWFQN3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 09:29:22 -0400
Date: Sat, 17 Jun 2006 15:29:21 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Grzegorz Kulewski <kangur@polcom.net>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk
Subject: Re: [RFC][PATCH 00/20] Mount writer count and read-only bind mounts (v2)
Message-ID: <20060617132921.GA21326@MAIL.13thfloor.at>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Grzegorz Kulewski <kangur@polcom.net>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk
References: <20060616231213.D4C5D6AF@localhost.localdomain> <Pine.LNX.4.63.0606170125110.14464@alpha.polcom.net> <1150501318.7926.22.camel@localhost.localdomain> <Pine.LNX.4.63.0606170202020.14464@alpha.polcom.net> <20060617033531.GA25823@MAIL.13thfloor.at> <Pine.LNX.4.61.0606171135560.15799@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0606171135560.15799@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2006 at 11:36:35AM +0200, Jan Engelhardt wrote:
> >> >I assume you're talking about this kind of situation:
> >> >
> >> >mount --bind /local/writable/dir /chroot/untrusted/area/
> >> >mount --o remount,ro /chroot/untrusted/area/
> >> 
> >> Well, actually about some kind of VPS: openvz or something like that.
> >> But yes, this is the same kind of scenario.
> >
> >yes, Linux-VServer provides this kind of ro --bind mounts
> >without the race, as the the flags are passed on the actual
> >mount
> >
> >> >This has no r/w window in the chroot area:
> >> >
> >> >mount --bind /local/writable/dir /tmp/area/
> >> >mount --o remount,ro /tmp/area/
> >> >mount --bind /tmp/area/ /chroot/untrusted/area/
> >> >umount /tmp/area/
> >> 
> >> Well, it looks a little scarry and complicated at first. And probably
> >> requires you to know that semantic of --bind lets you do the last
> >> unmount. But if you are saying that this makes kernel smaller, faster
> >> and less buggy then you are probably very right.
> >
> >well, it makes the kernel more consistant in it's behaviour,
> >because especially for --rbind mounts, the logic what is
> >changed where and when is not as well defined as one would
> >wish ...
> >
> >btw, you could get the same result by simply doing:
> >
> >mount --bind /local/writable/dir /tmp/area/
> >mount --o remount,ro /tmp/area/
> >mount --move /tmp/area/ /chroot/untrusted/area/
> >
> 
> Just a nitpick, you all use "--o" ... :)
> mount: option `--o' is ambiguous

sorry, copy paste error on my side :)
(probably for Dave too ...)

best,
Herbert

> Jan Engelhardt
> -- 
