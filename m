Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272236AbTHNHys (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 03:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272238AbTHNHys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 03:54:48 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:44562 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272236AbTHNHyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 03:54:47 -0400
Date: Thu, 14 Aug 2003 08:54:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Pavel Machek <pavel@suse.cz>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] call drv->shutdown at rmmod
Message-ID: <20030814085442.A21232@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Pavel Machek <pavel@suse.cz>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <m1he4kzpiy.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1he4kzpiy.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Thu, Aug 14, 2003 at 01:06:45AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 01:06:45AM -0600, Eric W. Biederman wrote:
> 
> At the kexec BOF at OSDL there was some discussion on calling the
> device shutdown method at module remove time, in addition to calling
> it during reboot.  The driver was the observation that the primary
> source of problems in booting linux from linux are drivers with bad
> or missing drv->shutdown() routines.  The hope is this will increase
> the testing so people can get it right and kexec can become more
> useful.  In addition to making normal reboots more reliable.
> 
> The following patch is an implementation of that idea it calls drv->shutdown()
> before calling drv->remove().  If drv->shutdown() is implemented.

Sounds really confusing.  And having shutdown maybe called before remove
but not always sounds like a design mistake.

Why do we have shutdown at all?  Can't we just call ->remove on shutdown
so the device always get's into proper unitialized state on shutdown, too?

