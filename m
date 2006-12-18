Return-Path: <linux-kernel-owner+w=401wt.eu-S1753731AbWLRK1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbWLRK1I (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753734AbWLRK1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:27:08 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2051 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbWLRK1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:27:07 -0500
Date: Mon, 18 Dec 2006 10:26:53 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove logically superfluous comparisons from Kconfig files.
Message-ID: <20061218102653.GA23947@flint.arm.linux.org.uk>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0612180509010.22527@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612180509010.22527@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 05:14:01AM -0500, Robert P. J. Day wrote:
>   Remove Kconfig comparisons of the form FUBAR || FUBAR=n, since they
> appear to be superfluous.

config FOO
	tristate 'foo'
	depends on BAR || BAR=n

is not superfluous.  The allowed states for FOO with the above construct
are (assuming modules are enabled):

	BAR	FOO
	Y	Y,M,N
	M	M,N
	N	Y,M,N

Also, you create some constructs such as:

        depends on && PCI

which is obviously wrong.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
