Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbUKKVOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbUKKVOk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 16:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbUKKVOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:14:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:940 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262383AbUKKVOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:14:38 -0500
Date: Thu, 11 Nov 2004 13:14:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WTF is VLI?
Message-Id: <20041111131430.04e96012.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0411112103060.3167-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0411112103060.3167-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> What is this "VLI" that 2.6.9 started putting after the taint string
> in i386 oopses?  Vick Library Index?  Vineyard Leadership Institute?
> Shall we just remove it?
> 

It's a magic kaos cookie:

  ksymoops handles up to 64 code bytes so dump eip-43:eip+20 with the eip
  byte enclosed in <>.  Add the string 'VLI ' (variable length
  instructions) just before the taint output, ksymoops 2.4.8 will look
  for 'VLI ' on the 'EIP:' line and split the code line into two chunks.

and

  The VLI indicator tells ksymoops the dump has variable length
  instructions so ksymoops splits the code into two lines at the eip byte. 
  Without the VLI indicator or using ksymoops < 2.4.9, ksymoops decodes the
  whole line in one go.  


I think the rationale is mainly so that new ksymoopses won't make a mess of
old oops records.

