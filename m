Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbSJLXqJ>; Sat, 12 Oct 2002 19:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSJLXqJ>; Sat, 12 Oct 2002 19:46:09 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:64160 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261374AbSJLXqJ>; Sat, 12 Oct 2002 19:46:09 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alexander Viro <viro@math.psu.edu>
Date: Sun, 13 Oct 2002 09:51:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15784.46468.880128.458867@notabene.cse.unsw.edu.au>
Cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.42: build nfsd as module broken
In-Reply-To: message from Alexander Viro on Saturday October 12
References: <871y6vwmft.fsf@goat.bogus.local>
	<Pine.GSO.4.21.0210121423500.6898-100000@steklov.math.psu.edu>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday October 12, viro@math.psu.edu wrote:
> 
> 
> On Sat, 12 Oct 2002, Olaf Dietsche wrote:
> 
> > +EXPORT_SYMBOL(cache_fresh);
> > +EXPORT_SYMBOL(cache_flush);
> > +EXPORT_SYMBOL(cache_unregister);
> > +EXPORT_SYMBOL(cache_check);
> > +EXPORT_SYMBOL(cache_clean);
> > +EXPORT_SYMBOL(cache_register);
> > +EXPORT_SYMBOL(cache_init);
> > +EXPORT_SYMBOL(add_word);
> > +EXPORT_SYMBOL(add_hex);
> > +EXPORT_SYMBOL(get_word);
> 
> Ahem.  Non-static objects called add_word and get_word?  Even the cache_...()
> stuff is a namespace pollution (which kind of cache?), but that...

Fair comment.

The words are actually 'quoted words', so maybe:

 qword_add
 qword_addhex
 qword_parse  (or qword_get) 

 would be better.

The caches are for caching user-space-sourced information (IP ->
hostname, export options, uid->username etc) so maybe

  ucache_*
though that is a bit bland....

  uss_cache_*

(for the trekkies)???

NeilBrown
