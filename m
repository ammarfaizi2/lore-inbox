Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVFNXyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVFNXyF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 19:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVFNXyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 19:54:05 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42217 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261426AbVFNXyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 19:54:02 -0400
Date: Wed, 15 Jun 2005 01:54:01 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, christoph <christoph@scalex86.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
Message-ID: <20050614235401.GW11898@wotan.suse.de>
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw> <20050608131839.GP23831@wotan.suse.de> <Pine.LNX.4.62.0506141551350.3676@ScMPusgw> <20050614230411.GU11898@wotan.suse.de> <Pine.LNX.4.62.0506141614570.23117@graphe.net> <20050614231911.GV11898@wotan.suse.de> <Pine.LNX.4.62.0506141621510.23266@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506141621510.23266@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 04:27:55PM -0700, Christoph Lameter wrote:
> On Wed, 15 Jun 2005, Andi Kleen wrote:
> 
> > > If these maps would start in the middle of a cacheline then additional 
> > > cacheline fetches may become necessary to scan an array etc.
> > 
> > But the CPUs do prefetching anyways for that. Do you have numbers
> > that this is actually worth it? 
> 
> Its not only for scanning an array. A struct may contains a lot of 
> related information like for example boot_cpu_data. Aligning 
> increases locality and the likelyhood that no additional cachelines have 
> to be fetched.

On the other hand it will increase the overall working set so there might
be more cache misses again. It's a trade off and the outcome is not clear.

Do you have numbers? 

When in doubt I would suggest the less wasteful in memory solution.

-Andi
