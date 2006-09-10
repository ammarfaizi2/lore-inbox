Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWIJSO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWIJSO2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 14:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWIJSO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 14:14:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24463 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932346AbWIJSO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 14:14:27 -0400
Date: Sun, 10 Sep 2006 11:12:49 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Containers <containers@lists.osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] usb: Fixup usb so it uses struct pid
Message-Id: <20060910111249.c2e9c5f2.zaitcev@redhat.com>
In-Reply-To: <m1hczgfi3h.fsf@ebiederm.dsl.xmission.com>
References: <m1hczgfi3h.fsf@ebiederm.dsl.xmission.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.2; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Sep 2006 22:42:10 -0600, ebiederm@xmission.com (Eric W. Biederman) wrote:

> The problem by remember a user space process by it's pid it is
> possible that the process will exit, pid wrap around will occur and a
> different process will appear in it's place.

... which is completely all right in this case. We used to have an
implementation which tried to hold onto the task_struct and that sucked.
It is only possible for the task to disappear without notifying devio
under very special conditions only, which involve forking with parent
exiting. In other words, even a buggy application won't trigger this
without deliberately trying. And when it happens, uid checks make sure
that other users are not affected.

>  Holding a reference
> to a struct pid avoid that problem, and paves the way
> for implementing a pid namespace.

That may be useful.

The patch itself seems straightforward if we can trust your struct
pid thingies. If OpenVZ people approve, I don't mind.

-- Pete
