Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbUDBKpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 05:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263589AbUDBKpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 05:45:11 -0500
Received: from shuttle.eclipse.ncsc.mil ([144.51.102.80]:142 "EHLO
	eclipse.ncsc.mil") by vger.kernel.org with ESMTP id S263588AbUDBKpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 05:45:07 -0500
From: "Robert W. Maloy" <r.w.maloy@acm.org>
Reply-To: r.w.maloy@acm.org
Organization: I331 (C41)
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Possible error in fs/buffer.c
Date: Fri, 2 Apr 2004 05:46:57 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200404011043.49077.r.w.maloy@acm.org> <20040401162627.7b3f48c7.akpm@osdl.org>
In-Reply-To: <20040401162627.7b3f48c7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404020546.57471.r.w.maloy@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Morton wrote:
> This is saying "is the buffer is not on any list, then place it on
> the mapping's list now.  If the buffer _is_ already on some list
> then we know it must already be on mapping->private_list, so we
> have nothing to do".
>
> Re-dirtying an already-dirty buffer is an extremely common case,
> and here we look for an opportunity to avoid dirtying a cacheline
> or two.

This makes some since except that
     buffer_insert_list(&buffer_mapping->private_lock,
              bh, &mapping->private_list);

 only adds &bh->b_assoc_buffers to the end of mapping->private_list 
not the buffer itself.

-- 
Cheers
Rob Maloy
r.w.maloy@acm.org
(410) 854-6637
