Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266303AbUG0HlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUG0HlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 03:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266338AbUG0HlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 03:41:24 -0400
Received: from mail.euroweb.hu ([193.226.220.4]:64429 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S266337AbUG0HlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 03:41:21 -0400
To: linuxram@us.ibm.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <1090901926.8416.13.camel@dyn319181.beaverton.ibm.com> (message
	from Ram Pai on 26 Jul 2004 21:18:47 -0700)
Subject: Re: [PATCH] fix readahead breakage for sequential after random
	reads
References: <E1BmKAd-0001hz-00@dorka.pomaz.szeredi.hu>
	 <20040726162950.7f4a3cf4.akpm@osdl.org>
	 <1090886218.8416.3.camel@dyn319181.beaverton.ibm.com>
	 <20040726170843.3fe5615c.akpm@osdl.org> <1090901926.8416.13.camel@dyn319181.beaverton.ibm.com>
Message-Id: <E1BpMZQ-00016B-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 27 Jul 2004 09:40:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ram Pai <linuxram@us.ibm.com> wrote:
>
> Also I think the bug that Miklos, found is really hard to reproduce. Did
> he find this bug by code inspection? Its really really hard to get into
> a state where the current window is of size 1 page with zero pages in
> the readahead window, and then the sequential read pattern to just right
> then. 

I found it by accident. I did my testing with the following read
sequence:

page offset  num pages
7            1
0            1
35           1
23           1
42           1
33           1
29           1
100          200

I did not measure actual performance, but only looked at the length of
the page vector passed to my filesystem's readpages() method.

Miklos
