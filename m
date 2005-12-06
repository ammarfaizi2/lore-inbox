Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbVLFXIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbVLFXIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 18:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbVLFXIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 18:08:46 -0500
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:35184 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932606AbVLFXIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 18:08:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=dg33vwOdTFpKJY93SvYuarPeIeDqWhvgF+g6xSnuAIYgT9SpFSNXtTOta+A/rIm7C4F/bfsKZwW6YGqtoD9e+zl7uwvMW+9rWZ5AjwI3bzEThwICDV197jg+RZSYjb8EgJ4xEXz2bfTkGD5wk5cN2Pdr7RyuBx8KI1Ajopn3HSE=  ;
Message-ID: <439619F9.4030905@yahoo.com.au>
Date: Wed, 07 Dec 2005 10:08:41 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/3] Framework for accurate node based statistics
References: <20051206182843.19188.82045.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051206182843.19188.82045.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> [RFC] Framework for accurate node based statistics
> 
> Currently we have various vm counters that are split per cpu. This arrangement
> does not allow access to per node statistics that are important to optimize
> VM behavior for NUMA architectures. All one can say from the per_cpu
> differential variables is how much a certain variable was changed by this cpu
> without being able to deduce how many pages in each node are of a certain type.
> 
> This patch introduces a generic framework to allow accurate per node vm
> statistics through a large per node and per cpu array. The numbers are
> consolidated when the slab drainer runs (every 3 seconds or so) into global
> and per node counters. VM functions can then check these statistics by
> simply accessing the node specific or global counter.
> 
> A significant problem with this approach is that the statistics are only
> accumulated every 3 seconds or so. I have tried various other approaches
> but they typically end up with having to add atomic variables to critical
> VM paths. I'd be glad if someone else had a bright idea on how to improve
> the situation.
> 

Why not have per-node * per-cpu counters?

Or even use the current per-zone * per-cpu counters, and work out your
node details from there?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
