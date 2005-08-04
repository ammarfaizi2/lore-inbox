Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbVHDQfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVHDQfO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVHDQd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:33:28 -0400
Received: from graphe.net ([209.204.138.32]:38116 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262598AbVHDQb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:31:56 -0400
Date: Thu, 4 Aug 2005 09:31:53 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] String conversions for memory policy
In-Reply-To: <20050804142942.GY8266@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0508040922110.6650@graphe.net>
References: <20050729230026.1aa27e14.pj@sgi.com> <Pine.LNX.4.62.0507301042420.26355@graphe.net>
 <20050730181418.65caed1f.pj@sgi.com> <Pine.LNX.4.62.0507301814540.31359@graphe.net>
 <20050730190126.6bec9186.pj@sgi.com> <Pine.LNX.4.62.0507301904420.31882@graphe.net>
 <20050730191228.15b71533.pj@sgi.com> <Pine.LNX.4.62.0508011147030.5541@graphe.net>
 <20050803084849.GB10895@wotan.suse.de> <Pine.LNX.4.62.0508040704590.3319@graphe.net>
 <20050804142942.GY8266@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005, Andi Kleen wrote:

> > You designed a NUMA API to control a process memory access patterns 
> > without the ability to view or modify the policies in use?
> 
> Processes internally can get the information if they want.
> Externally I didn't expose it intentionally to avoid locking problems

The fundamental purpose of a memory policy layer is to control memory 
allocation  on a system. If there no way to obtain that policy 
information and no way to control the policies then what is the purpose of 
the memory policies? Would it not be better to implement most what is 
currently in the kernel in user space since its restricted to a process 
anyways?

> > The locking issues for the policy information in the task_struct could be 
> > solved by having a thread execute a function that either sets or gets the 
> > memory policy. The vma policies already have a locking mechanism.
> 
> But why? It all only adds complexity. Keep it simple please.

Because its not possible to view and control memory policies otherwise.

> > This piece here only does conversion to a string representation so it 
> > should not be affected by locking issues. Processes need to do proper 
> > locking when using the conversion functions.
> 
> It's useless.

So your point of view is that there will be no control and monitoring of 
the memory usage and policies?
