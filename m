Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVHNWK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVHNWK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 18:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVHNWK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 18:10:59 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:41362 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S932323AbVHNWK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 18:10:58 -0400
Message-ID: <42FFC16A.3000500@v.loewis.de>
Date: Mon, 15 Aug 2005 00:10:50 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Stephen Pollei <stephen.pollei@gmail.com>,
       Jason L Tibbitts III <tibbs@math.uh.edu>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <42FDE286.40707@v.loewis.de>	 <feed8cdd0508130935622387db@mail.gmail.com>	 <1123958572.11295.7.camel@mindpipe> <ufazmrl9h3u.fsf@epithumia.math.uh.edu>	 <feed8cdd050814125845fe4e2e@mail.gmail.com>	 <1124049592.4918.2.camel@mindpipe>	 <feed8cdd0508141313297beea7@mail.gmail.com> <1124050979.4918.3.camel@mindpipe>
In-Reply-To: <1124050979.4918.3.camel@mindpipe>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> For strings, of course.  But there's no need for UTF-8 operators.

Indeed - this is the main rationale for the patch, of course. People
want to write non-ASCII in script primarily in string literals,
and (perhaps even more often) in comments. Now, for comments, it
wouldn't really matter that the interpreter knows what the encoding
is - but the editor would have to know, and the UTF-8 signature
primarily helps the editor (*).

Then we are back to the rationale for this patch: if you need the
UTF-8 signature to reliably identify the script as being UTF-8
encoded, you then currently cannot easily run it as a script through
binfmt_script, as that code requires a script to start with #!.

Regards,
Martin

(*) As I said before: atleast for Python, the UTF-8 signature also
has syntactic meaning. It is allowed at the beginning of a file
as an addition to the language syntax, and it tells the interpreter
that Unicode literals (usually represented internally as UCS-2)
are represented as UTF-8 in the source code.
