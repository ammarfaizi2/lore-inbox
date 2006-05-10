Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWEJW6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWEJW6i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWEJW6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:58:38 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:15296 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751469AbWEJW6i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:58:38 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] swsusp: support creating bigger images (rev. 2)
Date: Thu, 11 May 2006 00:58:18 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, pavel@suse.cz
References: <200605021200.37424.rjw@sisk.pl> <200605100015.53455.rjw@sisk.pl> <20060509152713.36bb94f0.akpm@osdl.org>
In-Reply-To: <20060509152713.36bb94f0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605110058.19458.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 May 2006 00:27, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > Now if the mapped pages that are not mapped by the
> >  current task are considered, it turns out that they would change only if they
> >  were reclaimed by try_to_free_pages().  Thus if we take them out of reach
> >  of try_to_free_pages(), for example by (temporarily) moving them out of their
> >  respective LRU lists after creating the image, we will be able to include them
> >  in the image without copying.
> 
> I'm a bit curious about how this is true.  There are all sorts of way in
> which there could be activity against these pages - interrupt-time
> asynchronous network Tx completion, async interrupt-time direct-io
> completion, tasklets, schedule_work(), etc, etc.

AFAIK, many of these things are waited for uninterruptibly, and uninterruptible
tasks cannot be frozen.  Theoretically we may have a problem if there's an
interruptible task that waits for the completion of an operation that gets
finished after snapshotting the system.  However that would have to survive the
syncing of filesystems, freezing of kernel threads, freeing of memory as well
as suspending and resuming all devices.  [In which case it would be starving
to death. :-)]

Greetings,
Rafael
