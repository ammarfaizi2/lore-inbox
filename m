Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbVLGWUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbVLGWUM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbVLGWUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:20:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39048 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030402AbVLGWUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:20:09 -0500
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
In-Reply-To: <1133993636.30387.41.camel@localhost>
References: <20051114212341.724084000@sergelap>
	 <m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
	 <1133977623.24344.31.camel@localhost>
	 <1133978128.2869.51.camel@laptopd505.fenrus.org>
	 <1133978996.24344.42.camel@localhost>
	 <1133982048.2869.60.camel@laptopd505.fenrus.org>
	 <1133993636.30387.41.camel@localhost>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 23:20:02 +0100
Message-Id: <1133994002.2869.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 99% of the time, the kernel can deal with the same old tsk->pid that
> it's always dealt with.  Generally, the only times the kernel has to
> worry about the virtualized one is where (as Eric noted) it cross the
> user<->kernel boundary.

that's fair enough. I don't see the need for the macro abstractions
though; a current->pid and current->user_pid (or visible_pid or any
other good name) split makes sense. no need for macro abstractions at
all, just add ->user_pid in patch 1, in patch 2 assign it default to
->pid as well and patch 3 converts the places where ->pid is now given
to userspace ;)

again the DRM layer needs an audit, I'm not entirely sure if it doesn't
get pids from userspace. THe rest of the kernel mostly ought to cope
just fine.


