Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTJ3EIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 23:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTJ3EIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 23:08:45 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:64643 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262118AbTJ3EIm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 23:08:42 -0500
Date: Wed, 29 Oct 2003 20:08:22 -0800
From: Larry McVoy <lm@bitmover.com>
To: Scott Robert Ladd <coyote@coyotegulch.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Erik Andersen <andersen@codepoet.org>,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
Message-ID: <20031030040822.GA30071@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Scott Robert Ladd <coyote@coyotegulch.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Erik Andersen <andersen@codepoet.org>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <20031030015212.GD8689@thunk.org> <3FA08C42.6050107@coyotegulch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA08C42.6050107@coyotegulch.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> SQL is a bloated pig; an effective 
> file system needs to be both useful and efficient, leading me to think 
> that we should consider a more succinct query mechanism for any 
> metadata-based file system.

It's certainly possible to make a mostly/partially SQL compliant query
engine which is lean.  We did so for the commercial version of BK, i.e.,
this does exactly what you think it does:

select ID,STATUS,SEVERITY,PRIORITY,SUMMARY
from bugs
where	(SEVERITY == 1 or SEVERITY == 2 or SEVERITY == 3) and 
	(PRIORITY == 1 or PRIORITY == 2 or PRIORITY == 3) and 
	(STATUS == "new" or STATUS == "open" or STATUS == "assigned")
order by
	ID

The code which implements that:

wc query.c select.y
    284     830    5679 query.c
    650    2033   13775 select.y
    934    2863   19454 total

SQL compatibility isn't the problem, full (and bloated) SQL implementations are.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
