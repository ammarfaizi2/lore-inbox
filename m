Return-Path: <linux-kernel-owner+w=401wt.eu-S932706AbWLNNWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbWLNNWh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbWLNNWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:22:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47367 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932706AbWLNNWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:22:37 -0500
Date: Thu, 14 Dec 2006 08:22:24 -0500
From: Dave Jones <davej@redhat.com>
To: Daniel Drake <dsd@gentoo.org>
Cc: davej@codemonkey.org.uk, linux list <linux-kernel@vger.kernel.org>
Subject: Re: amd64 agpgart aperture base value
Message-ID: <20061214132224.GD17565@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Daniel Drake <dsd@gentoo.org>, davej@codemonkey.org.uk,
	linux list <linux-kernel@vger.kernel.org>
References: <4580C954.103@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4580C954.103@gentoo.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 10:47:32PM -0500, Daniel Drake wrote:

 > In amd64-agp.c, would it be dangerous to remove the "aperture base > 4G" 
 > thing and instead simply only read the rightmost 7 bits to ensure the 
 > aperture base is always in range? (This is coming from someone with 
 > little AGPGART understanding...)

Ignoring the high bits is the wrong thing to be doing.
The BIOS placed the aperture in one place, and by masking bits, you're going
to be assuming its somewhere else, and scribbling over who knows what.

 > Alternatively do you have other suggestions for how the problem might be 
 > solved better?

If the aperture is placed above 4G, we should deal with it. Currently, we
don't. (See the AGP patches Linus merged just before 2.6.19 was released
that work around this for intel-agp).

Just needs someone to find the time to write the code to do it, and test it.

		Dave

-- 
http://www.codemonkey.org.uk
