Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVGBQEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVGBQEv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 12:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVGBQEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 12:04:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44988 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261188AbVGBQEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 12:04:49 -0400
Date: Sat, 2 Jul 2005 17:04:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Michael Raymond <mraymond@sgi.com>
Subject: Re: [PATCH/RFC] Significantly reworked LTT core
Message-ID: <20050702160445.GA29262@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Karim Yaghmour <karim@opersys.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LTT-Dev <ltt-dev@shafik.org>, Tom Zanussi <zanussi@us.ibm.com>,
	Robert Wisniewski <bob@watson.ibm.com>,
	Mathieu Desnoyers <compudj@krystal.dyndns.org>,
	Michel Dagenais <michel.dagenais@polymtl.ca>,
	Michael Raymond <mraymond@sgi.com>
References: <42C60001.5050609@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C60001.5050609@opersys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This code is rather pointless.  The ltt_mux is doing all the real
work and it's not included.  And while we're at it the layering for
it is wrong aswell - the ltt_log_event API should be implemented by
the actual multiplexer with what's in ltt_log_event now minus the
irq disabling becoming a library function.

Exporting a pointer to the root dentry seems like a very wrong API
aswell, that's an implementation detail that should be hidden.

Besides that the code is not following Documentation/CodingStyle
at all, please read it.

Besides that I'd sugest scrapping the ltt name and ltt_ prefix - we know
we're on linux, adn we don't care whether it's a toolkit, but spelling trace_
out would actually be a lot more descriptive.  So what about trace_* symbol
names and trace.[ch] filenames?

