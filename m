Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272495AbTHFFHO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 01:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272801AbTHFFHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 01:07:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:37591 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272495AbTHFFHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 01:07:14 -0400
Date: Tue, 5 Aug 2003 22:08:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: maneesh@in.ibm.com
Cc: jeremy@goop.org, dick.streefland@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] autofs4 doesn't expire
Message-Id: <20030805220848.3ee1111a.akpm@osdl.org>
In-Reply-To: <20030806050003.GB1298@in.ibm.com>
References: <4b0c.3f302ca5.93873@altium.nl>
	<20030805164904.36b5d2cc.akpm@osdl.org>
	<20030806042853.GA1298@in.ibm.com>
	<1060144454.18625.5.camel@ixodes.goop.org>
	<20030806050003.GB1298@in.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni <maneesh@in.ibm.com> wrote:
>
>  +	if (vfs) {
>  +		if (is_vfsmnt_tree_busy(vfs))
>  +			ret--;
>  +		/* just to reduce ref count taken in lookup_mnt
>  +	 	 * cannot call mntput() here
>  +	 	 */
>  +		atomic_dec(&vfs->mnt_count);
>  +	}

Doesn't work, does it?  If someone else does a mntput() just beforehand,
__mntput() never gets run.

