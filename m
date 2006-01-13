Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWAMHnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWAMHnE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 02:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbWAMHnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 02:43:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43194 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932526AbWAMHnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 02:43:01 -0500
Date: Thu, 12 Jan 2006 23:42:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [PATCH] reiserfs: use __GFP_NOFAIL instead of yield and retry
 loop for allocation
Message-Id: <20060112234238.01979912.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0601130932090.17696@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0601130932090.17696@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>
>  -      retry:
>  -	jl = kzalloc(sizeof(struct reiserfs_journal_list), GFP_NOFS);
>  -	if (!jl) {
>  -		yield();
>  -		goto retry;
>  -	}
>  +	jl = kzalloc(sizeof(struct reiserfs_journal_list),
>  +		     GFP_NOFS | __GFP_NOFAIL);

yup, that's what __GFP_NOFAIL is for: to consolidate and identify all those
places which want to lock up when we're short of memory...  They all need
fixing, really.
