Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbUAENw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 08:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbUAENw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 08:52:58 -0500
Received: from intra.cyclades.com ([64.186.161.6]:13501 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264145AbUAENwt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 08:52:49 -0500
Date: Mon, 5 Jan 2004 11:49:33 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, daniel@osdl.org, janetmor@us.ibm.com,
       pbadari@us.ibm.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
In-Reply-To: <20040102055020.GA3410@in.ibm.com>
Message-ID: <Pine.LNX.4.58L.0401051146480.1188@logos.cnet>
References: <20031231091828.GA4012@in.ibm.com> <20031231013521.79920efd.akpm@osdl.org>
 <20031231095503.GA4069@in.ibm.com> <20031231015913.34fc0176.akpm@osdl.org>
 <20031231100949.GA4099@in.ibm.com> <20031231021042.5975de04.akpm@osdl.org>
 <20031231104801.GB4099@in.ibm.com> <20031231025309.6bc8ca20.akpm@osdl.org>
 <20031231025410.699a3317.akpm@osdl.org> <20031231031736.0416808f.akpm@osdl.org>
 <20040102055020.GA3410@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Jan 2004, Suparna Bhattacharya wrote:

> On Wed, Dec 31, 2003 at 03:17:36AM -0800, Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > Let me actually think about this a bit.
> >
> > Nasty.  The same race is present in 2.4.x...

filemap_fdatawait() is always called with i_sem held and
there is no "!PG_dirty and !PG_writeback" window.

Where does the race lies in 2.4 ?

Daniel, Would be interesting to know if the direct IO tests also fail on
2.4.

> > How's about we start new I/O in filemap_fdatawait() if the page is
> > dirty?
