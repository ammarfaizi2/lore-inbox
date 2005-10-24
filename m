Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVJXV6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVJXV6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 17:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVJXV6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 17:58:04 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:23566 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751323AbVJXV6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 17:58:02 -0400
Date: Mon, 24 Oct 2005 17:57:53 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch 2.6.13 0/5] normalize calculations of rx_dropped
Message-ID: <20051024215751.GH28212@tuxdriver.com>
Mail-Followup-To: Ben Greear <greearb@candelatech.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>
References: <09122005104858.332@bilbo.tuxdriver.com> <4325CEAB.2050600@pobox.com> <20050912191419.GB19644@tuxdriver.com> <435D53AE.3020401@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435D53AE.3020401@candelatech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 02:35:42PM -0700, Ben Greear wrote:

> It doesn't matter too much to me either way, but I'd like for there to
> be a precisely documented definition for the various net-stats so that
> I can correctly show the values to user-space (I can certainly add 
> rx_discards
> to rx_errors for a 'total rx errors' value, but I need to know whether
> rx_discards is already in rx_errors to keep from counting things twice.)

My opinion is that:

	-- rx_errors should count all "on the wire" hardware errors;

	-- rx_missed_errors should count frames w/ no "on the wire"
	errors that cannot be received by the hardware (generally
	due to lack of DMA bufers); and,

	-- rx_discards should count frames dropped by the kernel
	after successful reception by the hardware.

I do _not_ think rx_missed_errors should be counted as part of
rx_errors, but I could be persuaded otherwise.

> Jeff:  Could you lay down the law somewhere in the Documentation/
> directory and then let us start fixing any driver that does it differently?

It does seem like a netdev stats clarification doc would be
appropriate.  Does anyone have the beginnings of this?

John
-- 
John W. Linville
linville@tuxdriver.com
