Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbWFIEin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWFIEin (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 00:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWFIEin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 00:38:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:9108 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965151AbWFIEim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 00:38:42 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 01/14] Per zone counter functionality
Date: Fri, 9 Jun 2006 06:38:28 +0200
User-Agent: KMail/1.9.3
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       hugh@veritas.com, nickpiggin@yahoo.com.au, linux-mm@kvack.org,
       marcelo.tosatti@cyclades.com
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com> <20060608230244.25121.76440.sendpatchset@schroedinger.engr.sgi.com> <20060608210045.62129826.akpm@osdl.org>
In-Reply-To: <20060608210045.62129826.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606090638.28167.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 June 2006 06:00, Andrew Morton wrote:
> On Thu, 8 Jun 2006 16:02:44 -0700 (PDT)
> Christoph Lameter <clameter@sgi.com> wrote:
> 
> > Per zone counter infrastructure
> > 
> 
> Is the use of 8-bit accumulators more efficient than using 32-bit ones? 
> Obviously it's better from a cache POV, given that we have a pretty large
> array of them.  But is there a downside on some architectures in not using
> the natural wordsize?   

Maybe on very old alphas which didn't have 8 bit stores. They need a RMW cycle.

Other than that i wouldn't expect any problems. RISCs will just do the usual
32bit add in registers, but do a 8bit load/store.

-Andi
