Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266442AbUG0Pjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266442AbUG0Pjb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 11:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266436AbUG0Pja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 11:39:30 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:18090 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266442AbUG0Pfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 11:35:52 -0400
Subject: Re: [PATCH] fix readahead breakage for sequential after random
	reads
From: Ram Pai <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1BpMZQ-00016B-00@dorka.pomaz.szeredi.hu>
References: <E1BmKAd-0001hz-00@dorka.pomaz.szeredi.hu>
	 <20040726162950.7f4a3cf4.akpm@osdl.org>
	 <1090886218.8416.3.camel@dyn319181.beaverton.ibm.com>
	 <20040726170843.3fe5615c.akpm@osdl.org>
	 <1090901926.8416.13.camel@dyn319181.beaverton.ibm.com>
	 <E1BpMZQ-00016B-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1090942474.18635.6.camel@dyn319181.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jul 2004 08:34:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-27 at 00:40, Miklos Szeredi wrote:
> Ram Pai <linuxram@us.ibm.com> wrote:
> >
> > Also I think the bug that Miklos, found is really hard to reproduce. Did
> > he find this bug by code inspection? Its really really hard to get into
> > a state where the current window is of size 1 page with zero pages in
> > the readahead window, and then the sequential read pattern to just right
> > then. 
> 
> I found it by accident. I did my testing with the following read
> sequence:
> 
> page offset  num pages
> 7            1
> 0            1
> 35           1
> 23           1
> 42           1
> 33           1
> 29           1
> 100          200
> 
> I did not measure actual performance, but only looked at the length of
> the page vector passed to my filesystem's readpages() method.

right. this pattern is just about right to get into that bad state. Had
you had some more random reads then readahead algorithm will go into the
slow-read mode(readahead-off mode) and you will not bump into this bug.

RP

> 
> Miklos
> 

