Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVK1IcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVK1IcE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 03:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVK1IcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 03:32:04 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:51907 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751209AbVK1IcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 03:32:03 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, paulmck@us.ibm.com, greg@kroah.com,
       sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, Douglas_Warzecha@dell.com,
       Abhay_Salunke@dell.com, achim_leubner@adaptec.com,
       dmp@davidmpye.dyndns.org
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain 
In-reply-to: Your message of "Mon, 28 Nov 2005 05:59:22 BST."
             <20051128045922.GK20775@brahms.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 28 Nov 2005 19:31:36 +1100
Message-ID: <4544.1133166696@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2005 05:59:22 +0100, 
Andi Kleen <ak@suse.de> wrote:
>On Sun, Nov 27, 2005 at 08:57:45PM -0800, Andrew Morton wrote:
>> "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
>> >
>> > Any options I missed?
>> 
>> Stop using the notifier chains from NMI context - it's too hard.  Use a
>> fixed-size array in the NMI code instead.
>
>Or just don't unregister. That is what I did for the debug notifiers.

Unregister is not the only problem.  Chain traversal races with
register as well.

