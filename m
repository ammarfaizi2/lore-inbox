Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161225AbWJXUmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbWJXUmn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 16:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161226AbWJXUmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 16:42:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59558 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161225AbWJXUmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 16:42:42 -0400
Date: Tue, 24 Oct 2006 21:42:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
Message-ID: <20061024204239.GA15689@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	LKML <linux-kernel@vger.kernel.org>
References: <1161576857.3466.9.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161576857.3466.9.camel@nigel.suspend2.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 02:14:17PM +1000, Nigel Cunningham wrote:
> Switch from bitmaps to using extents to record what swap is allocated;
> they make more efficient use of memory, particularly where the allocated
> storage is small and the swap space is large.
>     
> This is also part of the ground work for implementing support for
> supporting multiple swap devices.

In addition to the very useful comments from Rafael there's some observations
of my own:

 - there's an awful lot of opencoded list manipulation, any chance you
   could use list.h instead?
 - what unit are the extent values in?  The usage of unsigned long rings
   warning bells for me, shouldn't this be something like pgoff_t or
   sector_t depending on what you describe with it?
