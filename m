Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbTI2Pev (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbTI2Peu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:34:50 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:6021 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S263582AbTI2Pes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:34:48 -0400
Date: Mon, 29 Sep 2003 16:34:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] document optimizing macro for translating PROT_ to VM_ bits
Message-ID: <20030929153437.GB21798@mail.jlokier.co.uk>
References: <20030929090629.GF29313@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929090629.GF29313@actcom.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> -/* Optimisation macro. */
> +/* Optimisation macro, used to be defined as: */
> +/* ((bit1 == bit2) ? (x & bit1) : (x & bit1) ? bit2 : 0) */ 
> +/* but this version is faster */ 
> +/* "check if bit1 is on in 'x'. If it is, return bit2" */ 
>  #define _calc_vm_trans(x,bit1,bit2) \
>    ((bit1) <= (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1)) \
>     : ((x) & (bit1)) / ((bit1) / (bit2)))

I agree with the intent of that comment, but the code in it is
unnecessarily complex.  See if you like this, and if you do feel free
to submit it as a patch:

/* Optimisation macro.  It is equivalent to:
      (x & bit1) ? bit2 : 0
   but this version is faster.  ("bit1" and "bit2" must be single bits). */

cheers,
-- Jamie
