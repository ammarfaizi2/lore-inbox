Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161224AbWF0RVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161224AbWF0RVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbWF0RVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:21:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31663 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161215AbWF0RVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:21:50 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Savochkin <saw@swsoft.com>
Cc: dlezcano@fr.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com,
       Andrew Morton <akpm@osdl.org>, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk
Subject: [RFC] Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru>
Date: Tue, 27 Jun 2006 11:20:40 -0600
In-Reply-To: <20060626134945.A28942@castle.nmd.msu.ru> (Andrey Savochkin's
	message of "Mon, 26 Jun 2006 13:49:45 +0400")
Message-ID: <m14py6ldlj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thinking about this I am going to suggest a slightly different direction
for get a patchset we can merge.

First we concentrate on the fundamentals.
- How we mark a device as belonging to a specific network namespace.
- How we mark a socket as belonging to a specific network namespace.

As part of the fundamentals we add a patch to the generic socket code
that by default will disable it for protocol families that do not indicate
support for handling network namespaces, on a non-default network namespace.

I think that gives us a path that will allow us to convert the network stack
one protocol family at a time instead of in one big lump.

Stubbing off the sysfs and sysctl interfaces in the first round for the
non-default namespaces as you have done should be good enough.

The reason for the suggestion is that most of the work for the protocol
stacks ipv4 ipv6 af_packet af_unix is largely noise, and simple
replacement without real design work happening.  Mostly it is just
tweaking the code to remove global variables, and doing a couple
lookups.

Eric
