Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264865AbTFLPgV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 11:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264866AbTFLPgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 11:36:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16901 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264865AbTFLPgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 11:36:20 -0400
Date: Thu, 12 Jun 2003 08:49:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
In-Reply-To: <20030612135254.GA2482@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0306120847540.2742-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Jun 2003, Dipankar Sarma wrote:
> 
> hlist poison patch is broken. list_del_rcu() and hlist_del_rcu() 
> *must not* re-initialize the pointers. Maneesh submitted a patch
> earlier today that corrects this -

Sorry, but you're wrong.

If you depend on not re-initializing the pointers, you should not use the 
"xxx_del()" function, and you should document it.

This is that the __xxx_del() functions are there for - they won't do the
poisoning. The regular delete functions have historically always poisoned
the pointers - it was only removed a few months ago by Andrew.

		Linus

