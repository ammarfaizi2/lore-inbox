Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTJRLWI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 07:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTJRLWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 07:22:08 -0400
Received: from coderock.org ([193.77.147.115]:44804 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261555AbTJRLWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 07:22:03 -0400
From: Domen Puncer <domen@coderock.org>
To: linux-kernel@vger.kernel.org
Subject: intermezzo/replicator.c - bug in izo_rep_cache_clean() [2.6.0-test8]?
Date: Sat, 18 Oct 2003 13:21:58 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310181321.58317.domen@coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This is an old one... posted to intermezzo ml a couple of times, but
still isn't fixed in -test8.


On Saturday 12 of July 2003 18:07, Matthew Wilcox wrote:
> On Sat, Jul 12, 2003 at 05:22:55PM +0200, Domen Puncer wrote:
> > ---
> > fs/intermezzo/replicator.c:83: //izo_rep_cache_clean()
> >                 tmp = bucket = &fset->fset_clients[i];
> >
> >                 tmp = tmp->next;
> >                 while (tmp != bucket) {
> >                         struct izo_offset_rec *offrec;
> >                         tmp = tmp->next;
> >                         list_del(tmp);
> >                         offrec = list_entry(tmp, struct izo_offset_rec,
> >                                             or_list);
> >                         PRESTO_FREE(offrec, sizeof(struct
> > izo_offset_rec)); }
> >
> > This code just doesn't look right.
> > We delete tmp (tmp->next = LIST_POISON1)... next time we'll
> >  list_del(LIST_POISON1)!!
> > We also do not delete first entry in the list
> > &fset->fset_clients[i]->next.
>
> Yup, looks like a bug.  I bet they meant to list_del(&tmp->prev).

I guess it could be written like this:
        list_for_each_save(tmp, next, bucket) {
                struct izo_offset_rec *offrec;
                list_del(tmp);
                ...


        Domen

