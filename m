Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWFNFst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWFNFst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWFNFst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:48:49 -0400
Received: from cantor2.suse.de ([195.135.220.15]:20164 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964897AbWFNFst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:48:49 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC] Use ZVCs for numa statistics.
Date: Wed, 14 Jun 2006 07:48:32 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, pj@sgi.com, akpm@osdl.org
References: <Pine.LNX.4.64.0606131808180.1225@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606131808180.1225@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606140748.32032.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 June 2006 03:13, Christoph Lameter wrote:
> The numa statistics are really event counters. But they are per
> node and therefore we can use the per zone feature to easily
> implement what we need.
> 
> Remove the special statistics for numa and replace them with
> zoned vm counters.

Looks reasonable.
> 
> This has the side effect that global sums of these events now show up
> in /proc/vmstat.
> 
> I am not sure if this is a good approach. It certainly removes a
> lot of code and may place the counters more securely into the
> pcp cacheline but the implementation may be less efficient than the
> original code (not tested yet) since the ZVC require the disabling
> of interrupts. 

I still hope that can be avoided by using local_t properly.

-Andi
