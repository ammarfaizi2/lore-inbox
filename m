Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272279AbTHDXDs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272284AbTHDXDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:03:48 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:46273 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S272279AbTHDXDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:03:46 -0400
Date: Mon, 4 Aug 2003 18:58:19 -0400
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-ID: <20030804225819.GA23512@pimlott.net>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>, aebr@win.tue.nl,
	linux-kernel@vger.kernel.org
References: <20030804141548.5060b9db.skraw@ithnet.com> <20030804134415.GA4454@win.tue.nl> <20030804155604.2cdb96e7.skraw@ithnet.com> <Pine.SOL.4.56.0308041458500.22102@orange.csi.cam.ac.uk> <20030804165002.791aae3d.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804165002.791aae3d.skraw@ithnet.com>
User-Agent: Mutt/1.3.28i
From: Andrew Pimlott <andrew@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 04:50:02PM +0200, Stephan von Krawczynski wrote:
> There is a flaw in this argument. If I am told that mount --bind
> does just about what I want to have as a feature then these
> applictions must have the same problems already (if I mount
> braindead). So an implementation in fs cannot do any _additional_
> damage to these applications, or not?

There is a flaw in this flaw.  :-)

/tmp# mkdir a
/tmp# mkdir a/b
/tmp# mkdir a/c
/tmp# mount --bind a a/b
/tmp# ls a  
b  c
/tmp# ls a/b
b  c
/tmp# ls a/b/b/
/tmp#

It is enlightening in this regard to consider the difference between
using unix /etc/fstab and Hurd translators to manage your namespace.

In preparing this example, I discovered that find and ls -R already
have hard-link cycle "protection" built in, so they are broken in
the presence of bind mounts.  :-(

Andrew
