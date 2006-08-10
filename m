Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161336AbWHJPZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161336AbWHJPZo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161338AbWHJPZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:25:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12260 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161336AbWHJPZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:25:43 -0400
Date: Thu, 10 Aug 2006 08:25:17 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: mpm@selenic.com, npiggin@suse.de, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple Slab: A slab allocator with minimal meta information
In-Reply-To: <20060810151305.bc4602e0.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0608100823580.8368@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com>
 <20060810140153.e5932e76.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0608092211320.5806@schroedinger.engr.sgi.com>
 <20060810144451.13591e4b.kamezawa.hiroyu@jp.fujitsu.com>
 <20060810151305.bc4602e0.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006, KAMEZAWA Hiroyuki wrote:

> BTW, in recent Linux, many objects are freed by call_rcu(hoo, dealyed_free_foo).
> Objects are freed far after it was touched.
> I think catching this kind of freeing will not boost performance by cache-hit if
> reuse freed page (object). 

Yes that is a general problem with RCU freeing. One can use the 
SLAB_DESTROY_BY_RCU option to have RCU applied to the whole slab. In that 
case on can use the cache hot effect but has the additional problem in RCU 
of dealing with the issue that the object can be replaced at any time.

