Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWEYEQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWEYEQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWEYEQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:16:45 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:36832 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S964986AbWEYEQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:16:45 -0400
Subject: Re: [PATCH 2/2] microcode update driver rewrite
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Shaohua Li <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Tigran Aivazian <tigran@veritas.com>,
       Rajesh Shah <rajesh.shah@intel.com>,
       "Van De Ven, Arjan" <arjan@linux.intel.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060525040557.GA30175@kroah.com>
References: <1148529049.32046.103.camel@sli10-desk.sh.intel.com>
	 <20060525040557.GA30175@kroah.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 06:16:37 +0200
Message-Id: <1148530597.3052.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 21:05 -0700, Greg KH wrote:
> On Thu, May 25, 2006 at 11:50:49AM +0800, Shaohua Li wrote:
> > This is the rewrite of microcode update driver. Changes:
> > 1. trim the code
> 
> Hm, but the code is now bigger.

... because of the compat stuff. Maybe that should be split into a
separate file after some time.


> Don't use request_firmware, use request_firmware_nowait() instead.  That
> way you never stall.  You only want to update the firmware when
> userspace tells you to, not for every boot like I think this will do.

this isn't persistent firmware, it's microcode. That is volatile, to the
point that if you reboot (but that effect is also achieved at cpu S3 or
do cpu hotplug) you need to reload it. These types of events are
something the kernel knows about in general, but userspace.. not so.
(esp since you generally want to load microcode as early as possible)

