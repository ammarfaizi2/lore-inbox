Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWBFTTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWBFTTi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWBFTTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:19:38 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:37096 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932293AbWBFTTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:19:37 -0500
Date: Mon, 6 Feb 2006 11:19:12 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, mingo@elte.hu, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
In-Reply-To: <200602061948.25314.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602061117440.17183@schroedinger.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <200602061936.27322.ak@suse.de> <Pine.LNX.4.62.0602061039420.16829@schroedinger.engr.sgi.com>
 <200602061948.25314.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Andi Kleen wrote:
> On the other hand global interleaving actually worked for the page cache 
> in production in SLES9, so it can't be that bad.

I would see it as an emergency measure given the bad control over locality 
in SLES9 and the lack of an efficient zone reclaim.

> The question is just if it's a common situation. My guess is that just
> giving local memory priority but not throwing away all IO caches
> when the local node fills up would be a generally useful default policy.

We do not throw away "all IO caches". We take a portion of the inactive 
list and scan for freeable pages.

