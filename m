Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWAWRCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWAWRCD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 12:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWAWRCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 12:02:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27603 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964816AbWAWRCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 12:02:00 -0500
Date: Mon, 23 Jan 2006 17:01:47 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] device-mapper snapshot: barriers not supported
Message-ID: <20060123170147.GJ4280@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060120211759.GG4724@agk.surrey.redhat.com> <20060122214111.11170cdc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060122214111.11170cdc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 09:41:11PM -0800, Andrew Morton wrote:
> Alasdair G Kergon <agk@redhat.com> wrote:
> > The snapshot and origin targets are incapable of handling barriers and 
> >  need to indicate this.

> And what was happening if people _were_ sending such BIOs down?  Did it all
> appear to work correctly?  

The snapshot target ignores the barrier and in some circumstances I/O can be
reordered in ways that are meant to be prevented by the barrier.

> If so, will this change cause
> currently-apparently-working setups to stop working?

As Lars pointed out, filesystems should already cope with -EOPNOTSUPP 
transparently, and it would be sensible for any out-of-tree users to 
do likewise.

Alasdair
-- 
agk@redhat.com
