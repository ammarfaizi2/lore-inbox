Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWEZCdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWEZCdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 22:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWEZCdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 22:33:43 -0400
Received: from graphe.net ([209.204.138.32]:233 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S1030202AbWEZCdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 22:33:43 -0400
Date: Thu, 25 May 2006 19:33:36 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Jeff Anderson-Lee <jonah@eecs.berkeley.edu>
cc: "'Christoph Lameter'" <clameter@sgi.com>,
       "'Peter Zijlstra'" <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, "'Hugh Dickins'" <hugh@veritas.com>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'David Howells'" <dhowells@redhat.com>,
       "'Martin Bligh'" <mbligh@google.com>, "'Nick Piggin'" <npiggin@suse.de>,
       "'Linus Torvalds'" <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] mm: tracking shared dirty pages
In-Reply-To: <000001c6806c$19403760$ce2a2080@eecs.berkeley.edu>
Message-ID: <Pine.LNX.4.64.0605251931380.15494@graphe.net>
References: <20060525135534.20941.91650.sendpatchset@lappy>
 <20060525135555.20941.36612.sendpatchset@lappy>
 <Pine.LNX.4.64.0605250921300.23726@schroedinger.engr.sgi.com>
 <000001c6806c$19403760$ce2a2080@eecs.berkeley.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-858709878-441145819-1148610816=:15494"
X-Spam-Score: -2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---858709878-441145819-1148610816=:15494
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 25 May 2006, Jeff Anderson-Lee wrote:

> Christoph Lameter wrote:
>=20
> > I am a bit confused about the need for Davids patch. set_page_dirty() i=
s=20
> > already a notification that a page is to be dirtied. Why do we need it=
=20
> > twice? set_page_dirty could return an error code and the file system ca=
n=20
> > use the set_page_dirty() hook to get its notification. What we would ne=
ed=20
> > to do is to make sure that set_page_dirty can sleep.
>=20
> set_page_dirty() is actually called fairly late in the game by
> zap_pte_range() and follow_page().=A0 Thus, it is a notification that a p=
age
> HAS BEEN dirtied and needs a writeback.

The tracking patch changes that behavior. set_page_dirty is called before=
=20
the write to the page occurs and so its similar to the new method=20
introduced by David's patch.
=20
---858709878-441145819-1148610816=:15494--
