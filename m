Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbVHJHnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbVHJHnn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 03:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbVHJHnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 03:43:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41899 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965034AbVHJHnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 03:43:42 -0400
Date: Wed, 10 Aug 2005 08:43:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: David Teigland <teigland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Message-ID: <20050810074338.GA3172@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pekka J Enberg <penberg@cs.helsinki.fi>,
	David Teigland <teigland@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-cluster@redhat.com
References: <20050802071828.GA11217@redhat.com> <84144f0205080223445375c907@mail.gmail.com> <20050808095747.GD13951@redhat.com> <courier.42F9AF75.00005806@courier.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.42F9AF75.00005806@courier.cs.helsinki.fi>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 10:40:37AM +0300, Pekka J Enberg wrote:
> Hi David, 
> 
> >+             return -EINVAL;
> >+     if (!access_ok(VERIFY_WRITE, buf, size))
> >+             return -EFAULT;
> >+
> >+     if (!(file->f_flags & O_LARGEFILE)) {
> >+             if (*offset >= 0x7FFFFFFFull)
> >+                     return -EFBIG;
> >+             if (*offset + size > 0x7FFFFFFFull)
> >+                     size = 0x7FFFFFFFull - *offset;
> 
> Please use a constant instead for 0x7FFFFFFFull. (Appears in various other 
> places as well.) 

In fact this very much looks like it's duplicating generic_write_checks().
Folks, please use common code.

