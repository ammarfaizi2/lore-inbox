Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272274AbTGYTiz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 15:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272282AbTGYTiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 15:38:55 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:4220 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S272274AbTGYTiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 15:38:54 -0400
Subject: Re: forkpty with streams
From: Andrew Barton <andrevv@users.sourceforge.net>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030725184635.GC6898@mea-ext.zmailer.org>
References: <1059089316.8596.14.camel@localhost>
	 <20030725152751.GA606@win.tue.nl> <1059130744.13184.11.camel@localhost>
	 <20030725184635.GC6898@mea-ext.zmailer.org>
Content-Type: text/plain
Organization: 
Message-Id: <1059137598.13910.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 25 Jul 2003 12:53:18 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-25 at 18:46, Matti Aarnio wrote:

> dup() helps you to have two fd:s,  fdopen() for both, one with "w",
> other "r".   Things should not need that dup() actually.
> Also fcntl() the fd's to be non-blocking.
> 
> Actually I am always nervous with stdio streams in places
> where I want to use non-blocking file handles, and carefull
> read()ing and write()ng along with select()s to handle
> non-stagnation of this type of communications.
> 

In my program, the standard input is filtered through a lex scanner
whose output file is the pty. So it does indeed need to be a stream.
Since I'm using flex, I won't have much control over the writing
process. When will it be necessary to read from the pty, to prevent a
deadlock? After each character the user types?

I might use SIGIO to read from the pty, but I have the 2.4 kernel that
doesn't support SIGIO on pipes and FIFOs. I assume ptys have the same
problem.

