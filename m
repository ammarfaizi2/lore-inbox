Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVA0Kjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVA0Kjp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVA0KiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:38:12 -0500
Received: from zeus.kernel.org ([204.152.189.113]:25541 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262560AbVA0KUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:20:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XxtsXyn2hZ64fU+rtVtBR20OmItGRtYabXx5vIXDukwC0kr55QW131ekUY14XIr9gkx9JgRTto0KjksuM1B2yYd95adlWYIetRx0v5x2hFCWPL6NCycKl2/8XNwix+7hJEJ7ONmckrii8SiJ7dvSk8yb8uCsslFmTEX6QBK7j4E=
Message-ID: <5a4c581d0501270219173ee10d@mail.gmail.com>
Date: Thu, 27 Jan 2005 11:19:20 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Memory leak in 2.6.11-rc1?
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, torvalds@osdl.org,
       alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <20050127004732.5d8e3f62.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050121161959.GO3922@fi.muni.cz> <20050123091154.GC16648@suse.de>
	 <20050123011918.295db8e8.akpm@osdl.org>
	 <20050123095608.GD16648@suse.de>
	 <20050123023248.263daca9.akpm@osdl.org>
	 <20050123200315.A25351@flint.arm.linux.org.uk>
	 <20050124114853.A16971@flint.arm.linux.org.uk>
	 <20050125193207.B30094@flint.arm.linux.org.uk>
	 <20050127082809.A20510@flint.arm.linux.org.uk>
	 <20050127004732.5d8e3f62.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005 00:47:32 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> > This mornings magic numbers are:
> >
> >  3
> >  ip_dst_cache        1292   1485    256   15    1
> 
> I just did a q-n-d test here: send one UDP frame to 1.1.1.1 up to
> 1.1.255.255.  The ip_dst_cache grew to ~15k entries and grew no further.
> It's now gradually shrinking.  So there doesn't appear to be a trivial
> bug..
> 
> >  Is no one interested in the fact that the DST cache is leaking and
> >  eventually takes out machines?  I've had virtually zero interest in
> >  this problem so far.
> 
> I guess we should find a way to make it happen faster.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Data point... on my box, used as ed2k/bittorrent
 machine, the ip_dst_cache grows and shrinks quite
 fast; these two samples were ~3 minutes apart:


[root@donkey ~]# grep ip_dst /proc/slabinfo
ip_dst_cache         998   1005    256   15    1 : tunables  120   60 
  0 : slabdata     67     67      0
[root@donkey ~]# wc -l /proc/net/rt_cache
926 /proc/net/rt_cache

[root@donkey ~]# grep ip_dst /proc/slabinfo
ip_dst_cache         466    795    256   15    1 : tunables  120   60 
  0 : slabdata     53     53      0
[root@donkey ~]# wc -l /proc/net/rt_cache
443 /proc/net/rt_cache

 and these were 2 seconds apart

[root@donkey ~]# wc -l /proc/net/rt_cache
737 /proc/net/rt_cache
[root@donkey ~]# grep ip_dst /proc/slabinfo
ip_dst_cache         795    795    256   15    1 : tunables  120   60 
  0 : slabdata     53     53      0

[root@donkey ~]# wc -l /proc/net/rt_cache
1023 /proc/net/rt_cache
[root@donkey ~]# grep ip_dst /proc/slabinfo
ip_dst_cache        1035   1035    256   15    1 : tunables  120   60 
  0 : slabdata     69     69      0

--alessandro
 
  "And every dream, every, is just a dream after all"
 
     (Heather Nova, "Paper Cup")
