Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTEDJQa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 05:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTEDJQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 05:16:28 -0400
Received: from holomorphy.com ([66.224.33.161]:15080 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263572AbTEDJQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 05:16:27 -0400
Date: Sun, 4 May 2003 02:28:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>, root@vanheusden.com,
       linux-kernel@vger.kernel.org, appel@vanheusden.com,
       folkert@vanheusden.com
Subject: Re: statistics for this mailinglist
Message-ID: <20030504092840.GM8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>, root@vanheusden.com,
	linux-kernel@vger.kernel.org, appel@vanheusden.com,
	folkert@vanheusden.com
References: <200305040201.h44211Lq017469@muur.intranet.vanheusden.com> <20030504074305.GJ8978@holomorphy.com> <20030504090639.GA30375@wohnheim.fh-wedel.de> <20030504091024.GL8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030504091024.GL8978@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 May 2003 00:43:05 -0700, William Lee Irwin III wrote:
>>> You still haven't fixed the bug in your script. Please post the
>>> script so it can be fixed.

On Sun, May 04, 2003 at 11:06:39AM +0200, J?rn Engel wrote:
>> Google is your friend:
>> http://www.vanheusden.com/mboxstats/
>> But I wonder if you really want to fix a text munching program written
>> in c++. What an interesting choice.

On Sun, May 04, 2003 at 02:10:24AM -0700, William Lee Irwin III wrote:
> I don't. I do, however, have a vested interest in getting the affected
> stats accurately reported again.

The "isemail" parameter to array::addstring() calls out to
get_email_address() to get the string, which breaks the string on any
' ' character (though, oddly, not other kinds of whitespace), while
hunting for a run of consecutive characters between '<' and '>'.

Otherwise, a non-blank-breaking convention that performs its work on
the raw string passed to it is used.

i.e. the error is a one-liner where the get_email_address() convention
is incorrectly specified by passing a 0 instead of a 1 as the second
argument of array::addstring() when the header matches "Organization:".


-- wli

--- main.cpp.orig	2003-05-04 02:22:49.000000000 -0700
+++ main.cpp	2003-05-04 02:23:02.000000000 -0700
@@ -459,7 +459,7 @@
 						}
 						else if (strncmp(msg[loop], "Organization: ", 14) == 0)
 						{
-							org.addstring(&msg[loop][14], 1);
+							org.addstring(&msg[loop][14], 0);
 						}
 						else if (strncmp(msg[loop], "User-Agent: ", 12) == 0)
 						{
