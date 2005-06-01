Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVFAPV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVFAPV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVFAPT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:19:57 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:31526 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261390AbVFAPSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:18:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DrRQ9nSaJROjU2O06kIUXz/xGYSsYPf2enW0XzpZCRR+fej0JiZQVfOJXcTwUdVN0XDIl7Sw/6uJRieIYacschSAxv7SqmNcGofPrQ0KW4DJO5fSt0erpvRtjYwnpHiJyE6eBWEuHsthkdJNdy5DzD2V5oAtn5pxEUqugudYsB4=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] Introduce tty_unregister_ldisc()
Date: Wed, 1 Jun 2005 19:22:52 +0400
User-Agent: KMail/1.7.2
Cc: Paul Fulghum <paulkf@microgate.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200505312356.00853.adobriyan@gmail.com> <1117578491.4627.14.camel@at2.pipehead.org> <20050601054251.GA12275@infradead.org>
In-Reply-To: <20050601054251.GA12275@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506011922.52384.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 June 2005 09:42, Christoph Hellwig wrote:
> On Tue, May 31, 2005 at 05:28:11PM -0500, Paul Fulghum wrote:
> > An unmodified ldisc driver (externally maintained) will continue to call
> > tty_register_ldisc with NULL, but the new behavior will be to set the
> > ldisc pointer to NULL but have LDISC_FLAG_DEFINED set.
> > 
> > If you feel it is absolutely necessary to add this new function
> > for cosmetic reasons, then leave the old behavior in place
> > and make tty_unregister_ldisc a wrapper to tty_register_ldisc
> > that uses a NULL pointer.
> 
> Nah, we don't want to allow staying out of tree folks out of sync.  Adding
> a BUG_ON for ldisk beeing NULL is much more reasoable.

Why add BUG_ON?

	tty_register_ldisc(N_FOO, NULL);
			...
	tty_ldiscs[disc] = *new_ldisc;	<= NULL
