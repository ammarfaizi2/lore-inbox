Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289385AbSAODZb>; Mon, 14 Jan 2002 22:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289387AbSAODZV>; Mon, 14 Jan 2002 22:25:21 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:36847 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S289385AbSAODZS>; Mon, 14 Jan 2002 22:25:18 -0500
Date: Mon, 14 Jan 2002 19:28:40 -0800
From: Chris Wright <chris@wirex.com>
To: Christopher James <cjames@berkeley.innomedia.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Multicast fails when interface changed
Message-ID: <20020114192840.A23120@figure1.int.wirex.com>
Mail-Followup-To: Christopher James <cjames@berkeley.innomedia.com>,
	kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
In-Reply-To: <200201142016.XAA10180@ms2.inr.ac.ru> <3C4374BA.F8E26684@berkeley.innomedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C4374BA.F8E26684@berkeley.innomedia.com>; from cjames@berkeley.innomedia.com on Mon, Jan 14, 2002 at 04:15:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christopher James (cjames@berkeley.innomedia.com) wrote:

> It was our expectation that the switch from the first to second
> interface  should  work without any involvement from the application
> because the second interface is configured exactly the same as the
> first interface.  After the switch, everything seems to work with the
> exception of multicasting:  the multicast membership information is not
> propagated to the second interface, it stays with the first interface.

i don't think this is a valid expectation.  joining a multicast group
is a device specific action.  when you join, you either specify an
interface to join on (imr_interface=dev_ip_addr) or let the kernel choose
(imr_interface=INADDR_ANY).  in either case, you are telling some hardware
to adjust its multicast filter and identifying that hardware by a unique
device index.  as alexey mentioned, it sounds like your app has never told
the second interface that is should even care about multicast packets.
did you try joining on both interfaces?  (you may find using a unique
service ip addr on each interface, and failing over an application ip
addr using aliases will help)

cheers,
-chris
