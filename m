Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbUBXE0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 23:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbUBXE0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 23:26:23 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:56161 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262156AbUBXE0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 23:26:22 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: strosake@austin.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch-specific callout in panic() 
In-reply-to: Your message of "Mon, 23 Feb 2004 12:33:09 MDT."
             <403A4765.8010908@austin.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Feb 2004 15:25:30 +1100
Message-ID: <5298.1077596730@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004 12:33:09 -0600, 
Mike Strosaker <strosake@austin.ibm.com> wrote:
>Andrew Morton wrote:
>> We have the panic_notifier_list in there.  Cannot you hook into that?
>
>panic_notifier_list is not used becasue we need to ensure that the
>actions in machine_panic are the last ones taken.

panic_notifier_list, like all entries defined via
notifier_chain_register, is run in priority order, with LIFO order
within priority.  Register machine_panic first with priority INT_MIN
and it gets called last.

Which reduces your problem to "which one of the 57 initcall levels do I
use for registering machine_panic first on the panic_notifier_list"?

