Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266711AbUBMGlO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 01:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266785AbUBMGlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 01:41:14 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:24721 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S266711AbUBMGlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 01:41:09 -0500
To: Michael Frank <mhf@linuxmail.org>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
References: <fa.fbh88ra.kn8094@ifi.uio.no>
From: Junio C Hamano <junkio@cox.net>
Date: Thu, 12 Feb 2004 22:41:07 -0800
In-Reply-To: <fa.fbh88ra.kn8094@ifi.uio.no> (Michael Frank's message of
 "Thu, 12 Feb 2004 22:08:33 GMT")
Message-ID: <7voes31ny4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "MF" == Michael Frank <mhf@linuxmail.org> writes:

MF> Comments and suggestions are appreciated.

Aside from the spelling & wording problems already commented on
by others (all of which I happen to agree),...

----------------------------------------------------------------
MF>  This is a short document describing the preferred coding style for the
MF>  linux kernel.  Coding style is very personal, and I won't _force_ my
MF>  views on anybody,...
MF>  ... Anyway, here goes:
 
The above introductory paragraph needs to be rewritten if you
plan to start using CodingStyle document to record the developer
community consensus.  The words "I" and "my" used here refer to
Linus and Linus only; IIRC, the coding style document originates
from an old posting by him to the l-k mailing list, and the
intent was to express view of Linus so that he does not have to
get involved in coding style flamewar on l-k list every time.

----------------------------------------------------------------

MF> +Note that perhaps the most terrible way to write code is to put multiple
MF> +statements onto a single line:
MF> +	if (condition) do_this;

I do not think this particular one agrees with community
consensus yet.  If "do_this" is short and sweet, I would not be
surprised if Linus said it is perfectly fine.

If the community indeed wants to ban a short single statement as
the body of an "if" statement, I would rather write the bad
example as this:

    if (condition) never_do_this;

----------------------------------------------------------------

MF> +Lagging spaces are deprecated.

You probably meant "trailing spaces".  In addition to that you
may also want to say something about <SP>s before <TAB>.

----------------------------------------------------------------

MF> +void fun(int a, int b, int c)
MF> +{
MF> +	if (condition)
MF> +		printk(KERN_WARNING "Warning this is a long printk with "
MF> +						"3 parameters a: %u b: %u "
MF> +						"c: %u \n", a, b, c);
MF> +        else
MF> +		next_statement;
MF> +}

This example violates indent by tab rule (notice spaces before "else").

----------------------------------------------------------------

MF> +Complex expressions are easier to understand and maintain when extra
MF> +parenthesis are used. Here is an extreme example
MF> +
MF> +x = (((a + (b * c)) & d) | e)  // would work also without any parenthesis

I believe this goes against community consensus not to overuse
parentheses.  Linus and others are also against "if ((a = b)) {
... }" (place extra parens around assignment expression used as
boolean), which is what GCC suggests (and which indeed is a
stupid suggestion).

----------------------------------------------------------------

MF> +Periods terminating kernel messages are deprecated
MF> +Usage of the apostrophe <'> in kernel messages is deprecated

I do not think encouraging bad spelling like above has reached
community consensus.  Personally I do not like those sloppy
grammar ("donts" and missing period at the end of the sentence).

Encouraging people to be consistent is a good thing, but I do
not want to encourage people to be consistently sloppy.

