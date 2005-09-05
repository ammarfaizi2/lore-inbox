Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVIEFi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVIEFi3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 01:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVIEFi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 01:38:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30084 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932215AbVIEFi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 01:38:28 -0400
Date: Mon, 5 Sep 2005 13:43:48 +0800
From: David Teigland <teigland@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050905054348.GC11337@redhat.com>
References: <20050901104620.GA22482@redhat.com> <1125574523.5025.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125574523.5025.10.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 01:35:23PM +0200, Arjan van de Ven wrote:

> +void gfs2_glock_hold(struct gfs2_glock *gl)
> +{
> +	glock_hold(gl);
> +}
> 
> eh why?

You removed the comment stating exactly why, see below.  If that's not a
accepted technique in the kernel, say so and I'll be happy to change it
here and elsewhere.
Thanks,
Dave

static inline void glock_hold(struct gfs2_glock *gl)
{
        gfs2_assert(gl->gl_sbd, atomic_read(&gl->gl_count) > 0);
        atomic_inc(&gl->gl_count);
}

/**
 * gfs2_glock_hold() - As glock_hold(), but suitable for exporting
 * @gl: The glock to hold
 *
 */

void gfs2_glock_hold(struct gfs2_glock *gl)
{
        glock_hold(gl);
}

