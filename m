Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUG1VWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUG1VWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbUG1VWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:22:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:32202 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264246AbUG1VWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:22:14 -0400
Date: Wed, 28 Jul 2004 14:25:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: ncunningham@linuxmail.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add missing refrigerator support.
Message-Id: <20040728142534.3ed84b99.akpm@osdl.org>
In-Reply-To: <1090999347.8316.15.camel@laptop.cunninghams>
References: <1090999347.8316.15.camel@laptop.cunninghams>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@linuxmail.org> wrote:
>
> +				if (current->flags & PF_FREEZE) {
> +					refrigerator(PF_FREEZE);
> +					continue;
> +				}

This seems excessively verbose.  Why not do:

	if (try_to_freeze())
		continue;


/*
 * Comment goes here
 */
static inline int try_to_freeze(void)
{
	/* I think the compiler propagates likeliness to the inline's caller */
	if (unlikely(current->flags & PF_FREEZE)) {
		refrigerator(PF_FREEZE);
		return 1;
	}
	return 0;
}

