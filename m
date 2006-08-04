Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbWHDDSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWHDDSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWHDDSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:18:31 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:17887 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030308AbWHDDSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:18:30 -0400
Date: Fri, 4 Aug 2006 12:19:50 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: kmannth@us.ibm.com
Cc: akpm@osdl.org, y-goto@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] memory hotadd fixes [6/5] enhance collistion check
Message-Id: <20060804121950.b3227092.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1154660982.5925.87.camel@keithlap>
References: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>
	<1154650396.5925.49.camel@keithlap>
	<20060804094443.c6f09de6.kamezawa.hiroyu@jp.fujitsu.com>
	<1154656472.5925.71.camel@keithlap>
	<20060804111550.ab30fc15.kamezawa.hiroyu@jp.fujitsu.com>
	<20060804113245.30487789.kamezawa.hiroyu@jp.fujitsu.com>
	<1154660982.5925.87.camel@keithlap>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2006 20:09:42 -0700
keith mannthey <kmannth@us.ibm.com> wrote:
> >  	pg_data_t *pgdat = NULL;
> >  	int new_pgdat = 0;
> > +	struct resource *res;
> >  	int ret;
> >  
> > +	res = register_memory_resource(start, size);
> > +	if (!res)
> > +		return -EEXIST;
> > +
> >  	if (!node_online(nid)) {
> >  		pgdat = hotadd_new_pgdat(nid, start);
> >  		if (!pgdat)
> > @@ -277,14 +293,13 @@
> >  		BUG_ON(ret);
> >  	}
> >  
> > -	/* register this memory as resource */
> > -	ret = register_memory_resource(start, size);
> > -
> >  	return ret;
> >  error:
> >  	/* rollback pgdat allocation and others */
> >  	if (new_pgdat)
> >  		rollback_node_hotadd(nid, pgdat);
> > +	if (res)
> > +		release_memory_resource(res);
> >  
> 
> 
> I am trying to keep add_memory non-sparsemem specific.  With reserve
> memory the memory is already present and so using
> register_memory_resource as a key to find out if it is already present
> won't work.
> 
Hm, okay. looks your help is necessary.

> I can build ontop of this if you want me to.  I would like to test this
> to make sure it works for me. (I will do this sometime today)
> 
Thanks!
-Kame

