Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSEURdi>; Tue, 21 May 2002 13:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315263AbSEURdh>; Tue, 21 May 2002 13:33:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22025 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315245AbSEURdg>;
	Tue, 21 May 2002 13:33:36 -0400
Message-ID: <3CEA85DC.8623C6B8@zip.com.au>
Date: Tue, 21 May 2002 10:37:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Antti Salmela <asalmela@iki.fi>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: ext3 assertion failure and oops, 2.4.18
In-Reply-To: <20020521114244.GA29043@otitsun.oulu.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antti Salmela wrote:
> 
> I can reliably reproduce an assertion failure and oops in ext3 by simply
> restarting cyrus21, if directories used by cyrus have +j flag set with
> chattr. Filesystem was mounted with default journalling mode data=orderded,
> kernels tested were 2.4.18 and 2.4.19-pre3-ac4. Recent -pre or -ac kernels
> wouldn't compile with my .config.
> 
> Assertion failure in journal_revoke() at revoke.c:330:
> "!(__builtin_constant_p(BH_Revoked) ? constant_test_bit((BH_Revoked),(
> &bh->b_state)) : variable_test_bit((BH_Revoked),( &bh->b_state)))"
> 
> I'll capture whole oops if requested.
> 
> I found two similar cases from lkml archives, but they were left
> unresponded (atleast lkml wasn't cc'ed). I couldn't judge from changelogs if
> this problem has been already fixed.
> 
> http://groups.google.com/groups?selm=2446DD7E.7F1AEC90.00A5E169%40netscape.net&output=gplain
> http://groups.google.com/groups?as_umsgid=%3C2446DD7E.7F1AEC90.00A5E169%40netscape.net%3E&lr=&hl=en
> 

It seems that mixing journalling modes in this manner doesn't work.
Please turn off +j for the while - we'll aim to fix this in 2.4.20.

-
