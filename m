Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWCURhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWCURhY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWCURhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:37:23 -0500
Received: from zcars04f.nortel.com ([47.129.242.57]:30707 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP id S932341AbWCURhW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:37:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17440.14792.56779.898230@lemming.engeast.baynetworks.com>
Date: Tue, 21 Mar 2006 12:37:12 -0500
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 35/46] kbuild: change kbuild to not rely on incorrect GNU make behavior
In-Reply-To: <20060321172820.GQ20746@lug-owl.de>
References: <1142958057218-git-send-email-sam@ravnborg.org>
	<11429580571656-git-send-email-sam@ravnborg.org>
	<20060321172820.GQ20746@lug-owl.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
From: "Paul D. Smith" <psmith@gnu.org>
Reply-To: "Paul D. Smith" <psmith@gnu.org>
Organization: GNU's Not Unix!
X-OriginalArrivalTime: 21 Mar 2006 17:37:16.0300 (UTC) FILETIME=[1886B4C0:01C64D0E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

%% Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

  jg> On Tue, 2006-03-21 17:20:57 +0100, Sam Ravnborg <sam@ravnborg.org> wrote:

  >> -.PHONY: tar%pkg
  >> +PHONY += tar%pkg

  jg> This part is wrong. $(PHONY) isn't subject to pattern matching,

You're correct that it won't do what the author apparently expected,
however it WILL do exactly what the previous versions of kbuild used
to do.

I wrote:

> To: Sam Ravnborg <sam@ravnborg.org>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] change kbuild to not rely on incorrect GNU make behavior
> From: "Paul D. Smith" <psmith@gnu.org>
> Date: Sun, 5 Mar 2006 19:41:07 -0500
    ...
> Note that this won't do what you expect.  tar%pkg is a pattern rule,
> but .PHONY doesn't take patterns so you're declaring the actual file
> named literally 'tar%pkg' to be phony.

  jg> so all targets that match 'tar%pkg' must be listed
  jg> here. Fortunately, that's only three:

  jg> PHONY += tar-pkg targz-pkg tarbz2-pkg

This would be more correct, indeed; but note this change is orthogonal
to the purpose and requirements of the patch provided.

Of course, that doesn't mean they shouldn't be combined if that's
acceptable to the patch-masters! :-).


Cheers!

-- 
-------------------------------------------------------------------------------
 Paul D. Smith <psmith@gnu.org>          Find some GNU make tips at:
 http://www.gnu.org                      http://make.paulandlesley.org
 "Please remain calm...I may be mad, but I am a professional." --Mad Scientist
