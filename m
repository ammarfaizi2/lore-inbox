Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTENSwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTENSwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:52:13 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:42374 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263638AbTENSwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:52:08 -0400
Date: Wed, 14 May 2003 15:04:55 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@digeo.com>
cc: Dave McCracken <dmccr@us.ibm.com>, <mika.penttila@kolumbus.fi>,
       <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Race between vmtruncate and mapped areas?
In-Reply-To: <Pine.LNX.4.44.0305141501180.10617-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0305141503010.10617-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Rik van Riel wrote:
> On Wed, 14 May 2003, Andrew Morton wrote:
> 
> > It would be nice to make them go away - they cause problems.
> 
> Not to mention they could end up being outside of any VMA,
> meaning there's no sane way to deal with them.

I hate to follow up to my own email, but the fact that
they're not in any VMA could mean we leak these pages
at exit() time.

Which means a security bug, as well as the potential to
end up with bad pointers in kernel space, eg. think about
the rmap code jumping to a no longer existing mm_struct.

The more I think about it, the more I agree with Andrew
that it would be really really nice to get rid of them ;)

