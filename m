Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbWADHbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbWADHbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 02:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWADHbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 02:31:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42159 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965191AbWADHbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 02:31:51 -0500
Date: Tue, 3 Jan 2006 23:31:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/3] mm: add a new function (needed for swap
 suspend)
Message-Id: <20060103233127.26328cba.akpm@osdl.org>
In-Reply-To: <200512271752.47003.rjw@sisk.pl>
References: <200512271747.43374.rjw@sisk.pl>
	<200512271752.47003.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> @@ -211,6 +211,26 @@
>   	return (swp_entry_t) {0};
>   }
>   
>  +swp_entry_t get_swap_page_of_type(int type)
>  +{
>  +	struct swap_info_struct *si;
>  +	pgoff_t offset;
>  +
>  +	spin_lock(&swap_lock);
>  +	si = swap_info + type;
>  +	if (si->flags & SWP_WRITEOK) {
>  +		nr_swap_pages--;
>  +		offset = scan_swap_map(si);
>  +		if (offset) {
>  +			spin_unlock(&swap_lock);
>  +			return swp_entry(type, offset);
>  +		}
>  +		nr_swap_pages++;
>  +	}
>  +	spin_unlock(&swap_lock);
>  +	return (swp_entry_t) {0};
>  +}

A little introductory comment would have been nice..

Would it be appropriate to put this under CONFIG_SOMETHING to save a little
space?

