Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVCGPWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVCGPWr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 10:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVCGPWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 10:22:47 -0500
Received: from adsl-346.mirage.euroweb.hu ([193.226.239.90]:13194 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261753AbVCGPWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 10:22:46 -0500
To: dhowells@redhat.com
CC: akpm@osdl.org, torvalds@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org
In-reply-to: <22447.1110204304@redhat.com> (message from David Howells on Mon,
	07 Mar 2005 14:05:04 +0000)
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information
References: <20050307041047.59c24dec.akpm@osdl.org>  <20050307034747.4c6e7277.akpm@osdl.org> <20050307033734.5cc75183.akpm@osdl.org> <20050303123448.462c56cd.akpm@osdl.org> <20050302135146.2248c7e5.akpm@osdl.org> <20050302090734.5a9895a3.akpm@osdl.org> <9420.1109778627@redhat.com> <31789.1109799287@redhat.com> <13767.1109857095@redhat.com> <9268.1110194624@redhat.com> <9741.1110195784@redhat.com> <9947.1110196314@redhat.com> <22447.1110204304@redhat.com>
Message-Id: <E1D8K3T-00056q-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 07 Mar 2005 16:21:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The attached patch replaces backing_dev_info::memory_backed with
> capabilitied bitmap. The capabilities available include:

Wouldn't it be better to reverse the meaning of BDI_CAP_ACCOUNT_DIRTY
and BDI_CAP_WRITEBACK_DIRTY (BDI_CAP_NO_ACCOUNT_DIRTY...)?  That way
out of tree filesystems that implicitly zero bdi->memory_backed
wouldn't _silently_ break.  E.g. fuse does this, though it would not
actually break since it doesn't dirty any pages currently.  I have no
idea whether there are other filesystems that are affected.

Miklos
