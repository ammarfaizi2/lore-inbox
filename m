Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318426AbSGZTQB>; Fri, 26 Jul 2002 15:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318441AbSGZTQB>; Fri, 26 Jul 2002 15:16:01 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:62470 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318426AbSGZTQA>; Fri, 26 Jul 2002 15:16:00 -0400
Date: Fri, 26 Jul 2002 16:18:56 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Robert Love <rml@tech9.net>
cc: Russell Lewis <spamhole-2001-07-16@deming-os.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Looking for links: Why Linux Doesn't Page Kernel Memory?
In-Reply-To: <1027710974.2443.39.camel@sinai>
Message-ID: <Pine.LNX.4.44L.0207261617020.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jul 2002, Robert Love wrote:
> On Fri, 2002-07-26 at 12:10, Rik van Riel wrote:
> > On 26 Jul 2002, Robert Love wrote:
> >
> > > Better question is, why would we have page-able kernel memory?
> >
> > We don't want to have generic page-able kernel memory.
> >
> > However, it might be useful to be able to reclaim or page
> > out data structures that might otherwise gobble up all of
> > RAM and crash the machine, say page tables.
>
> I agree a better solution than high-pte is probably needed.  Shared page
> tables and/or large page tables insufficient?

Large pages and/or shared page tables should be more than
sufficient to handle all 'benign' real workloads.

However, 'malicious' workloads can easily generate the
need for more pagetables than what will fit into physical
RAM; at that point you just _have_ to throw some of these
page tables out of RAM.  If the data can be reconstructed
from the VMA and the page cache, we can just blow the page
table away. If it can't, we have to come up with another
solution (maybe as simple as killing the application).

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

