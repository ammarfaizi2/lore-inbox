Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264727AbTFEP4Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 11:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264729AbTFEP4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 11:56:25 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:55254 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S264727AbTFEP4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 11:56:24 -0400
Date: Thu, 5 Jun 2003 17:12:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Dave McCracken <dmccr@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove page_table_lock from vma manipulations
In-Reply-To: <149060000.1054767502@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0306051704180.3779-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jun 2003, Dave McCracken wrote:
> 
> Gah.  I don't know how I convinced myself that code was safe.  It's easily
> fixed.  How does this one look?

I think you have to keep page_table_lock in expand_stack (GROWSUP and
down versions) because that is called with only down_read on mmap_sem,
so two could be racing: nothing else protects the various vma field
adjustments there.  Otherwise appears correct to me.  Beneficial?

Hugh

