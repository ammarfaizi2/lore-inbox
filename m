Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264746AbUGFXzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264746AbUGFXzY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 19:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbUGFXzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 19:55:23 -0400
Received: from holomorphy.com ([207.189.100.168]:22490 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264746AbUGFXzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 19:55:21 -0400
Date: Tue, 6 Jul 2004 16:55:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm6
Message-ID: <20040706235515.GY21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040705023120.34f7772b.akpm@osdl.org> <20040706125438.GS21066@holomorphy.com> <200407061251.18702.dtor_core@ameritech.net> <20040706231256.GV21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040706231256.GV21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 12:51:16PM -0500, Dmitry Torokhov wrote:
>> Ok, I think I know what the problem is - it should be an oops rather than a
>> deadlock though - serial drivers are initialized before serio core when serio
>> bus structure is not registered with driver core yet. Could you please try
>> the patch below - I do not have hardware to test it:

On Tue, Jul 06, 2004 at 04:12:56PM -0700, William Lee Irwin III wrote:
> Unfortunately this didn't repair it. Bootlog attached. The failure to
> respond to "send brk" indicates deadlock with interrupts disabled.

It may also help to know that I did bisection search on 2.6.7-mm* that
had various contents of bk-input split out; in those, the offending
patch was revealed to be input-serio-sysfs-intergration.patch which
I think corresponds to:
# ChangeSet
#   2004/06/29 01:28:53-05:00 dtor_core@ameritech.net 
#   Input: serio sysfs integration
#   Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

or one of the csets nearby in the consolidated bk-input.patch


-- wli
