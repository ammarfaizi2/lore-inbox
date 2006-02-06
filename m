Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWBFStM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWBFStM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWBFStM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:49:12 -0500
Received: from ns2.suse.de ([195.135.220.15]:32176 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932154AbWBFStL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:49:11 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Date: Mon, 6 Feb 2006 19:48:24 +0100
User-Agent: KMail/1.8.2
Cc: Paul Jackson <pj@sgi.com>, mingo@elte.hu, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602061936.27322.ak@suse.de> <Pine.LNX.4.62.0602061039420.16829@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602061039420.16829@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602061948.25314.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 19:43, Christoph Lameter wrote:

> The impact of spreading cached object will depend on the application and 
> the NUMA latencies in the system.

Yes I can see it not working well when a dentry is put at the other 
end of a 256 node altix. That is why just spreading it to nearby
nodes might be an alternative.

On the other hand global interleaving actually worked for the page cache 
in production in SLES9, so it can't be that bad.

Also I'm sure you can construct some workload where it is a major loss.
For those one has NUMA policy to adjust it (although I don't know yet
how to apply separate numa policy to the d/i/file page cache - but if 
it should be a real problem it could be surely solved somehow)

The question is just if it's a common situation. My guess is that just
giving local memory priority but not throwing away all IO caches
when the local node fills up would be a generally useful default policy.

-Andi


>
