Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWCTPfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWCTPfH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWCTPeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:34:46 -0500
Received: from mail1.kontent.de ([81.88.34.36]:23262 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S964958AbWCTPdd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:33:33 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [PATCH]micro optimization of kcalloc
Date: Mon, 20 Mar 2006 16:33:29 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0603201542250.17461@fachschaft.cup.uni-muenchen.de> <20060320151433.GE16108@kvack.org>
In-Reply-To: <20060320151433.GE16108@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603201633.29532.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 20. März 2006 16:14 schrieb Benjamin LaHaise:
> On Mon, Mar 20, 2006 at 03:45:23PM +0100, Oliver Neukum wrote:
> >  static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
> >  {
> > -	if (n != 0 && size > INT_MAX / n)
> > +	if (unlikely(size != 0 && n > INT_MAX / size ))
> >  		return NULL;
> >  	return kzalloc(n * size, flags);
> >  }
> 
> This function shouldn't be inlined.  We have no need to optimize the 
> unlikely case like this.

The likely case is passing constants. Without inlining precisely the
likely case cannot be optimised.

	Regards
		Oliver
