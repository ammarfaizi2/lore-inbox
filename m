Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWHKAjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWHKAjH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 20:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWHKAjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 20:39:06 -0400
Received: from pat.uio.no ([129.240.10.4]:2451 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932382AbWHKAjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 20:39:04 -0400
Subject: Re: Urgent help needed on an NFS question, please help!!!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Neil Brown <neilb@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <4ae3c140608101528s69c50e2do554e0b908c2a1cf1@mail.gmail.com>
References: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com>
	 <17626.49136.384370.284757@cse.unsw.edu.au>
	 <4ae3c140608092254k62dce9at2e8cdcc9ae7a6d9f@mail.gmail.com>
	 <17626.52269.828274.831029@cse.unsw.edu.au>
	 <4ae3c140608100815p57c0378kfd316a482738ee83@mail.gmail.com>
	 <20060810161107.GC4379@parisc-linux.org>
	 <4ae3c140608100923j1ffb5bb5qa776bff79365874c@mail.gmail.com>
	 <1155230922.10547.61.camel@localhost>
	 <4ae3c140608101102j3ec28dccob94d407b9879aa86@mail.gmail.com>
	 <1155239982.5826.24.camel@localhost>
	 <4ae3c140608101528s69c50e2do554e0b908c2a1cf1@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 20:38:54 -0400
Message-Id: <1155256734.5826.94.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-0.869, required 12,
	autolearn=disabled, AWL -0.58, NIGERIAN_SUBJECT2 1.76,
	PLING_PLING 0.43, RCVD_IN_XBL 2.51, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 18:28 -0400, Xin Zhao wrote:
> Also, delegations are about caching. That's true. It improve NFS
> performance because a client with a lease does not need to worry about
> server change and can manipulate files using local cache.  But if
> speculative execution can achieve the same goal without incurring the
> cost of lease renewal and revoke, delegation becomes less useful.

What am I missing? AFAICS the main purpose of speculative execution
would appear to be to reduce the latency of syscall execution on
clients. That doesn't suffice to replace caching even by a long shot.

Delegations are all about _not_ sending commands to the server when you
don't need to. They make NFS scale to larger numbers of clients.

> So my question is essentially: if speculative execution is there, why
> do we still need delegation? Can delegation do anything better?

Speculative execution is where? I see one academic paper detailing a
couple of lab experiments, but no published code. Do you know of anyone
who has reproduced these results in real life environments?

I'm particularly curious to see how they resolved the requirement that
"...speculative state should never be visible to the user or any
external device.". The fact that they need to discuss having to roll
back operations like "mkdir", which create (very) user-visible state on
the server, is rather telling...

   Trond

