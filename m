Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTKYRwU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTKYRwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:52:20 -0500
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:38127
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S262063AbTKYRwT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:52:19 -0500
Date: Tue, 25 Nov 2003 18:52:15 +0100
From: Antonio Vargas <wind@cocodriloo.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Jes Sorensen <jes@wildopensource.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com, steiner@sgi.com
Subject: Re: hash table sizes
Message-ID: <20031125175215.GB30083@wind.cocodriloo.com>
References: <16323.23221.835676.999857@gargle.gargle.HOWL> <20031125134222.GA8039@holomorphy.com> <yq0fzgcimf8.fsf@wildopensource.com> <200311251725.07573.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311251725.07573.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 05:25:07PM +0100, Thomas Schlichter wrote:
> Hi Jens,
> 
> I was wondering about you funny formula, too. (especially because it was 23 - 
> (PAGE_SHIFT -1) and not 24 - PAGE_SHIFT ;-) So I wanted to find out why this:
> 1:	mempages >>= (23 - (PAGE_SHIFT - 1));
> 2:	order = max(2, fls(mempages));
> 3:	order = min(12, order);
> 
> should be similar to this original code:
> 4:	mempages >>= (14 - PAGE_SHIFT);
> 5:	mempages *= sizeof(struct hlist_head);
> 6:	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
> 7:		;
> 
> Well, first I saw that lines 2 and 3 make order to be between 2 and 12. OK 
> this is new, and I like it ;-) Then I saw you tried to convert the ugly lines 
> 6 + 7 into a fls() call. Fine! (I like that, too) Line 6 + 7 can be converted 

is fls(x) sort-of log2(x) via some "find-highest-bit-set"?
I recall discussing something related with Jesse Barnes
last 5 november (search for "[DMESG] cpumask_t in action" in lkml).

[SNIP]

Greets, Antonio Vargas

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.
