Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314124AbSD2RvL>; Mon, 29 Apr 2002 13:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314136AbSD2RvK>; Mon, 29 Apr 2002 13:51:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13922 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314124AbSD2RvK>; Mon, 29 Apr 2002 13:51:10 -0400
To: suparna@in.ibm.com
Cc: linux-kernel@vger.kernel.org, marcelo@brutus.conectiva.com.br,
        <linux-mm@kvack.org>
Subject: Re: [PATCH]Fix: Init page count for all pages during higher order allocs
In-Reply-To: <20020429202446.A2326@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Apr 2002 11:40:21 -0600
Message-ID: <m1r8ky1jzu.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> The call to set_page_count(page, 1) in page_alloc.c appears to happen 
> only for the first page, for order 1 and higher allocations.
> This leaves the count for the rest of the pages in that block 
> uninitialised.

Actually it should be zero.

This is deliberate because high order pages should not be referenced by
their partial pages.  It might make sense to add a PG_large flag and
then in the immediately following struct page add a pointer to the next
page, so you can identify these pages by inspection.  Doing something
similar to the PG_skip flag.

Beyond that I get nervous, that people will treat it as endorsement of
doing a high order continuous allocation and then fragmenting the page.

Eric
