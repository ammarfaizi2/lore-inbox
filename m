Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316894AbSEVIyn>; Wed, 22 May 2002 04:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316895AbSEVIym>; Wed, 22 May 2002 04:54:42 -0400
Received: from imladris.infradead.org ([194.205.184.45]:14347 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316894AbSEVIym>; Wed, 22 May 2002 04:54:42 -0400
Date: Wed, 22 May 2002 09:54:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: khttpd and tmpfs don't get along?
Message-ID: <20020522095440.A13744@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dan Kegel <dank@kegel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3CEAF6F2.BB70395D@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 06:40:02PM -0700, Dan Kegel wrote:
> I've found that khttpd tends to oops when used with tmpfs.
> The oops tracebacks are not especially informative.
> So far, I've only verified this with ppc, but I should be
> able to verify it with x86 soon.

That's because it abuses do_generic_file_read.  It' the same design mistake
that also makes loop fail on tmpfs - do_generic_file_read should never have
been exported from filemap.c..

