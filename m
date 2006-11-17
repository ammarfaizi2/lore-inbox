Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755122AbWKQOET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbWKQOET (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755689AbWKQOET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:04:19 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17076 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1755665AbWKQOES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:04:18 -0500
Date: Fri, 17 Nov 2006 14:05:13 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Patrick.Le-Dot@bull.net (Patrick.Le-Dot)
Cc: balbir@in.ibm.com, ckrm-tech@lists.sourceforge.net, dev@openvz.org,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC][PATCH 5/8] RSS controller task migration
 support
Message-ID: <20061117140513.07da6fd9@localhost.localdomain>
In-Reply-To: <20061117132533.A5FCF1B6A2@openx4.frec.bull.fr>
References: <20061117132533.A5FCF1B6A2@openx4.frec.bull.fr>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 14:25:33 +0100 (CET)
> For a customer the main reason to use guarantee is to be sure that
> some pages of a job remain in memory when the system is low on free
> memory. This should be true even for a job in group/container A with

That actually doesn't appear a very useful definition.

There are two reasons for wanting memory guarantees

#1	To be sure a user can't toast the entire box but just their own
	compartment (eg web hosting)

#2	To ensure all apps continue to make progress

The simple approach doesn't seem to work for either. There is a threshold
above which #1 and #2 are the same thing, below that trying to keep a few
pages in memory will thrash not make progress and will harm overall
behaviour thus failing to solve #1 or #2. At that point you have to
decide whether what you have is a misconfiguration or whether the system
should be prepared to do temporary cycling overcommits so containers take
it in turn to make progress when overcommitted.

> If the limit is a "hard limit" then we have implemented reservation and
> this is too strict.

Thats fundamentally a judgement based on your particular workload and
constraints. If I am web hosting then I don't generally care if my end
users compartment blows up under excess load, I care that the other 200
customers using the box don't suffer and all phone me to complain.

Alan
