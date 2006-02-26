Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWBZO6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWBZO6E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 09:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWBZO6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 09:58:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:43686 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751152AbWBZO6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 09:58:03 -0500
Date: Sun, 26 Feb 2006 14:57:51 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Chris Wright <chrisw@sous-sol.org>, stable@kernel.org,
       Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [stable] [PATCH 1/2] sd: fix memory corruption by sd_read_cache_type
Message-ID: <20060226145751.GR27946@ftp.linux.org.uk>
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de> <20060225021009.GV3883@sorel.sous-sol.org> <4400E34B.1000400@s5r6.in-berlin.de> <Pine.LNX.4.64.0602251600480.22647@g5.osdl.org> <1140930888.3279.4.camel@mulgrave.il.steeleye.com> <20060226053138.GM27946@ftp.linux.org.uk> <1140964451.3337.5.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140964451.3337.5.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 08:34:10AM -0600, James Bottomley wrote:
> Well, OK, I agree allowing us to request data longer than the actual
> buffer is a problem.  However, I don't exactly see how this actually
> causes corruption, since even the initio bridge only sends 12 bytes of
> data, so we should stop with a data underrun at that point (however big
> the buffer is)

scsi_mode_sense() does memset(buffer, 0, len).  You don't need corrupting
data to come from device - 10Kb of zeroes into 512-byte kmalloc'ed buffer
will do the job just fine...
 
ACKed in that form.
