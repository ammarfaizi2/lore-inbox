Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTDEDlx (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 22:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbTDEDlx (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 22:41:53 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:39003 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261757AbTDEDlr (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 22:41:47 -0500
Date: Fri, 4 Apr 2003 22:53:05 -0500 (EST)
From: Rik van Riel <riel@surriel.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@digeo.com>
cc: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
       <hugh@veritas.com>, <dmccr@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: objrmap and vmtruncate
In-Reply-To: <20030404150744.7e213331.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0304042248430.30653-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Apr 2003, Andrew Morton wrote:

> I think that's right - the system call is very specialised and is
> targeted at solving problems which have been encountered in a small
> number of applications, but important ones.
> 
> Right now, I do not feel that we are going to be able to come up with an
> acceptably simple VM which has both nonlinear mappings and objrmap.

This is ok if we make nonlinear VMAs automatically mlocked,
meaning they don't need reverse mapping at all.

If you need the space saving from nonlinear VMAs, you also
need to save the space of any kind of reverse mapping scheme,
even a mythical nonlinear object one (just think about the
minimum amount of data you need to store).

IMHO it'd be fair to limit nonlinear VMAs to the set of very
specialised applications that need it (Oracle, DB2, anything
else?) and impose some limitations on the functionality so
the main part of the VM stay sane.

Rik


