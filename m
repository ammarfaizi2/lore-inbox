Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269291AbUJFPSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269291AbUJFPSY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269286AbUJFPSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:18:24 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:16794 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S269292AbUJFPSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:18:03 -0400
Date: Wed, 6 Oct 2004 17:18:01 +0200
From: bert hubert <ahu@ds9a.nl>
To: Joris van Rantwijk <joris@eljakim.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041006151801.GA6950@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Joris van Rantwijk <joris@eljakim.nl>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 04:52:27PM +0200, Joris van Rantwijk wrote:
> Hello,
> 
> I have a problem where the sequence of events is as follows:
>  - application does select() on a UDP socket descriptor
>  - select returns success with descriptor ready for reading
>  - application does recvfrom() on this descriptor and this recvfrom()
>    blocks forever

This can happen, and is fully to be expected. For a host of reasons the
packet might not in fact appear. Whenever using select for non-blocking IO
always set your sockets to non-blocking as well.

One of the legitimate reasons is the reception of packets which, on copying,
turn out to have a bad checksum.

Stevens has a section on this, recommended reading.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
