Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317263AbSG2OOT>; Mon, 29 Jul 2002 10:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317380AbSG2OOT>; Mon, 29 Jul 2002 10:14:19 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:11470 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317263AbSG2OOS>; Mon, 29 Jul 2002 10:14:18 -0400
Date: Mon, 29 Jul 2002 19:48:25 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>
Subject: Re: [RFC] Scalable statistics counters using kmalloc_percpu
Message-ID: <20020729194825.B2393@in.ibm.com>
References: <20020726204033.D18570@in.ibm.com> <Pine.LNX.4.44L.0207261225160.3086-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44L.0207261225160.3086-100000@imladris.surriel.com>; from riel@conectiva.com.br on Fri, Jul 26, 2002 at 12:27:40PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 12:27:40PM -0300, Rik van Riel wrote:
> On Fri, 26 Jul 2002, Ravikiran G Thirumalai wrote:
> 
> > Rik, You were interested in using this.  Does this implementation suit
> > your needs?
> 
> >From a quick glance it looks like it will.
> 
> However, it might be more efficient to put the statistics
> in one file in /proc with named fields, or have a way to
> group them in one or multiple files.
>

Ok, Here's what I have in mind;
Introduce a statctr_base_t type which represents a group of counters on
the same proc file, have statctr_base_init and statctr_base_cleanup
to create and destroy these datatypes.  Each line in the /proc file
will be of the form
countername value

Here are the changed and new interfaces:
1. int statctr_init(statctr_t *statctr, unsigned long value,
		statctr_base_t *base, const char *countername, int flags);
2. void statctr_cleanup(statctr_t *);
3. int statctr_base_init(statctr_base_t *base,
                struct proc_dir_entry *procbase, const char *procname);
4. extern void statctr_base_cleanup(satctr_base_t *base);

Does this look ok?
 
> Not sure about that, though ... really depends on how
> expensive stat+open+read+close is compared to parsing a
> file with multiple fields.
>

Also, when you group counters into a single file, you inadvertently 
end up  reading counters you may not require at that time.
Reads to  statctrs are not as cheap as cpu local writes. You'll have to 
take that into account too i guess ..... 

Thanks,
Kiran
