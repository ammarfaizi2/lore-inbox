Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVCJAKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVCJAKJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVCJAGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:06:43 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:37092 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262401AbVCJAGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:06:08 -0500
Subject: Re: [PATCH 2/2] readahead: improve sequential read detection
From: Ram <linuxram@us.ibm.com>
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <422F8EBE.5080803@austin.ibm.com>
References: <42260F30.BE15B4DA@tv-sign.ru>
	 <1110412324.4816.89.camel@localhost>  <422F8EBE.5080803@austin.ibm.com>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1110413161.4816.96.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Mar 2005 16:06:02 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 16:03, Steven Pratt wrote:
> Ram wrote:
> 
> >On Wed, 2005-03-02 at 11:08, Oleg Nesterov wrote:
> >
> >
> >..snip...
> >
> >  
> >
> >>@@ -527,7 +527,7 @@ page_cache_readahead(struct address_spac
> >> 	}
> >> 
> >> out:
> >>-	return newsize;
> >>+	return ra->prev_page + 1;
> >>    
> >>
> >
> >This change introduces one key behavioural change in
> >page_cache_readahead(). Instead of returning the number-of-pages
> >successfully read, it now returns the next-page-index which is yet to be
> >read. Was this essential? 
> >
> >  
> >
> and unless filmap.c was changed accordingly this is broken..  need. to 
> look at this more.


Oleg has taken care of it in filemap.c whereever page_cache_readahead()
is called. So its not a bug as such. But I dont think it was necessary.
Doing so takes care of 1-line code reduction in filemap.c which is the
only plus point.

RP
 
> >  
> >
> 

