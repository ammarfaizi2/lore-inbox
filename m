Return-Path: <linux-kernel-owner+w=401wt.eu-S932440AbXAGI7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbXAGI7Q (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 03:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbXAGI7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 03:59:15 -0500
Received: from gw.goop.org ([64.81.55.164]:45910 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932440AbXAGI7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 03:59:14 -0500
Message-ID: <45A0B660.4060505@goop.org>
Date: Sun, 07 Jan 2007 00:59:12 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Rene Herman <rene.herman@gmail.com>
CC: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] romsignature/checksum cleanup
References: <458EEDF7.4000200@gmail.com>  <458F20FB.7040900@gmail.com> <1167179512.16175.4.camel@localhost.localdomain> <459310A3.4060706@vmware.com> <459ABA2F.6070907@gmail.com> <459EDDD1.6060208@goop.org> <459F1B82.6000808@gmail.com>
In-Reply-To: <459F1B82.6000808@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> In your opinion, is the attached (versus 2.6.20-rc3) better? This uses
> probe_kernel_address() for all accesses. Or rather, an expanded
> version thereof. The set_fs() and pagefault_{disable,enable} calls are
> only done once in probe_roms().
>
> Accessing the length byte at rom[2] with __get_user() is overkill
> after just checking the signature at 0 and 1 but direcly accessing
> only that makes for inconsistent code IMO. It's only a .fixup entry...
>
> I can't say I'm all that sure that that pagefault_disable() call is
> still applicable now that it got expanded into the probe_roms() stage? 

I don't think this is worthwhile.  Its hardly a performance-critical
piece of code, and I think its better to use the straightforward
interface rather than complicating it for some nominal extra efficiency.

    J
