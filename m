Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVJCIIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVJCIIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 04:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVJCIIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 04:08:22 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:14018 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932181AbVJCIIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 04:08:22 -0400
From: Junio C Hamano <junkio@cox.net>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCHv4] Document from line in patch format
References: <mailman.1128301576.22577.linux-kernel2news@redhat.com>
	<20051002223050.11a287eb.zaitcev@redhat.com>
	<20051002225734.73dba354.pj@sgi.com>
cc: linux-kernel@vger.kernel.org
Date: Mon, 03 Oct 2005 01:08:20 -0700
In-Reply-To: <20051002225734.73dba354.pj@sgi.com> (Paul Jackson's message of
	"Sun, 2 Oct 2005 22:57:34 -0700")
Message-ID: <7vfyrjt43v.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +    Subject: [PATCH 001/123] [<area>:] <explanation>

What's funny is that the first pair is literal and the second
one is syntactic.  Perhaps you may want to do an EBNF ;-)?

SUBJECT ::= "Subject: [PATCH" NUMBER "/" NUMBER "]" [ AREA ":" ] EXPLANATION

Although the current explanation tells careful readers that
"From: " in the body is optional, by mentioning what happens if
it is not found, I think it is clearer if you said it upfront.

Maybe something along the lines of:

    The body of the message should be structured as follows.

    - an optional in-body "From: " line (plus an empty line for
      readability), if the author is different from the e-mail
      patch forwarder/sender; followed by

    - the explanation to be recorded as the commit log message;
      followed by

    - an empty line, and signed-off-by lines; followed by

    - mandatory three-dash '---' line; followed by

    - optional non-diff metainformation -- justification message
      to the maintainer, diffstat etc.

    - actual patch material.

I do not know if Linus wants to advertise this, but in addition
to the in-body "From: ", the e-mail patch application tool from
GIT also understands in-body "Date: ", if the patch forwarder
wants to preserve original authorship datestamp in the commit
the maintainer eventually makes out of your e-mail.  Without it,
the "Date: " of the forwarder's e-mail is used as the authorship
datestamp.

