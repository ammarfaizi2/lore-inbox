Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWJBKUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWJBKUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 06:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWJBKUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 06:20:16 -0400
Received: from main.gmane.org ([80.91.229.2]:54155 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750725AbWJBKUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 06:20:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: How is Code in do_sys_settimeofday() safe in case of SMP and Nest Kernel Path?
Date: 02 Oct 2006 12:12:34 +0200
Message-ID: <87hcynm3fx.fsf@willow.rfc1149.net>
References: <a2ebde260609290733m207780f0t8601e04fcf64f0a6@mail.gmail.com> <Pine.LNX.4.64.0609290903550.23840@schroedinger.engr.sgi.com> <a2ebde260609290916j3a3deb9g33434ca5d93e7a84@mail.gmail.com> <451E8143.5030300@yahoo.com.au> <a2ebde260609300909l5f33c152xa331f7600be67f6b@mail.gmail.com> <Pine.LNX.4.64.0609301015060.3519@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: zaphod.rfc1149.net
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
X-Leafnode-NNTP-Posting-Host: 2001:6f8:37a:2::2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Lameter <clameter@sgi.com> writes:

Christoph> I really hate adding overhead to gettimeofday() and we
Christoph> would have to take the seqlock in all places when we
Christoph> reference tz. Maybe we can tolerate the resulting race?

Agreed. In some applications, gettimeofday() is called an awfully lot
of times. And the only plausible case where settimeofday() is called
after boot is on a multi-core laptop during a traval accross different
timezones, where it is unlikely that time-and-DST-sensitive
applications would be running.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

