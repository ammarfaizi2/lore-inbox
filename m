Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVDDVKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVDDVKe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVDDVIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:08:19 -0400
Received: from peabody.ximian.com ([130.57.169.10]:37079 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261406AbVDDVEb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:04:31 -0400
Subject: Re: [patch] inotify 0.22
From: Robert Love <rml@novell.com>
To: Dale Blount <linux-kernel@dale.us>
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1112647855.520.20.camel@dale.velocity.net>
References: <1112644936.6736.7.camel@betsy>
	 <1112647855.520.20.camel@dale.velocity.net>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 17:04:19 -0400
Message-Id: <1112648659.7324.4.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 16:50 -0400, Dale Blount wrote:

Hi, Dale.

> Will inotify watch directories recursively?  A quick browse through the
> source doesn't look like it, but I very well could be wrong.  Last I
> checked, dnotify did not either.  I am looking for a way to synchronize
> files in as-real-as-possible-time when they are modified.

No, inotify does not support watching directories recursively.  I would
love to add it, but it would be a mess to do inside of the kernel.

Making it easy and efficient to watch a full tree, however, was a goal
of inotify.  Beagle, a personal indexing infrastructure, watches the
user's entire home directory.

You could never do this in dnotify because you would run out of file
descriptors and pin every file.

In inotify, it is not hard to write a simple recursive loop to add a
watch to each directory starting at a given path.  It can even be done
in an atomic fashion.  See

	http://mail.gnome.org/archives/dashboard-hackers/2004-October/msg00022.html

wherein I publish such an algorithm.

Hope this helps,

	Robert Love


