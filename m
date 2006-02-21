Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWBUPVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWBUPVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 10:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWBUPVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 10:21:05 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:13966 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S932303AbWBUPVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 10:21:04 -0500
Date: Tue, 21 Feb 2006 17:21:02 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, axboe@suse.de, karim@opersys.com
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060221152102.GA20835@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Mathieu Desnoyers <compudj@krystal.dyndns.org>,
	Tom Zanussi <zanussi@us.ibm.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, axboe@suse.de, karim@opersys.com
References: <20060219171748.GA13068@linux-sh.org> <20060219175623.GA2674@kroah.com> <20060219185254.GA13391@linux-sh.org> <17401.21427.568297.830492@tut.ibm.com> <20060220130555.GA29405@Krystal> <20060220171531.GA9381@linux-sh.org> <20060220173732.GA7238@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220173732.GA7238@Krystal>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 12:37:32PM -0500, Mathieu Desnoyers wrote:
> Those inode operations are generic enough to eventually be integrated to
> relayfs. The poll is enhanced to support multiple readers. For the ioctl, it's
> just a matter of getting/pulling buffer segments, reading the number of
> subbuffers and their size, which I think really fits the i/o control purpose for
> such a file.
> 
Wait a minute, you're talking about inode operations, but then talking
about poll() and ioctl(), which are clearly file operations. Can you
clarify what exactly it is you want to overload? Changing inode
operations seems like a really bad design decision..

> debugfs seems to offer really too much flexibility for what LTTng needs. It
> doesn't really have to redefine "new" operations : the poll/ioctl used by LTTng
> could in fact be integrated into RelayFS and simplify the file reading
> operation.
> 
Too much flexibility is not something people usually argue as a a point
against adoption, especially for something as lightweight as debugfs,
that's certainly a new one :-)

If you're talking about struct file_operations, then it would seem you
would be best off sticking with debugfs. If the improved file operations
are suitable for kernel/relay.c then they can be integrated there and
then you don't have to worry about overloading the normal
relay_file_operations through some helper functions to hand off to
debugfs..

If you add native debugfs helper functions for creating relay files and
working in line with CONFIG_RELAY, then I'm sure these can be rolled back
in to debugfs proper, which should ease some of the LTTng maintenance.

I don't really see what having your own mount point and stubbed file
system would buy you over this..
