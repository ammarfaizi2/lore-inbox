Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbSJVRp4>; Tue, 22 Oct 2002 13:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264784AbSJVRpT>; Tue, 22 Oct 2002 13:45:19 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:24582 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264818AbSJVRnd>; Tue, 22 Oct 2002 13:43:33 -0400
Date: Tue, 22 Oct 2002 18:49:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [patch] generic nonlinear mappings, 2.5.44-mm2-D0
Message-ID: <20021022184938.A2395@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@zip.com.au>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <Pine.LNX.4.44.0210221936010.18790-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210221936010.18790-100000@localhost.localdomain>; from mingo@elte.hu on Tue, Oct 22, 2002 at 07:57:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 07:57:00PM +0200, Ingo Molnar wrote:
> the attached patch (ontop of 2.5.44-mm2) implements generic (swappable!)
> nonlinear mappings and sys_remap_file_pages() support. Ie. no more
> MAP_LOCKED restrictions and strange pagefault semantics.
> 
> to implement this i added a new pte concept: "file pte's". This means that
> upon swapout, shared-named mappings do not get cleared but get converted
> into file pte's, which can then be decoded by the pagefault path and can
> be looked up in the pagecache.
> 
> the normal linear pagefault path from now on does not assume linearity and
> decodes the offset in the pte. This also tests pte encoding/decoding in
> the pagecache case, and the ->populate functions.

Ingo,

what is the reason for that interface?  It looks like a gross performance
hack for misdesigned applications to me, kindof windowsish..

Is this for whoracle or something like that?
