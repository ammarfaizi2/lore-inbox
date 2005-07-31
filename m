Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263007AbVGaBO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbVGaBO3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 21:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVGaBO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 21:14:29 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:54499 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263007AbVGaBO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 21:14:27 -0400
Date: Sat, 30 Jul 2005 18:14:18 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] String conversions for memory policy
Message-Id: <20050730181418.65caed1f.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0507301042420.26355@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
	<20050729152049.4b172d78.pj@sgi.com>
	<Pine.LNX.4.62.0507291746000.8663@graphe.net>
	<20050729230026.1aa27e14.pj@sgi.com>
	<Pine.LNX.4.62.0507301042420.26355@graphe.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> Strangely mpol_new converts a node bit mask into a 
> list of zones.

It's not strange.  The numa interface calls mbind, set_mempolicy
and get_mempolicy, between kernel and user, don't deal in zones.
They deal in nodes.

I suspect you should do the same.  I doubt we want to expose
zones to user space here.

I will leave it to Andi to address your questions about memory
pressure on lower numbered nodes when using MPOL_BIND.  I suspect
that for some of the uses you consider here, such as binding to a
set of more than one node, that cpusets will provide capabilities
closer to what you have in mind.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
