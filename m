Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266322AbTGEK2p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 06:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbTGEK2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 06:28:45 -0400
Received: from holomorphy.com ([66.224.33.161]:39048 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S266322AbTGEK2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 06:28:44 -0400
Date: Sat, 5 Jul 2003 03:44:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: anton@samba.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030705104433.GK955@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, anton@samba.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <20030704210737.GI955@holomorphy.com> <20030704181539.2be0762a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704181539.2be0762a.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 06:15:39PM -0700, Andrew Morton wrote:
> Look at select_bad_process(), and the ->mm test in badness().  pdflush
> can never be chosen.
> Nevertheless, there have been several report where kernel threads _are_ 
> being hit my the oom killer.  Any idea why that is?

The badness() check isn't good enough. If badness() returns 0 for all
processes with pid's > 0 and the first one seen is a kernel thread the
kernel thread will be chosen. In principle, one could merely retarget
chosen with points >= maxpoints, but that's trivially defeated by
kernel threads landing at the highest pid for whatever reason.


-- wli
