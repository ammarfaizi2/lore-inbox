Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbULVRTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbULVRTQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 12:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbULVRTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 12:19:16 -0500
Received: from waste.org ([216.27.176.166]:61133 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261999AbULVRTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 12:19:13 -0500
Date: Wed, 22 Dec 2004 09:18:36 -0800
From: Matt Mackall <mpm@selenic.com>
To: Patrick McHardy <kaber@trash.net>
Cc: Francois Romieu <romieu@fr.zoreil.com>,
       Mark Broadbent <markb@wetlettuce.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
Message-ID: <20041222171836.GL5974@waste.org>
References: <52121.192.102.214.6.1103624620.squirrel@webmail.wetlettuce.com> <20041221123727.GA13606@electric-eye.fr.zoreil.com> <49295.192.102.214.6.1103635762.squirrel@webmail.wetlettuce.com> <20041221204853.GA20869@electric-eye.fr.zoreil.com> <20041221212737.GK5974@waste.org> <20041221225831.GA20910@electric-eye.fr.zoreil.com> <41C93FAB.9090708@trash.net> <41C9525F.4070805@trash.net> <20041222123940.GA4241@electric-eye.fr.zoreil.com> <41C98B75.9020802@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C98B75.9020802@trash.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 03:57:57PM +0100, Patrick McHardy wrote:
> >Of course the patch is completely ugly and violates any layering
> >principle one could think of. It was not submitted for inclusion :o)
> 
> Sure, but I think we should have a short-term workaround until
> a better solution has been invented. Maybe dropping the packets
> would be best for now, it only affects printks issued in paths
> starting at qdisc_restart (-> hard_start_xmit -> ...). Queueing
> the packets might also cause reordering since not all packets
> are queued.

When I mentioned queueing, I was thinking of a netpoll-private queue
that would be hooked to a softirq or some such so that it would be
pushed out as soon as possible. Dropping may be the better approach as
queueing throws away netpoll's immediacy and ordering properties. And
getting netpoll _more_ tangled in the net stack mechanics is
definitely a step in the wrong direction.

More generally, I'm tempted to add some warn_on style functionality so
that printks in such troublesome paths can be lifted out.

-- 
Mathematics is the supreme nostalgia of our time.
