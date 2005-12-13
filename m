Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVLMKzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVLMKzo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 05:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVLMKzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 05:55:44 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:24514 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964807AbVLMKzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 05:55:43 -0500
Date: Tue, 13 Dec 2005 11:54:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213105459.GA9879@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Howells <dhowells@redhat.com> wrote:

>      	init_MUTEX_LOCKED()
> 	DECLARE_MUTEX_LOCKED()

please kill these two in the simple mutex implementation - they are a 
sign of mutexes used as completions.

>  (7) Provides a debugging config option CONFIG_DEBUG_MUTEX_OWNER by which the
>      mutex owner can be tracked and by which over-upping can be detected.

another simplification: also enforce that only the owner can unlock the 
mutex. This is what we are doing in the -rt patch. (This rule also 
ensures that such mutexes can be used for priority inheritance.)

	Ingo
