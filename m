Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVLHKQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVLHKQn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 05:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVLHKQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 05:16:43 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54734 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750862AbVLHKQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 05:16:43 -0500
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Al Boldi <a1426z@gawab.com>
Subject: Re: [RFC] ip / ifconfig redesign
References: <200512022253.19029.a1426z@gawab.com>
	<20051202211920.GJ13985@lug-owl.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 08 Dec 2005 03:15:51 -0700
In-Reply-To: <20051202211920.GJ13985@lug-owl.de> (Jan-Benedict Glaw's
 message of "Fri, 2 Dec 2005 22:19:20 +0100")
Message-ID: <m164pzc2so.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

> On Fri, 2005-12-02 22:53:19 +0300, Al Boldi <a1426z@gawab.com> wrote:
>
>> The obvious benefit here, would be the transparent ability for apps to bind 
>> to addresses, regardless of the link existence.
>
> # echo 1 > /proc/sys/net/ipv4/ip_nonlocal_bind
>
> and/or bind to address 0 (aka 0.0.0.0) instead of a given IP address.

Or equally:
	int opt = 1;
	setsockopt(fd, IPFREEBIND, &opt, sizeof(opt));
in your application.

It's cool the backwards compatibility is so good no one even
noticed it was implemented :)
And from the kernel source as to why this behaviour is not
the default.

	/* Not specified by any standard per-se, however it breaks too
	 * many applications when removed.  It is unfortunate since
	 * allowing applications to make a non-local bind solves
	 * several problems with systems using dynamic addressing.
	 * (ie. your servers still start up even if your ISDN link
	 *  is temporarily down)
	 */

Eric
