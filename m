Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWHGQTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWHGQTV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWHGQTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:19:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:53598 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932196AbWHGQTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:19:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ub9uk1jMp9nqy5aZPt/Vb7OzPo0c5vwpGZxi/wsGEnkfQ4xO02XCxlShHuMO6vPZpMozpjcH8mq8+V2ypwqR5Yjx3pFOPhtIP1eiNsepJmGSsTuC2V3ULA7vGC8HRkfsxrNngNS9qjy6tqcRgv8QwEBK/5t8HuezznwBjSmqlYs=
Message-ID: <41840b750608070919p7d12db55u683f42358096cefa@mail.gmail.com>
Date: Mon, 7 Aug 2006 19:19:19 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: [PATCH 05/12] hdaps: Remember keyboard and mouse activity
Cc: "Robert Love" <rlove@rlove.org>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060807141120.GI4032@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492613229-git-send-email-multinymous@gmail.com>
	 <20060807141120.GI4032@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/06, Pavel Machek <pavel@suse.cz> wrote:
> > When the current hdaps driver is queried for recent keyboard/mouse activity
> > (which is provided by the hardware for use in disk parking daemons), it
> > simply returns the last readout. However, every hardware query resets the
> > activity flag in the hardware, and this is triggered by (almost) any
> > hdaps sysfs attribute read, so the flag could be reset before it is
> > observed and is thus nearly useless.
> >
> > This patch makes the activities flags persist for 0.1sec, by remembering
> > when was the last time we saw them set. This gives apps like the hdaps
> > daemon enough time to poll the flag.

> And should not hdapsd get it from input interface?

At this point the disk may parked and its queue frozen, and may depend
on the keyboard/mouse activity to be released. So hdapsd mustn't do
anything that involves potential swapping or userspace with unlocked
memory, and the input infrastructure is too large and flexible for
such a guarantee. I guess this is why IBM provided this low-level hook
at the embedded controller level.

  Shem
