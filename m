Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267407AbUHDUqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267407AbUHDUqW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 16:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267414AbUHDUqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 16:46:22 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:37112 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S267407AbUHDUqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 16:46:20 -0400
Date: Wed, 4 Aug 2004 22:42:16 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Robert White <rwhite@casabyte.com>
Cc: "'Bill Davidsen'" <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Interesting race condition...
Message-ID: <20040804204216.GA23314@k3.hellgate.ch>
Mail-Followup-To: Robert White <rwhite@casabyte.com>,
	'Bill Davidsen' <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <ce6e3r$i4n$1@gatekeeper.tmr.com> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAtvmiCqH5I06YSBiFSV8ZAgEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAtvmiCqH5I06YSBiFSV8ZAgEAAAAA@casabyte.com>
X-Operating-System: Linux 2.6.8-rc2-bk1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2004 13:03:50 -0700, Robert White wrote:
> Using procps version 2.0.7 the inclusion of "e" in the arguments is
> documented to return environment of the process.

Not the environment of somebody else's process, though. But that is
currently possible in mainline, the problem is not with ps but with
the kernel.

> The question of why the original poster was getting the environment when
> only using "ps ax" is interesting.  I'd look for PS_PERSONALITY (etc) in

Basically, if anyone reads /proc/pid/cmdline early enough, when
mm->arg_end is still 0, the kernel will blast out the process environment
through that interface. Thus, you get the data of /proc/pid/environ
without the access restrictions of that file. Not good if you happen
to pass sensitive information using environment variables.

Check out the patch I posted earlier in this thread.

Roger
