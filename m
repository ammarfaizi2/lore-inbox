Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbULJFXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbULJFXB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 00:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbULJFXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 00:23:01 -0500
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:48627 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261739AbULJFWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 00:22:55 -0500
Subject: Re: [audit] Upstream solution for auditing file system objects
From: John McCutchan <ttb@tentacle.dhs.org>
To: Robert Love <rml@novell.com>
Cc: Timothy Chavez <chavezt@gmail.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil
In-Reply-To: <1102650138.6052.228.camel@localhost>
References: <f2833c760412091602354b4c95@mail.gmail.com>
	 <20041209174610.K469@build.pdx.osdl.net>
	 <f2833c76041209185024cb1c4d@mail.gmail.com>
	 <1102650138.6052.228.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Dec 2004 00:22:45 -0500
Message-Id: <1102656165.18119.9.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.2.0, Antispam-Data: 2004.12.9.24
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-09 at 22:42 -0500, Robert Love wrote:
> On Fri, 2004-12-10 at 02:50 +0000, Timothy Chavez wrote:
> 
> I do not think it makes any sense for inotify to be the mechanism that
> implements auditing.  What you want is a general file event mechanism at
> the level and time that we currently do the inotify hooks.  I agree,
> that is good.  What you also want is to do is hack into inotify your
> auditing code.  I don't like that--I don't want inotify to grow into a
> generic file system tap.
> 
> What we both need, ultimately, is a generic file change notification
> system.  This way inotify, dnotify, your audit thing, and whatever else
> can hook into the filesystem as desired.

Yes, hopefully we can use some inotify bits when it comes time to do it.

> 
> Subverting the inotify project to add this functionality now will only
> hurt inotify.  We are not yet in the kernel and we need to streamline
> and simplify ourselves, not bloat and featurize.  Besides, indeed, we
> are not in the kernel yet--you can just as easily add the hooks
> yourself.
>
> So my position would be that I am all for moving the inotify hooks to
> generic file change hooks, but that needs to be done either once inotify
> is in the kernel proper or as a separate project.  Then inotify can be
> one consumer of the hooks and auditing another.

I am in complete agreement here. Inotify was not designed with any of
this in mind. Inotify was designed with the desktop in mind. I think a
more realistic approach would be to get inotify in, then refactor from
there. Creating a generic layer that contains some of the inotify code
plus whatever is needed to implement this audit stuff. Then the audit
system and inotify could use this layer for the nitty gritty.

-- 
John McCutchan <ttb@tentacle.dhs.org>
