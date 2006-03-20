Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965524AbWCTPtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965524AbWCTPtN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965522AbWCTPtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:49:12 -0500
Received: from kanga.kvack.org ([66.96.29.28]:33496 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S966729AbWCTPUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:20:18 -0500
Date: Mon, 20 Mar 2006 10:14:33 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]micro optimization of kcalloc
Message-ID: <20060320151433.GE16108@kvack.org>
References: <Pine.LNX.4.58.0603201542250.17461@fachschaft.cup.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0603201542250.17461@fachschaft.cup.uni-muenchen.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 03:45:23PM +0100, Oliver Neukum wrote:
>  static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
>  {
> -	if (n != 0 && size > INT_MAX / n)
> +	if (unlikely(size != 0 && n > INT_MAX / size ))
>  		return NULL;
>  	return kzalloc(n * size, flags);
>  }

This function shouldn't be inlined.  We have no need to optimize the 
unlikely case like this.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
