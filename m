Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVEQB3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVEQB3I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 21:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVEQB3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 21:29:08 -0400
Received: from mail.shareable.org ([81.29.64.88]:33751 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261631AbVEQB3B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 21:29:01 -0400
Date: Tue, 17 May 2005 02:28:54 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linuxram@us.ibm.com, viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
Message-ID: <20050517012854.GC32226@mail.shareable.org>
References: <1116005355.6248.372.camel@localhost> <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu> <1116012287.6248.410.camel@localhost> <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu> <1116013840.6248.429.camel@localhost> <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu> <1116256279.4154.41.camel@localhost> <20050516111408.GA21145@mail.shareable.org> <1116301843.4154.88.camel@localhost> <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> +		if (ns1 < ns2) {
> +			down_write(&ns1->sem);
> +			down_write(&ns2->sem);
> +		} else {
> +			down_write(&ns2->sem);
> +			down_write(&ns1->sem);
> +		}

That's a bit smaller (source and compiled) as:

	if (ns2 < ns1)
		down_write(&ns2->sem);
	down_write(&ns1->sem);
	if (ns2 > ns1)
		down_write(&ns2->sem);

(And you'll notice that does the right thing if ns2==ns1 too, in case
that gives you any ideas.)

Otherwise, the patch looks convincing to me.

-- Jamie
