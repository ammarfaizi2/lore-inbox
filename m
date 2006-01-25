Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWAYW4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWAYW4D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWAYW4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:56:03 -0500
Received: from mx.pathscale.com ([64.160.42.68]:64397 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932204AbWAYW4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:56:01 -0500
Subject: Re: [openib-general] Re: RFC: ipath ioctls and their replacements
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20060125224311.GG27845@granada.merseine.nu>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	 <1138228361.15295.55.camel@serpentine.pathscale.com>
	 <20060125224311.GG27845@granada.merseine.nu>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 25 Jan 2006 14:55:55 -0800
Message-Id: <1138229756.15295.75.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-26 at 00:43 +0200, Muli Ben-Yehuda wrote:

> If this is all it does, why not keep it as a device file, where open()
> assigns the resources, read() returns them, and close() frees them? no
> ioctl necessary.

Since the char special file doesn't currently implement a read() method,
I can go that way, but the result will either end up being a function
that does a copy_to_user of two bytes, or (if we ever find we need
another ioctl-like thing) it will become an ioctl in all but name.

This is the position the current infiniband code is in.  There are
special files with read methods defined that are exactly and precisely
ioctl and nothing else, as far as I can tell, presumably because the
resistance to using ioctl was so high.  I'd rather call a spade a spade.

	<b

