Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263129AbVG3T2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbVG3T2g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbVG3T0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:26:18 -0400
Received: from silver.veritas.com ([143.127.12.111]:42166 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S263117AbVG3TZk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:25:40 -0400
Date: Sat, 30 Jul 2005 20:27:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Frank van Maarseveen <frankvm@frankvm.com>
cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4: no hyperthreading and idr_remove() stack traces
In-Reply-To: <20050729162006.GA18866@janus>
Message-ID: <Pine.LNX.4.61.0507302017400.3459@goblin.wat.veritas.com>
References: <20050729162006.GA18866@janus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 30 Jul 2005 19:25:39.0927 (UTC) FILETIME=[7853EE70:01C5953C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005, Frank van Maarseveen wrote:
> 2.6.13-rc4 does not recognize the second CPU of a 3GHz HT P4:

I think your problem is this: HT has depended on CONFIG_ACPI for
some while, and now in 2.6.13-rc CONFIG_ACPI depends on CONFIG_PM.
You don't have CONFIG_PM set in your .config (nor had I), so you
don't get ACPI, so you don't get HT.

I don't know why CONFIG_ACPI now depends on CONFIG_PM: it seemed
gratuitous when it first hit me, looked like someone just felt it
was a nice arrangement.  But seems particularly unhelpful for HT.

On the other hand, I can well understand Len wanting to simplify
the ACPI config interdependencies, which have caused breakage
after breakage after breakage.

Hugh
