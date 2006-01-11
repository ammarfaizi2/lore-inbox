Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbWAKNui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWAKNui (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbWAKNui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:50:38 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:62094 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1751611AbWAKNui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:50:38 -0500
To: John Hesterberg <jh@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Matt Helsley <matthltc@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       LKML <linux-kernel@vger.kernel.org>, elsa-devel@lists.sourceforge.net,
       lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors
References: <43BC1C43.9020101@engr.sgi.com> <1136414431.22868.115.camel@stark>
	<20060104151730.77df5bf6.akpm@osdl.org>
	<1136486566.22868.127.camel@stark> <1136488842.22868.142.camel@stark>
	<20060105151016.732612fd.akpm@osdl.org>
	<1136505973.22868.192.camel@stark> <yq08xttybrx.fsf@jaguar.mkp.net>
	<43BE9E91.9060302@watson.ibm.com> <yq0wth72gr6.fsf@jaguar.mkp.net>
	<20060111125642.GC12921@sgi.com>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 11 Jan 2006 08:50:30 -0500
In-Reply-To: <20060111125642.GC12921@sgi.com>
Message-ID: <yq0oe2i3mc9.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "John" == John Hesterberg <jh@sgi.com> writes:

John> I believe the accounting our customers require needs to be
John> turned on system-wide.  In fact, I recall getting problems
John> reports if there are some processes not 'accounted' for.  If you
John> do it on a task basis, and accounting gets turned on, you'd have
John> to have a fool-proof way of tracking down all the tasks in a
John> system and turn on their accounting.

Thats what I was scared someone would say ;-( The problem I am seeing
is that SGI wants certain things in the accounting block, I am sure
IBM has other things they wish to count and someone else will want to
count something else again. With all those numbers we may end up with
a relatively large block for accounting numbers in struct task_struct.

However it makes it a lot harder to use the task_notifiers for it ;-(

John> I would expect sites either want accounting on all the time for
John> everything, or not at all.

Right now a lot of the accounting is done by calling into a function
which checks a flag for whether accounting is enabled and returns if
it is not. That could easily be extended to check for the global
accounting flag + check that the task's accounting data structure has
been allocated. Then in certain places, like fork() and schedule(),
allocate it if it's not in place already and accounting has been
switched on. That way we could reduce the overhead to a single pointer
in struct task_struct and the accounting structure could (in theory)
grow indefinately large. Or is this too much of a hack?

Comments?

Cheers,
Jes
