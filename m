Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVHDPA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVHDPA5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbVHDOMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:12:55 -0400
Received: from graphe.net ([209.204.138.32]:21652 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262557AbVHDOLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:11:40 -0400
Date: Thu, 4 Aug 2005 07:11:36 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] String conversions for memory policy
In-Reply-To: <20050803084849.GB10895@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0508040704590.3319@graphe.net>
References: <20050729152049.4b172d78.pj@sgi.com> <Pine.LNX.4.62.0507291746000.8663@graphe.net>
 <20050729230026.1aa27e14.pj@sgi.com> <Pine.LNX.4.62.0507301042420.26355@graphe.net>
 <20050730181418.65caed1f.pj@sgi.com> <Pine.LNX.4.62.0507301814540.31359@graphe.net>
 <20050730190126.6bec9186.pj@sgi.com> <Pine.LNX.4.62.0507301904420.31882@graphe.net>
 <20050730191228.15b71533.pj@sgi.com> <Pine.LNX.4.62.0508011147030.5541@graphe.net>
 <20050803084849.GB10895@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2005, Andi Kleen wrote:

> I really hate this whole /proc/<pid>/numa_policy thing. /proc/<pid>/maps
> was imho always a desaster (hard to parse, slow etc.). Also external
> access of NUMA policies has interesting locking issues. I intentionally
> didn't add something like that when I designed the original
> NUMA API. Please don't add it.

You designed a NUMA API to control a process memory access patterns 
without the ability to view or modify the policies in use?

The locking issues for the policy information in the task_struct could be 
solved by having a thread execute a function that either sets or gets the 
memory policy. The vma policies already have a locking mechanism.
 
This piece here only does conversion to a string representation so it 
should not be affected by locking issues. Processes need to do proper 
locking when using the conversion functions.

