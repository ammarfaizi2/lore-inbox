Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTLPUoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 15:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTLPUoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 15:44:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:1943 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262104AbTLPUoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 15:44:18 -0500
Date: Tue, 16 Dec 2003 12:44:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linda Xie <lxiep@us.ibm.com>
cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@us.ibm.com>,
       scheel@us.ibm.com, wortman@us.ibm.com
Subject: Re: PATCH -- kobject_set_name() doesn't allocate enough space
In-Reply-To: <3FDF67ED.1070605@us.ltcfwd.linux.ibm.com>
Message-ID: <Pine.LNX.4.58.0312161241570.1599@home.osdl.org>
References: <3FDF67ED.1070605@us.ltcfwd.linux.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Dec 2003, Linda Xie wrote:
>
> The sapce allocated in kobject_set_name() is 1 byte less than it should
> be. The Attached patch fixes this bug.

Good catch - it _should_ mean that long names always had the last byte cut
off. Why didn't anybody notice? Are people just not using long names?

> Comments are welcome.

The patch looks correct, but you should change the last test to be
appropriate too, ie the

	/* Still? Give up. */
	if (need > limit) {

test should, as far as I can tell, be

	if (need >= limit) {

instead.

		Linus
