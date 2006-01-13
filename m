Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161228AbWAMHqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbWAMHqO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 02:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161242AbWAMHqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 02:46:14 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:22912 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161228AbWAMHqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 02:46:14 -0500
Date: Fri, 13 Jan 2006 09:46:12 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [PATCH] reiserfs: use __GFP_NOFAIL instead of yield and retry
 loop for allocation
In-Reply-To: <20060112234238.01979912.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0601130944360.20349@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0601130932090.17696@sbz-30.cs.Helsinki.FI>
 <20060112234238.01979912.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> >
> >  -      retry:
> >  -	jl = kzalloc(sizeof(struct reiserfs_journal_list), GFP_NOFS);
> >  -	if (!jl) {
> >  -		yield();
> >  -		goto retry;
> >  -	}
> >  +	jl = kzalloc(sizeof(struct reiserfs_journal_list),
> >  +		     GFP_NOFS | __GFP_NOFAIL);

On Thu, 12 Jan 2006, Andrew Morton wrote:
> yup, that's what __GFP_NOFAIL is for: to consolidate and identify all those
> places which want to lock up when we're short of memory...  They all need
> fixing, really.

Out of curiosity, are there any potential problems with combining GFP_NOFS 
and __GFP_NOFAIL? Can we really guarantee to give out memory if we're not 
allowed to page out?

			Pekka
